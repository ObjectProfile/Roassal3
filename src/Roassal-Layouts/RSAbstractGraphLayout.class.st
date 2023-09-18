"
It offers methods for initializing the layout, performing layout computations, and updating the positions of nodes and edges based on the chosen algorithm.
"
Class {
	#name : #RSAbstractGraphLayout,
	#superclass : #RSLineDrivenLayout,
	#instVars : [
		'verticalGap',
		'horizontalGap',
		'cachedChildren',
		'cachedParents',
		'cachedParentsWithHighestNestings',
		'shouldValidateCycles',
		'childrenSortBlock'
	],
	#category : #'Roassal-Layouts-ByConnection'
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
		userDefinedLines: edges;
		applyOn: elements
]

{ #category : #constants }
RSAbstractGraphLayout class >> verticalGap [

	^20.0
]

{ #category : #private }
RSAbstractGraphLayout >> allChildrenFor: aNode [
	| scan scanTop |
	scan := OrderedCollection withAll: (self childrenFor: aNode).
	scanTop := 1.
	[scanTop > scan size]
		whileFalse: [scan addAll: (self childrenFor:  (scan at: scanTop)).
			scanTop := scanTop + 1].
	^ scan
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
		ifAbsentPut: [ | nodes |
			nodes := OrderedCollection new.
			self edgesDo: [:edge |
				(edge from == aNode and: [edge to ~= aNode]) ifTrue: [
					(nodes includes: edge from)
						ifFalse: [nodes add: edge to ]
				]
			].
			self sortCollection: nodes.
			nodes]
]

{ #category : #private }
RSAbstractGraphLayout >> childrenFor: aNode except: aNodeCollection [
	^ (self childrenFor: aNode)
		reject: [:each | aNodeCollection includes: each]

	"we are explicitly not using the default Collection>>difference: behavior here because we want to preserve the order of the collection"
]

{ #category : #accessing }
RSAbstractGraphLayout >> childrenSortBlock [
	^ childrenSortBlock
]

{ #category : #accessing }
RSAbstractGraphLayout >> childrenSortBlock: aBlock [
	childrenSortBlock := aBlock
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

{ #category : #defaults }
RSAbstractGraphLayout >> defaultChildrenSortBlock [
	^ nil
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

{ #category : #initialization }
RSAbstractGraphLayout >> initialize [
	super initialize.
	self doNotValidateCycles.
	self childrenSortBlock: self defaultChildrenSortBlock
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

{ #category : #hook }
RSAbstractGraphLayout >> on: el edges: edgs [
	"Do the layout of the elements tacking into account the provided edges"
	self userDefinedLines ifNil: [ self userDefinedLines: edgs ].

	^ self applyOn: el
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
		(self parentsFor: node) isEmpty ]
]

{ #category : #hook }
RSAbstractGraphLayout >> rootNodesFromCycles: shapes [
	| graph groups  |
	graph := RSDSMGraph new: shapes size.
	shapes doWithIndex: [ :shape :index1 |
		shape outgoingShapes do: [ :otherShape | | index2 |
			index2 := shapes indexOf: otherShape.
			"added only when index2 is valid"
			index2 == 0 ifFalse: [ graph addEdge: index1 to: index2 ].
			 ].
		 ].
	groups := graph computeSCCs.
	"this takes all cycles and put them as roots"
	"a cycle is detected when group size is more than 1"
	^ (groups flatCollect: [ :group | 
		group size > 1
			ifTrue: [ group collect: [ :i | shapes at: i ] ]
			ifFalse: [#()]
		] as: Set) asOrderedCollection.
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

{ #category : #hook }
RSAbstractGraphLayout >> sortCollection: nodes [
	self childrenSortBlock
		ifNotNil: [ :block | nodes sort: block ]
]

{ #category : #private }
RSAbstractGraphLayout >> validateCachedParents [
	self shouldValidateCycles ifFalse: [ ^ self ].
	self cachedParents keysDo: [ :node |
		self validateCycleFor: node path: Set new ]
]

{ #category : #private }
RSAbstractGraphLayout >> validateCycleFor: node path: aSet [
	(aSet includes: node)
		ifTrue: [ self error: 'cycle with: ', aSet asString ].
	aSet add: node.
	(self parentsFor: node) do: [ :parent| self validateCycleFor: parent path: aSet ]
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
