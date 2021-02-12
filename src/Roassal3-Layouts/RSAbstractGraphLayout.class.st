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
		'cachedParentsWithHighestNestings'
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

{ #category : #battista }
RSAbstractGraphLayout >> greedyCycleRemoval: aCollection [
	"Di Battista Greedy-Cycle-Removal algorithm. Chapter 9.4, page 297. The last part is not like in the book. The original algorithm only takes
	 local optimas into account. This will break ordinary trees sometimes. This version also takes global optimas into account."
	
	| g sl sr s indeg outdeg degrees vertex | 
	g := aCollection copy asOrderedCollection.
	sl := OrderedCollection new.
	sr := OrderedCollection new.	"While g contains a sink (aka leaf)"
	g copy
		do:
			[:node | 
			(self childrenFor: node) isEmpty
				ifTrue:
					[sr addFirst: node.
					g remove: node]	"self edges detect: [:edge | edge fromFigure == node] ifNone: [sr addFirst: node. g remove: node]"].	"While g contains a source (aka root)"
	g copy
		do:
			[:node | 
			(self parentsFor: node) isEmpty
				ifTrue:
					[sl addLast: node.
					g remove: node]	"self edges detect: [:edge | edge toFigure == node] ifNone: [sl addLast: node. g remove: node]"].	"Calculate deg for all remaining vertices"
	degrees := IdentityDictionary new.
	g
		do:
			[:node | 
			indeg := (self parentsFor: node) size.
			outdeg := (self childrenFor: node) size.	"indeg := self edges inject: 0 into: [:sum :edge | (edge toFigure == node) ifTrue: [sum + 1] ifFalse: [sum]].
		outdeg := self edges inject: 0 into: [:sum :edge | (edge fromFigure == node) ifTrue: [sum + 1] ifFalse: [sum]]."
			degrees
				at: node
				put: outdeg - indeg].	"While g not empty"
	g := g asSortedCollection: [:a :b | (degrees at: a) >= (degrees at: b)].
	[g isEmpty]
		whileFalse:
			[vertex := g
				detect: [:v | (self parentsFor: v) anySatisfy: [:w | sl includes: w]]
				ifNone: [g first].	"Corner case: Closed cycle with not root at all. Eg 1 -> 2 -> 3 -> 1"
			sl addLast: vertex.
			g remove: vertex].	"Remove all leftward edges"
	s := sl , sr.
	self edges notNil
		ifTrue: 
			[ self edges copy
				do:
					[:edge | 
					(s indexOf: edge from) > (s indexOf: edge to)
						ifTrue: [self edges remove: edge ] ] ].	
	"Reset the cache"
	self clear
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

{ #category : #private }
RSAbstractGraphLayout >> validateCachedParents [
	self cachedParents keys do: [ :node | self validateCycleFor: node path: Set new ].
]

{ #category : #private }
RSAbstractGraphLayout >> validateCycleFor: node path: aSet [
	(aSet includes: node)
		ifTrue: [ self error: 'cycle with: ', aSet asString ].
	aSet add: node.
	(self parentsFor: node) do: [ :parent| self validateCycleFor: parent path: aSet ].
	
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
