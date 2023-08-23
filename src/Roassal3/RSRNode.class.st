"
BTree node
"
Class {
	#name : #RSRNode,
	#superclass : #RSAbstractRNode,
	#instVars : [
		'contents',
		'left',
		'right',
		'rectangle',
		'height'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #'instance creation' }
RSRNode class >> new: anObject [
	^ self basicNew
		fromShape: anObject;
		yourself
]

{ #category : #visiting }
RSRNode >> accept: visitor [
	visitor visitNode: self
]

{ #category : #adding }
RSRNode >> add: anObject path: list [

	self isLeaf ifTrue: [
		left := self class new: self contents.
		right := self class new: anObject.
		height := 2.
		contents := nil.
	]ifFalse: [ | leastEnlargementChild |
		leastEnlargementChild := self leastEnlargementChild: anObject.
		list add: (right = leastEnlargementChild) -> leastEnlargementChild.
		leastEnlargementChild add: anObject path: list.
		height := (left height max: right height) + 1.
	].
	rectangle := Rectangle merging: {left rectangle. right rectangle}
]

{ #category : #adding }
RSRNode >> addChild: newObject [
	| path |
	path := OrderedCollection with: self.
	self add: newObject path: path.
	self checkPath: path.
	^ self
]

{ #category : #private }
RSRNode >> balanceZ: z y: y x: x [
	| a b c |
	c := z value.
	b := y value.
	a := x value.
	(y key and: [ x key ]) ifTrue: [
		^ self rrrotationZ: c y: b x: a ].
	(y key not and: [ x key not ]) ifTrue: [
		^ self llrotationZ: c y: b x: a ].
	(y key not and: [ x key ]) ifTrue: [
		^ self lrrotationZ: c y: b x: a ].
	"(y key and: [ x key not ])"
	^ self rlrotationZ: c y: b x: a.
	"self notYetImplemented."
]

{ #category : #utilities }
RSRNode >> bbox: aShape [
	^ aShape encompassingRectangle
]

{ #category : #adding }
RSRNode >> bulkLoad: aCollection from: a to: b [
	"a and b are indeces, used to copy part of the boxes"
	b < a ifTrue: [ ^ self error: 'should not' ].
	a = b ifTrue: [
		contents := aCollection at: a.
		rectangle := self bbox: contents.
	] ifFalse: [ | mid |
		rectangle := Rectangle merging: ((a to: b) collect: [:i |
			(aCollection at: i) encompassingRectangle ]).
		mid := (a+b/2) asInteger.
		left := self class new.
		left bulkLoad: aCollection from: a to: mid.
		right := self class new.
		right bulkLoad: aCollection from: mid + 1 to: b.
	]
]

{ #category : #private }
RSRNode >> checkPath: aCollection [
	| recomputeHeight |
	aCollection size < 3 ifTrue: [ ^ self ].
	recomputeHeight := false.
	(1 to: aCollection size - 2) reverseDo: [ :index |
		| assoc |
		assoc := aCollection at: index.
		recomputeHeight ifTrue: [
			assoc value height: (assoc value left height max: assoc value right height)+1
		] ifFalse: [
			(assoc value isBalanced) ifFalse: [ | z y x |
				z := aCollection at: index.
				y := aCollection at: index + 1.
				x := aCollection at: index + 2.
				recomputeHeight := true.
				self balanceZ: z y: y x: x.
			]
		]
	].
	"recomputeHeight ifTrue: [ root computeHeight ]"
]

{ #category : #accessing }
RSRNode >> children [
	^ {left. right} copyWithout: nil
]

{ #category : #enumerating }
RSRNode >> childrenDo: aBlock [
	left ifNotNil: aBlock.
	right ifNotNil: aBlock
]

{ #category : #enumerating }
RSRNode >> collect: aFullBlockClosure [
	| list |
	list := OrderedCollection new.
	self do: [ :each | list add: each ].
	^ list
]

{ #category : #public }
RSRNode >> computeHeight [
	height := self isLeaf
		ifTrue: [ 1 ]
		ifFalse: [ (left computeHeight max: right computeHeight) + 1 ].
	^ height
]

{ #category : #public }
RSRNode >> computeRectangle [
	rectangle := Rectangle merging: { left rectangle. right rectangle }.
	height := (left height max: right height) + 1
]

{ #category : #accessing }
RSRNode >> contents [
	^ contents
]

{ #category : #accessing }
RSRNode >> contents: aRSShape [
	contents := aRSShape
]

{ #category : #enumerating }
RSRNode >> do: aBlock [
	self isLeaf
		ifTrue: [ aBlock value: self contents ]
		ifFalse: [
			self childrenDo: [ :child | child do: aBlock ].
			 ]
]

{ #category : #initialization }
RSRNode >> fromNode: aNode [
	contents := aNode contents.
	left := aNode left.
	right := aNode right.
	rectangle := aNode rectangle.
	height := aNode height
]

{ #category : #private }
RSRNode >> fromShape: aRSShape [
	contents := aRSShape.
	height := 1.
	rectangle := self bbox: aRSShape
]

{ #category : #accessing }
RSRNode >> height [
	^ height
]

{ #category : #accessing }
RSRNode >> height: anInteger [
	height := anInteger
]

{ #category : #inspector }
RSRNode >> inspectionTree: aBuilder [
    <inspectorPresentationOrder: 1 title: 'Tree Structure'>

    ^ aBuilder newTree
        roots: { self };
        children: [ :each | each children ];
        expandRoots;
        yourself
]

{ #category : #testing }
RSRNode >> isBalanced [
	^ self isLeaf or: [ (left height - right height) abs <= 1  ]
]

{ #category : #testing }
RSRNode >> isEmpty [
	^ false
]

{ #category : #testing }
RSRNode >> isInvalid [
	^ self isLeaf and: [ self contents isNil ]
]

{ #category : #testing }
RSRNode >> isLeaf [
	^ right isNil and: [ left isNil ]
]

{ #category : #testing }
RSRNode >> isTotalBalanced [
	^ self isBalanced
		and: [ (left isNil or: [ left isTotalBalanced ])
			and: [ right isNil or: [ right isTotalBalanced ] ] ]
]

{ #category : #private }
RSRNode >> leastEnlargementChild: anRSShape [
	| minRectangleEnlargement rect leftRect rightRect leftDiff rightDiff area1 area2 |
	minRectangleEnlargement := nil.
	rect := self bbox: anRSShape.
	leftRect := Rectangle merging: {left rectangle. rect }.
	rightRect := Rectangle merging: {right rectangle. rect }.
	area1 := left rectangle area.
	area2 := right rectangle area.
	leftDiff := leftRect area - area1.
	rightDiff := rightRect area - area2.
	^ rightDiff = leftDiff
		ifTrue: [ area1 < area2
				ifTrue: [ left ]
				ifFalse: [ right ] ]
		ifFalse: [
			leftDiff < rightDiff
				ifTrue: [ left ]
				ifFalse: [ right ] ]
]

{ #category : #accessing }
RSRNode >> left [
	^ left
]

{ #category : #accessing }
RSRNode >> left: aRSRNode [
	left := aRSRNode
]

{ #category : #private }
RSRNode >> llrotationZ: z y: y x: x [
	| a3 a4 new |
	a3 := y right.
	a4 := z right.

	new := self class new.
	new left: a3; right: a4; computeRectangle.
	z left: x; right: new; computeRectangle
]

{ #category : #private }
RSRNode >> lrrotationZ: z y: y x: x [
	| a1 a2 a3 new |
	a1 := y left.
	a2 := x left.
	a3 := x right.
	new := self class new.
	new left: a1; right: a2; computeRectangle.
	y left: new; right: a3; computeRectangle.

	self llrotationZ: z y: y x: new
]

{ #category : #'finding/searching' }
RSRNode >> nodesIntersetcsRectangle: aRectangle list: aCollection [
	(self rectangle intersects: aRectangle) ifFalse: [ ^ self ].
	self isLeaf ifTrue: [ aCollection add: self contents ]
	ifFalse: [
		self childrenDo: [ :child |
			child nodesIntersetcsRectangle: aRectangle list: aCollection
			 ] ]
]

{ #category : #'finding/searching' }
RSRNode >> nodesWithPoint: aPoint list: aCollection [
	(self rectangle containsPoint: aPoint)
		ifFalse: [ ^ self ].
	self isLeaf ifTrue:[
		(self contents includesPoint: aPoint)
			ifTrue: [ aCollection add: self contents ]
	] ifFalse: [
		self childrenDo: [ :child | child nodesWithPoint: aPoint list: aCollection ]
	]
]

{ #category : #accessing }
RSRNode >> rectangle [
	^ rectangle
]

{ #category : #accessing }
RSRNode >> right [
	^ right
]

{ #category : #accessing }
RSRNode >> right: aRSRNode [
	right := aRSRNode
]

{ #category : #private }
RSRNode >> rlrotationZ: z y: y x: x [
	| a1 a2 a3 a4 new |
	a1 := z left.
	a2 := x left.
	a3 := x right.
	a4 := y right.
	new := self class new.
	new left: a3; right: a4; computeRectangle.
	y left: a2; right: new; computeRectangle.
	self rrrotationZ: z y: y x: new
]

{ #category : #private }
RSRNode >> rrrotationZ: z y: y x: x [
	"right right rotation"
	| a1 a2 new |
	a1 := z left.
	a2 := y left.
	new := self class new.
	new left: a1; right: a2; computeRectangle.
	z left: new; right: x; computeRectangle
]

{ #category : #'finding/searching' }
RSRNode >> searchPath: aRSShape [
	| path |
	path := OrderedCollection new.
	self searchPath: aRSShape rectangle: (self bbox: aRSShape) in: path dir: nil.
	^ path
]

{ #category : #'finding/searching' }
RSRNode >> searchPath: shape rectangle: shapeRect in: path dir: aBoolean [
	(self rectangle containsRect: shapeRect)
		ifFalse: [ ^ self ].
	self isLeaf ifTrue: [
		contents = shape ifTrue: [
			path addFirst: aBoolean -> self
		] ifFalse: [  ]
	] ifFalse: [
		left searchPath: shape rectangle: shapeRect in: path dir: false.
		path ifNotEmpty: [ path addFirst: aBoolean -> self. ^ self ].
		right searchPath: shape rectangle: shapeRect in: path dir: true.
		path ifNotEmpty: [ path addFirst: aBoolean -> self. ].
	 ]
]

{ #category : #'accessing - children' }
RSRNode >> withAllChildren [
	| children |
	children := OrderedCollection new.
	self accept: (RSRNodeVisitor on: [:node | children add: node ]).
	^ children
]
