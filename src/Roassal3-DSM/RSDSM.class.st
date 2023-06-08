"
new version for Dependency Structural Matrix.
For a collection of objects and an arbitrary dependency function.
"
Class {
	#name : #RSDSM,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'shape',
		'objectsX',
		'objectsY',
		'dependency',
		'wantsLabels',
		'matrix',
		'rotation',
		'shouldFeedX',
		'labelShapeY',
		'labelShapeX',
		'labelsY',
		'labelsX',
		'colorBlock'
	],
	#category : #'Roassal3-DSM-Core'
}

{ #category : #'hooks - labels' }
RSDSM >> addLabels: aRSCanvas [
	self addLabelsLeft: aRSCanvas.
	self addLabelsTop: aRSCanvas
]

{ #category : #'hooks - labels' }
RSDSM >> addLabelsIfNecessary: aRSCanvas [
	self wantsLabels ifFalse: [ ^ self ].
	self addLabels: aRSCanvas
]

{ #category : #'hooks - labels' }
RSDSM >> addLabelsLeft: aRSCanvas [
	| column |
	column := self columnAt: 1.
	aRSCanvas addAll: (labelsY := column collect: [ :s | self createLabelShapeY: s ])
]

{ #category : #'hooks - labels' }
RSDSM >> addLabelsTop: aRSCanvas [
	| row |
	row := self rowAt: 1.
	aRSCanvas addAll: (labelsX := row collect: [ :s | self createLabelShapeX: s ])
]

{ #category : #accessing }
RSDSM >> color [
	^ colorBlock
]

{ #category : #accessing }
RSDSM >> color: aBlock [
	colorBlock := aBlock
]

{ #category : #'accessing - computed' }
RSDSM >> columnAt: aNumber [
	^ matrix atRow: aNumber
]

{ #category : #hooks }
RSDSM >> computeColor: tuple [
	^ (self isAssocDependent: tuple)
		ifTrue: [ self selectedColor ]
		ifFalse: [ self unSelectedColor ]
]

{ #category : #'hooks - labels' }
RSDSM >> createLabelShapeX: aRSBox [
	| label model |
	model := shouldFeedX
		ifTrue: [ aRSBox model key ]
		ifFalse: [ aRSBox model value ].
	label := self labelShapeX shapeFor: model.
	label model: model.
	label rotateByDegrees: self rotation.
	RSLocation new
		outer;
		top;
		right;
		offset: label width negated @ 0;
		move: label on: aRSBox.
	^ label
]

{ #category : #'hooks - labels' }
RSDSM >> createLabelShapeY: aRSBox [
	| label model |
	model := shouldFeedX
		ifTrue: [ aRSBox model value ]
		ifFalse: [ aRSBox model key ].
	label := self labelShapeY shapeFor: model.
	label model: model.
	RSLocation new
		outer;
		left;
		offset: -10 @0;
		move: label on: aRSBox.

	^ label
]

{ #category : #hooks }
RSDSM >> createShape: tuple [
	^ shape copy
		model: tuple;
		color: (self color cull: tuple);
		yourself
]

{ #category : #hooks }
RSDSM >> createShapeX: anObjectX y: anObjectY position: position list: list [
	| box |
	box := self createShape: (shouldFeedX
		ifTrue: [ anObjectX -> anObjectY ]
		ifFalse: [ anObjectY -> anObjectX ]).
	box propertyAt: #matrixIndex put: position.
	self setUpShape: box.
	list add: box.
	^ box
]

{ #category : #hooks }
RSDSM >> createShapes [
	| group |
	group := RSGroup new.
	matrix := Array2D rows: objectsX size columns: objectsY size.
	objectsY doWithIndex: [ :anObjectY :k |
		objectsX doWithIndex: [ :anObjectX :j |
			matrix
				at: j
				at: k
				put: (self
					createShapeX: anObjectX
					y: anObjectY
					position: j@k
					list: group)
		]
	].
	^ group
]

{ #category : #'accessing - defaults' }
RSDSM >> defaultContainer [
	^ super defaultContainer @ RSCanvasController
]

{ #category : #initialization }
RSDSM >> defaultShape [
	^ RSBox new
		size: 15;
		border: (RSBorder new color: 'white');
		@ self highlightable;
		yourself
]

{ #category : #accessing }
RSDSM >> dependency [
	^ dependency
]

{ #category : #accessing }
RSDSM >> dependency: aOneArgBlock [
	"Take either X or Y values"
	dependency := aOneArgBlock
]

{ #category : #configuration }
RSDSM >> hideLabels [
	wantsLabels := false
]

{ #category : #highlighting }
RSDSM >> highlight: evt [
	| position |
	shape := evt shape.
	position := shape propertyAt: #matrixIndex.
	self highlightRectangle: (self columnAt: position x) key: #columnRect.
	self highlightRectangle: (self rowAt: position y) key: #rowRect
]

{ #category : #highlighting }
RSDSM >> highlightRectangle: aGroupOfShapes key: key [
	| canvas rectangle box |
	canvas := aGroupOfShapes anyOne canvas.
	rectangle := 1 asMargin expandRectangle: aGroupOfShapes asGroup encompassingRectangle.

	box := RSBox new
		noPaint;
		border: (RSBorder new color: 'black');
		fromRectangle: rectangle;
		yourself.
	canvas addShape: box.
	canvas propertyAt: key put: box
]

{ #category : #highlighting }
RSDSM >> highlightable [
	^ RSHighlightable new
		when: RSHighlightEvent send: #highlight: to: self;
		when: RSUnHighlightEvent send: #unhighlight: to: self
]

{ #category : #initialization }
RSDSM >> initialize [
	super initialize.
	shape := self defaultShape.
	self
		rotation: 45;
		showLabels;
		setShouldFeedX;
		color: [ :tuple | self computeColor: tuple ];
		dependency: #yourself;
		objects: #()
]

{ #category : #testing }
RSDSM >> isAssocDependent: assoc [
	| v |
	v := dependency rsValue: assoc key.
	v = assoc value ifTrue: [ ^ true ].
	^ v isCollection
		ifTrue: [ v includes: assoc value ]
		ifFalse: [ false ]
]

{ #category : #accessing }
RSDSM >> labelShapeX [
	^ labelShapeX ifNil: [ labelShapeX := RSMultilineLabelBuilder new  ]
]

{ #category : #accessing }
RSDSM >> labelShapeY [
	^ labelShapeY ifNil: [ labelShapeY := RSMultilineLabelBuilder new  ]
]

{ #category : #accessing }
RSDSM >> labels [
	^ self labelsX, self labelsY
]

{ #category : #accessing }
RSDSM >> labelsX [
	^ labelsX ifNil: [ #() ]
]

{ #category : #accessing }
RSDSM >> labelsY [
	^ labelsY ifNil: [ #() ]
]

{ #category : #hooks }
RSDSM >> layoutShapes: aGroup [
	RSGridLayout new
		gapSize: 0;
		lineItemsCount: objectsX size;
		on: aGroup
]

{ #category : #accessing }
RSDSM >> numberOfObjects [
	^ self objects size
]

{ #category : #accessing }
RSDSM >> objects [
	^ (objectsX, objectsY) asSet
]

{ #category : #accessing }
RSDSM >> objects: someObjects [
	self
		objectsX: someObjects;
		objectsY: someObjects
]

{ #category : #accessing }
RSDSM >> objectsX [
	^ objectsX
]

{ #category : #accessing }
RSDSM >> objectsX: someObjects [
	objectsX := someObjects
]

{ #category : #accessing }
RSDSM >> objectsY [
	^ objectsY
]

{ #category : #accessing }
RSDSM >> objectsY: someObjects [
	objectsY := someObjects
]

{ #category : #hooks }
RSDSM >> renderIn: aCanvas [
	shapes := self createShapes.
	aCanvas addAll: shapes.
	self layoutShapes: shapes.
	self addLabelsIfNecessary: aCanvas
]

{ #category : #accessing }
RSDSM >> rotation [
	^ rotation
]

{ #category : #accessing }
RSDSM >> rotation: aNumberInDegrees [
	rotation := aNumberInDegrees
]

{ #category : #'accessing - computed' }
RSDSM >> rowAt: aNumber [
	^ matrix atColumn: aNumber
]

{ #category : #accessing }
RSDSM >> selectedColor [
	^ Color colorFrom: '#4d79ff'
]

{ #category : #configuration }
RSDSM >> setShouldFeedX [
	shouldFeedX := true
]

{ #category : #configuration }
RSDSM >> setShouldFeedY [
	shouldFeedX := false
]

{ #category : #hooks }
RSDSM >> setUpShape: box [
	box announcer: shape announcer
]

{ #category : #accessing }
RSDSM >> shape [
	^ shape
]

{ #category : #'accessing - computed' }
RSDSM >> shapeAt: aPoint [
	^ matrix at: aPoint y at: aPoint x
]

{ #category : #configuration }
RSDSM >> showLabels [
	wantsLabels := true
]

{ #category : #accessing }
RSDSM >> unSelectedColor [
	^ Color veryVeryLightGray
]

{ #category : #highlighting }
RSDSM >> unhighlight: evt [
	self unhighlight: evt key: #columnRect.
	self unhighlight: evt key: #rowRect
]

{ #category : #highlighting }
RSDSM >> unhighlight: evt key: key [
	| canvas |
	canvas := evt canvas.
	canvas propertyAt: key ifPresent: [ :s |
		s remove.
		canvas removeKey: key ]
]

{ #category : #testing }
RSDSM >> wantsLabels [
	^ wantsLabels
]
