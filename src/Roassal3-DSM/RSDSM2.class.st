"
new version for Dependency Structural Matrix.
For a collection of objects and an arbitrary dependency function.
"
Class {
	#name : #RSDSM2,
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
		'labelsX'
	],
	#category : #'Roassal3-DSM'
}

{ #category : #'hooks - labels' }
RSDSM2 >> addLabels: aRSCanvas [ 
	self addLabelsLeft: aRSCanvas.
	self addLabelsTop: aRSCanvas.
]

{ #category : #'hooks - labels' }
RSDSM2 >> addLabelsIfNecessary: aRSCanvas [ 
	self wantsLabels ifFalse: [ ^ self ].
	self addLabels: aRSCanvas
]

{ #category : #'hooks - labels' }
RSDSM2 >> addLabelsLeft: aRSCanvas [
	| column |
	column := self columnAt: 1.
	aRSCanvas addAll: (labelsY := column collect: [ :s | self createLabelShapeY: s ]).
]

{ #category : #'hooks - labels' }
RSDSM2 >> addLabelsTop: aRSCanvas [ 
	| row |
	row := self rowAt: 1.
	aRSCanvas addAll: (labelsX := row collect: [ :s | self createLabelShapeX: s ]).
]

{ #category : #'accessing - computed' }
RSDSM2 >> columnAt: aNumber [
	^ matrix atRow: aNumber
]

{ #category : #hooks }
RSDSM2 >> computeColor: tuple [
	^ (self isAssocDependent: tuple)
		ifTrue: [ Color red ]
		ifFalse: [ Color veryVeryLightGray ]
]

{ #category : #'hooks - labels' }
RSDSM2 >> createLabelShapeX: aRSBox [
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
RSDSM2 >> createLabelShapeY: aRSBox [ 
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
RSDSM2 >> createShape: tuple [
	^ shape copy
		model: tuple;
		color: (self computeColor: tuple);
		yourself
]

{ #category : #hooks }
RSDSM2 >> createShapeX: anObjectX y: anObjectY position: position list: list [
	| box |
	box := self createShape: (shouldFeedX
		ifTrue: [ anObjectX -> anObjectY ]
		ifFalse: [ anObjectY -> anObjectX ]).
	box propertyAt: #matrixIndex put: position.
	list add: box.
	^ box
	
]

{ #category : #hooks }
RSDSM2 >> createShapes [
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
RSDSM2 >> defaultContainer [
	^ super defaultContainer @ RSCanvasController.
]

{ #category : #initialization }
RSDSM2 >> defaultShape [
	^ RSBox new
		size: 15;
		yourself
		
]

{ #category : #accessing }
RSDSM2 >> dependency [
	^ dependency
]

{ #category : #accessing }
RSDSM2 >> dependency: aOneArgBlock [
	"Take either X or Y values"
	dependency := aOneArgBlock
]

{ #category : #configuration }
RSDSM2 >> hideLabels [
	wantsLabels := false
]

{ #category : #initialization }
RSDSM2 >> initialize [
	super initialize.
	shape := self defaultShape.
	self 
		rotation: 45;
		showLabels;
		setShouldFeedX;
		dependency: #yourself;
		objects: #()
]

{ #category : #testing }
RSDSM2 >> isAssocDependent: assoc [
	| v |
	v := dependency rsValue: assoc key.
	v = assoc value ifTrue: [ ^ true ].
	^ v isCollection
		ifTrue: [ v includes: assoc value ]
		ifFalse: [ false ]
]

{ #category : #accessing }
RSDSM2 >> labelShapeX [
	^ labelShapeX ifNil: [ labelShapeX := RSMultilineLabelBuilder new  ]
]

{ #category : #accessing }
RSDSM2 >> labelShapeY [
	^ labelShapeY ifNil: [ labelShapeY := RSMultilineLabelBuilder new  ]
]

{ #category : #accessing }
RSDSM2 >> labels [
	^ self labelsX, self labelsY
]

{ #category : #accessing }
RSDSM2 >> labelsX [
	^ labelsX ifNil: [ #() ]
]

{ #category : #accessing }
RSDSM2 >> labelsY [
	^ labelsY ifNil: [ #() ]
]

{ #category : #UI }
RSDSM2 >> layoutShapes: aGroup [
	RSGridLayout new
		gapSize: 1;
		lineItemsCount: objectsX size;
		on: aGroup
]

{ #category : #accessing }
RSDSM2 >> numberOfObjects [
	^ self objects size
]

{ #category : #accessing }
RSDSM2 >> objects [
	^ (objectsX, objectsY) asSet
]

{ #category : #accessing }
RSDSM2 >> objects: someObjects [
	self 
		objectsX: someObjects;
		objectsY: someObjects.
]

{ #category : #accessing }
RSDSM2 >> objectsX [
	^ objectsX
]

{ #category : #accessing }
RSDSM2 >> objectsX: someObjects [
	objectsX := someObjects
]

{ #category : #accessing }
RSDSM2 >> objectsY [
	^ objectsY
]

{ #category : #accessing }
RSDSM2 >> objectsY: someObjects [
	objectsY := someObjects
]

{ #category : #hooks }
RSDSM2 >> renderIn: aCanvas [
	shapes := self createShapes.
	aCanvas addAll: shapes.
	self layoutShapes: shapes.
	self addLabelsIfNecessary: aCanvas.
	
]

{ #category : #accessing }
RSDSM2 >> rotation [
	^ rotation
]

{ #category : #accessing }
RSDSM2 >> rotation: aNumberInDegrees [
	rotation := aNumberInDegrees
]

{ #category : #'accessing - computed' }
RSDSM2 >> rowAt: aNumber [
	^ matrix atColumn: aNumber
]

{ #category : #configuration }
RSDSM2 >> setShouldFeedX [
	shouldFeedX := true
]

{ #category : #configuration }
RSDSM2 >> setShouldFeedY [
	shouldFeedX := false
]

{ #category : #'accessing - computed' }
RSDSM2 >> shapeAt: aPoint [ 
	^ matrix at: aPoint y at: aPoint x
]

{ #category : #configuration }
RSDSM2 >> showLabels [
	wantsLabels := true
]

{ #category : #testing }
RSDSM2 >> wantsLabels [
	^ wantsLabels
]
