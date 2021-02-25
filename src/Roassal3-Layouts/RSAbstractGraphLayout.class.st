"
TODO
"
Class {
	#name : #RSAbstractGraphLayout,
	#superclass : #RSEdgeDrivenLayout,
	#instVars : [
		'verticalGap',
		'horizontalGap',
		'cachedChildren',
		'cachedParents',
		'cachedParentsWithHighestNestings',
		'shouldValidateCycles'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #constants }
RSAbstractGraphLayout class >> horizontalGap [
	
	^3.0
]

{ #category : #testing }
RSAbstractGraphLayout class >> isAbstract [
	^ self name = #RSAbstractGraphLayout
]

{ #category : #public }
RSAbstractGraphLayout class >> on: elements edges: edges [
	"Do the layout of the elements tacking into account the provided edges"

	^ self new 
		userDefinedEdges: edges;
		applyOn: elements.
]

{ #category : #constants }
RSAbstractGraphLayout class >> verticalGap [
	
	^20.0
]

{ #category : #private }
RSAbstractGraphLayout >> cachedChildren [
	cachedChildren ifNil: [cachedChildren := IdentityDictionary new: 1000].
	^ cachedChildren
]

{ #category : #private }
RSAbstractGraphLayout >> cachedParents [
	cachedParents ifNil: [cachedParents := IdentityDictionary new: 1000].
	^ cachedParents
]

{ #category : #private }
RSAbstractGraphLayout >> cachedParentsWithHighestNestings [
	cachedParentsWithHighestNestings
		ifNil: [cachedParentsWithHighestNestings := IdentityDictionary new: 1000].
	^ cachedParentsWithHighestNestings
]

{ #category : #private }
RSAbstractGraphLayout >> childrenFor: aNode [
	^ self cachedChildren
		at: aNode
		ifAbsentPut:
			[| nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | 
					(edge from == aNode and: [edge to ~= aNode])
						ifTrue:
							[(nodes includes: edge from) ifFalse: [nodes add: edge to]]].
			nodes]
]

{ #category : #private }
RSAbstractGraphLayout >> childrenFor: aNode except: aNodeCollection [
	^ (self childrenFor: aNode) 
		reject: [:each | aNodeCollection includes: each]
	
	"we are explicitly not using the default Collection>>difference: behavior here because we want to preserve the order of the collection"
]

{ #category : #private }
RSAbstractGraphLayout >> childrenWithHighestNestingLevelFor: aNode [
	^ (self childrenFor: aNode)
		select: [:eachChild | (self highestNestingParentFor: eachChild) == aNode]
]

{ #category : #private }
RSAbstractGraphLayout >> clear [
	cachedParents := nil.
	cachedChildren := nil.
	cachedParentsWithHighestNestings := nil
]

{ #category : #hook }
RSAbstractGraphLayout >> doInitialize: elements [ 
	super doInitialize: elements.
	self clear.
	"self greedyCycleRemoval: elements"
]

{ #category : #public }
RSAbstractGraphLayout >> doNotValidateCycles [
	shouldValidateCycles := false
]

{ #category : #private }
RSAbstractGraphLayout >> highestNestingParentFor: aNodeFigure [
	| parents |
	^self cachedParentsWithHighestNestings
		at: aNodeFigure
		ifAbsentPut:
			[parents := self parentsFor: aNodeFigure.
			parents isEmpty
				ifTrue: [0]
				ifFalse:
					[parents detectMax: [:eachParent | self nestingLevelFor: eachParent]]]
]

{ #category : #accessing }
RSAbstractGraphLayout >> horizontalGap [
	"Return the horizontal space, in pixel, between two neighbors"
	^ horizontalGap ifNil: [ self class horizontalGap ]
]

{ #category : #accessing }
RSAbstractGraphLayout >> horizontalGap: anInteger [
	"Set the horizontal space, in pixel, between two neighbors"
	horizontalGap := anInteger
]

{ #category : #'initialize-release' }
RSAbstractGraphLayout >> initialize [
	super initialize.
	self validateCycles.
]

{ #category : #private }
RSAbstractGraphLayout >> maximumDiameter: aCollection [
	^ aCollection
		inject: 0
		into: [:max :node | max max: (node radius * 2) ]
 
]

{ #category : #private }
RSAbstractGraphLayout >> maximumRadius: aCollection [
	^ aCollection
		inject: 0
		into: [:max :node | max max: node radius]
]

{ #category : #private }
RSAbstractGraphLayout >> nestingLevelFor: aNodeFigure [
	| parents parentsNesting |
	parents := self parentsFor: aNodeFigure.
	parentsNesting := parents
		collect: [:eachParent | self nestingLevelFor: eachParent].
	^parentsNesting isEmpty
		ifTrue: [0]
		ifFalse: [parentsNesting max + 1]

]

{ #category : #actions }
RSAbstractGraphLayout >> on: el edges: edgs [
	"Do the layout of the elements tacking into account the provided edges"
	self userDefinedEdges ifNil: [ self userDefinedEdges: edgs ].

	^ self applyOn: el.
]

{ #category : #private }
RSAbstractGraphLayout >> parentsFor: aNode [
	^ self cachedParents
		at: aNode
		ifAbsentPut:
			[ | nodes |
			nodes := OrderedCollection new.
			self edgesDo:
					[:edge | edge to == aNode ifTrue: [ nodes add: edge from ] ].
			nodes ]
]

{ #category : #private }
RSAbstractGraphLayout >> rootNodesFor: aCollection [
	^ aCollection select: [:node | 
		(self parentsFor: node) isEmpty ].
]

{ #category : #private }
RSAbstractGraphLayout >> shiftTree: aNode by: aPoint [
	aNode translateBy: aPoint.
	(self childrenFor: aNode) do: [:child | self shiftTree: child by: aPoint]
]

{ #category : #testing }
RSAbstractGraphLayout >> shouldValidateCycles [
	^ shouldValidateCycles
]

{ #category : #private }
RSAbstractGraphLayout >> validateCachedParents [
	self shouldValidateCycles ifFalse: [ ^ self ].
	self cachedParents keysDo: [ :node | 
		self validateCycleFor: node path: Set new ].
]

{ #category : #private }
RSAbstractGraphLayout >> validateCycleFor: node path: aSet [
	(aSet includes: node)
		ifTrue: [ self error: 'cycle with: ', aSet asString ].
	aSet add: node.
	(self parentsFor: node) do: [ :parent| self validateCycleFor: parent path: aSet ].
	
]

{ #category : #public }
RSAbstractGraphLayout >> validateCycles [
	shouldValidateCycles := true
]

{ #category : #accessing }
RSAbstractGraphLayout >> verticalGap [
	"Return the vertical space, in pixel, between a layer and a children layer"
	^ verticalGap ifNil: [ self class verticalGap ]
]

{ #category : #accessing }
RSAbstractGraphLayout >> verticalGap: anInteger [
	"Set the vertical space, in pixel, between a layer and a children layer"
	verticalGap := anInteger
]
