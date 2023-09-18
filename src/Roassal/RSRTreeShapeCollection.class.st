"
An R-tree for Roassal
"
Class {
	#name : #RSRTreeShapeCollection,
	#superclass : #RSShapeCollection,
	#instVars : [
		'root'
	],
	#category : #'Roassal-Rendering'
}

{ #category : #visiting }
RSRTreeShapeCollection >> accept: visitor [
	root accept: visitor
]

{ #category : #adding }
RSRTreeShapeCollection >> add: newObject [
	root := root addChild: newObject.
	^ newObject
]

{ #category : #adding }
RSRTreeShapeCollection >> add: aShape before: otherShape [
	"do nothing"
]

{ #category : #'private - removing' }
RSRTreeShapeCollection >> balanceRemovedPath: path [
	"| times |
	times := 0.
	self haltIf: path last value contents model = 53."
	(1 to: path size -2) reverseDo: [ :index | | tree |
		tree := (path at: index) value.
		tree height: (tree left height max: tree right height)+1.
		tree isBalanced ifFalse: [ | toMove brother |
			"times := times + 1."
			tree left height < tree right height ifTrue: [
				toMove := tree left.
				brother := tree right.
			] ifFalse: [
				toMove := tree right.
				brother := tree left ].
			tree fromNode: brother.
			toMove do: [ :shape | tree addChild: shape ].
			"this means that when you remove a node,
			 in order to keed it balanced
			maybe you can move a lot of nodes"
		].
	].
	"(path last value contents model asString, ' - ', times asString, ' times') traceCr."
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
	root := RSRNilNode new
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

{ #category : #'shapes - ordering' }
RSRTreeShapeCollection >> pushBack: aShape [
	"no need it shape contains its own order"
]

{ #category : #'shapes - ordering' }
RSRTreeShapeCollection >> pushFront: aShape [
	"no need it aShape contains its own order with aShape shapeIndex"
]

{ #category : #accessing }
RSRTreeShapeCollection >> rectangle [
	^ root rectangle
]

{ #category : #removing }
RSRTreeShapeCollection >> remove: oldObject ifAbsent: anExceptionBlock [
	| path |
	path := root searchPath: oldObject.
	path ifEmpty: [ ^ anExceptionBlock value ].
	path size = 1 ifTrue: [
		root := RSRNilNode new.
	] ifFalse: [
		self removeLastNodeInPath: path.
	].

	^ path last value contents
]

{ #category : #'private - removing' }
RSRTreeShapeCollection >> removeLastNodeInPath: path [
	| last parent isRight brother |
	last := path last.
	parent := path nextToLast value.
	isRight := last key.
	last := last value.
	brother := isRight ifTrue: [ parent left ] ifFalse: [ parent right ].

	parent fromNode: brother.
	path size < 3 ifTrue: [ ^ self ].
	self balanceRemovedPath: path
]

{ #category : #accessing }
RSRTreeShapeCollection >> root [
	^ root
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtPoint: aPoint [

	| res |
	"very important to preserv the drawing order"
	res := RSGroup new.
	root nodesWithPoint: aPoint list: res.
	res := res collect: [ :s | s -> s indexesArray ].

	self sortResultList: res.

	^ res collect: [ :assoc | assoc key ]
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtRectangle: aRectangle [
	| res |
	res := RSGroup new.
	root nodesIntersetcsRectangle: aRectangle list: res.
	res sort: [:a :b | a shapeIndex < b shapeIndex ].
	^ res
]

{ #category : #public }
RSRTreeShapeCollection >> shouldSwap: anAssociation and: anAssociation2 [ 
	
	| v1 v2 size|
	v1 := anAssociation value.
	v2 := anAssociation2 value.

	size := v1 size min: v2 size.
	1 to: size do: [ :i| |index1 index2|
		index1 := v1 at: i.
		index2 := v2 at: i.
		index1 = index2 ifFalse: [ 
			^ index1 > index2 ]
	].
	^ v1 size = v2 size 
		ifTrue: [ false ]
		ifFalse: [ v1 size > v2 size  ]

]

{ #category : #public }
RSRTreeShapeCollection >> sortResultList: aCollection [

	aCollection sort: [ :a :b | 
		
		self shouldSwap: a and: b
		 ]
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> updateShape: aShape [
	self remove: aShape.
	aShape encompassingRectangle: nil.
	self add: aShape
]
