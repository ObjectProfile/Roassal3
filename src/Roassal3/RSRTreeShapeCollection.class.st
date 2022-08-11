"
An R-tree for roassal3
"
Class {
	#name : #RSRTreeShapeCollection,
	#superclass : #RSShapeCollection,
	#instVars : [
		'root'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #adding }
RSRTreeShapeCollection >> add: newObject [ 
	root isNilNode 
		ifTrue: [ root := RSRNode new: newObject ]
		ifFalse: [ | path |
			path := OrderedCollection with: root.
			root add: newObject path: path.
			self checkPath: path ].
	^ newObject
]

{ #category : #private }
RSRTreeShapeCollection >> balanceZ: z y: y x: x [
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

{ #category : #private }
RSRTreeShapeCollection >> checkPath: aCollection [
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

{ #category : #enumerating }
RSRTreeShapeCollection >> do: aBlock [ 
	root do: aBlock
]

{ #category : #accessing }
RSRTreeShapeCollection >> height [
	^ root height
	
]

{ #category : #initialization }
RSRTreeShapeCollection >> initialize [
	super initialize.
	root := RSRNilNode new.
]

{ #category : #testing }
RSRTreeShapeCollection >> isBalanced [
	^ root isBalanced
]

{ #category : #testing }
RSRTreeShapeCollection >> isEmpty [
	^ root isEmpty
]

{ #category : #testing }
RSRTreeShapeCollection >> isTotalBalanced [
	^ root isTotalBalanced
]

{ #category : #private }
RSRTreeShapeCollection >> llrotationZ: z y: y x: x [ 
	| a3 a4 new |
	a3 := y right.
	a4 := z right.
	
	new := RSRNode new.
	new left: a3; right: a4; computeRectangle.
	z left: x; right: new; computeRectangle.
	
]

{ #category : #private }
RSRTreeShapeCollection >> lrrotationZ: z y: y x: x [ 
	| a1 a2 a3 new |
	a1 := y left.
	a2 := x left.
	a3 := x right.
	new := RSRNode new.
	new left: a1; right: a2; computeRectangle.
	y left: new; right: a3; computeRectangle.
	
	self llrotationZ: z y: y x: new
]

{ #category : #accessing }
RSRTreeShapeCollection >> rectangle [
	^ root rectangle
]

{ #category : #removing }
RSRTreeShapeCollection >> remove: oldObject ifAbsent: anExceptionBlock [ 
	
	^ root isNilNode
		ifTrue: anExceptionBlock
		ifFalse: [ | removedObject |
			removedObject := root remove: oldObject.
			removedObject 
				ifNil: anExceptionBlock
				ifNotNil: [
					root isInvalid
						ifTrue: [ root := RSRNilNode new ]
					]
			].
]

{ #category : #private }
RSRTreeShapeCollection >> rlrotationZ: z y: y x: x [ 
	| a1 a2 a3 a4 new |
	a1 := z left.
	a2 := x left.
	a3 := x right.
	a4 := y right.
	new := RSRNode new.
	new left: a3; right: a4; computeRectangle.
	y left: a2; right: new; computeRectangle.
	self rrrotationZ: z y: y x: new
]

{ #category : #accessing }
RSRTreeShapeCollection >> root [
	^ root
]

{ #category : #private }
RSRTreeShapeCollection >> rrrotationZ: z y: y x: x [
	"right right rotation"
	| a1 a2 new |
	a1 := z left.
	a2 := y left.
	new := RSRNode new.
	new left: a1; right: a2; computeRectangle.
	z left: new; right: x; computeRectangle.
	
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtPoint: aPoint [ 
	| res |
	res := OrderedCollection new.
	root nodesWithPoint: aPoint list: res.
	^ res
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtRectangle: aRectangle [
	| res |
	res := OrderedCollection new.
	root nodesIntersetcsRectangle: aRectangle list: res.
	^ res
]
