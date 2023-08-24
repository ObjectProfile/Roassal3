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

{ #category : #visiting }
RSRTreeShapeCollection >> accept: visitor [
	root accept: visitor
]

{ #category : #adding }
RSRTreeShapeCollection >> add: newObject [
	root := root addChild: newObject.
	^ newObject
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
	res := OrderedCollection new.
	root nodesWithPoint: aPoint list: res.
	^ res
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> shapesAtRectangle: aRectangle [
	| res |
	res := RSGroup new.
	root nodesIntersetcsRectangle: aRectangle list: res.
	^ res
]

{ #category : #'finding/searching' }
RSRTreeShapeCollection >> updateShape: aShape [
	self remove: aShape.
	aShape encompassingRectangle: nil.
	self add: aShape
]
