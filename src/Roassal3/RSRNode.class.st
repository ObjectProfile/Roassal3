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
	^ self new
		contents: anObject;
		yourself
]

{ #category : #adding }
RSRNode >> add: anObject [ 
	self isLeaf ifTrue: [ 
		left := self class new: self contents.
		right := self class new: anObject.
		contents := nil.
	]ifFalse: [ | leastEnlargementChild |
		leastEnlargementChild := self leastEnlargementChild: anObject.
		leastEnlargementChild add: anObject.
	].
	rectangle := Rectangle merging: {left rectangle. right rectangle}.
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
	rectangle := Rectangle merging: {left rectangle. right rectangle}.
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

{ #category : #adding }
RSRNode >> bulkLoad: aCollection from: a to: b [
	b < a ifTrue: [ ^ self error: 'should not' ].
	a = b ifTrue: [
		contents := aCollection at: a.
		rectangle := contents encompassingRectangle.
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
	contents := aRSShape.
	height := 1.
	rectangle := aRSShape encompassingRectangle.
]

{ #category : #enumerating }
RSRNode >> do: aBlock [
	self isLeaf
		ifTrue: [ aBlock value: self contents ]
		ifFalse: [ 
			self childrenDo: [ :child | child do: aBlock ].
			 ]
	
]

{ #category : #accessing }
RSRNode >> height [
	^ height
]

{ #category : #accessing }
RSRNode >> height: anInteger [ 
	height := anInteger
]

{ #category : #adding }
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
	^ self isLeaf
		ifTrue: [ true ]
		ifFalse: [ (left height - right height) abs <= 1  ]
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

{ #category : #adding }
RSRNode >> leastEnlargementChild: anObject [
	| minRectangleEnlargement rect leftRect rightRect leftDiff rightDiff area1 area2 |
	minRectangleEnlargement := nil.
	rect := anObject encompassingRectangle.
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
				ifFalse: [ right ] ].	
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
	z left: x; right: new; computeRectangle.
	
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
	self isLeaf ifTrue: [ 
		(self contents encompassingRectangle intersects: aRectangle)
			ifTrue: [ aCollection add: self contents ] ]
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

{ #category : #removing }
RSRNode >> remove: anObject [
	| removedObject |
	removedObject := nil.
	self isLeaf ifTrue: [ 
		self contents = anObject ifTrue: [ 
			removedObject := contents.
			contents := nil.
			rectangle := nil.
			 ]
	] ifFalse: [ 
		self childrenDo: [ :child |
			removedObject := child remove: anObject.
			removedObject ifNotNil: [ 
				child isInvalid ifTrue: [ 
					left = child ifTrue: [ left := nil ].
					right = child ifTrue: [ right := nil ].
					 ].
				^ removedObject
			 ].
		]
	].
	
	^ removedObject
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
	z left: new; right: x; computeRectangle.
	
]
