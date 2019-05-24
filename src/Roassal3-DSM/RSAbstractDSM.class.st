"
I am an abstract class for dependency structural matrices
"
Class {
	#name : #RSAbstractDSM,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'objectsX',
		'objectsY',
		'wantsLabel',
		'text',
		'rotation',
		'transparencyWhenNonHighlighted',
		'transparencyWhenHighlighted',
		'creationBlock',
		'selectElement',
		'xinteraction',
		'yinteraction',
		'labelShapeX',
		'labelShapeY'
	],
	#category : #'Roassal3-DSM'
}

{ #category : #UI }
RSAbstractDSM >> addLabels [
	self addLabelsLeft.
	self addLabelsTop.
]

{ #category : #UI }
RSAbstractDSM >> addLabelsIfNecessary [
	self wantsLabel ifFalse: [ ^ self ].
	self addLabels
]

{ #category : #UI }
RSAbstractDSM >> addLabelsLeft [
	| es theModel lbl |
	es := self columnAt: 1.
	es
		do:
			[ :e | 
			theModel := e model key.
			lbl := self labelShapeY elementOn: theModel.
			yinteraction setUpElement: lbl.
			view add: lbl.
			RSLocate new
				outer;
				left;
				move: lbl on: e ]
]

{ #category : #UI }
RSAbstractDSM >> addLabelsTop [
	| es theModel lbl labels deltaY |
	es := self rowAt: 1.
	labels := OrderedCollection new.
	deltaY := Float fmax.
	es
		do:
			[ :e | 
			theModel := e model value.
			lbl := self labelShapeX elementOn: theModel.
			labels add: lbl.
			xinteraction setUpElement: lbl.
			view add: lbl.
			lbl rotateByDegrees: rotation.
			RSLocate new
				outer;
				middle;
				top;
				move: lbl on: e.
			deltaY := deltaY min: lbl position y ].
	labels do: [ :l | 
		l translateTo: l position x @ deltaY ].
]

{ #category : #configuration }
RSAbstractDSM >> cellSize [
	^ 15
]

{ #category : #accessing }
RSAbstractDSM >> columnAt: aNumber [

	^ (1 to: objectsY size) collect: [ :i | self elementAt: aNumber @ i ]
]

{ #category : #UI }
RSAbstractDSM >> createElements [
	"
	:: Void -> RTDSM
	var shape : RTShape
	var e : RTElement
	var anObject1 : Object
	var index1 : Number
	var anObject2 : Object
	var index2 : Number
	var evt : TREvent
	var elements : Collection
	var objects : Collection
	"
	| e |
	elements := TSGroup new.
	objectsY copy
		doWithIndex:
			[ :anObject1 :index1 | 
			objectsX copy
				doWithIndex:
					[ :anObject2 :index2 | 
					e := self shape elementOn: (self createObjectBlock value: anObject1 -> anObject2).
					e attributeAt: #matrixIndex put: index2 @ index1.
					elements add: e ] ].
]

{ #category : #accessing }
RSAbstractDSM >> createObjectBlock [
	^ creationBlock
]

{ #category : #accessing }
RSAbstractDSM >> createObjectBlock: aBlock [
	creationBlock := aBlock
]

{ #category : #hooks }
RSAbstractDSM >> createShapeBuilder [
	| sb |
	sb := super createShapeBuilder.
	sb shape: self defaultCellShape.
	^ sb
]

{ #category : #UI }
RSAbstractDSM >> defaultTopLabelRotation [
	^ -55
]

{ #category : #configuration }
RSAbstractDSM >> doNotShowLabels [
	wantsLabel := false
]

{ #category : #accessing }
RSAbstractDSM >> elementAt: aPoint [
	"Return the element at position aPoint"
	^ elements at: (objectsX size) * (aPoint y - 1) + aPoint x
]

{ #category : #accessing }
RSAbstractDSM >> elements [
	^ elements copy
]

{ #category : #highlighting }
RSAbstractDSM >> highlightColumn: aNumber [
	^ self highlightElements: (self columnAt: aNumber)
]

{ #category : #highlighting }
RSAbstractDSM >> highlightElements [
	self highlightElements: elements
]

{ #category : #highlighting }
RSAbstractDSM >> highlightElements: someElements [
	(someElements select: [ :e | selectElement rsValue: e ]) do: [ :e | | aShape |
		aShape := e trachelShape class = TSComposite 
			ifTrue: [ e trachelShape firstShape ]
			ifFalse: [ e trachelShape ].
		"aShape color: (shape color alpha: self transparencyWhenHighlighted)" ].
]

{ #category : #highlighting }
RSAbstractDSM >> highlightRow: aNumber [
	^ self highlightElements: (self rowAt: aNumber)
]

{ #category : #initialization }
RSAbstractDSM >> initialize [
	"
	:: Void -> RTDSM
	"
	super initialize.
	self objects: #().
	self createObjectBlock: [ :assoc| assoc ].
	self selectElement: [ :e | true ].
	shape := RSShapeBuilder box.
	shape color: Color veryVeryLightGray.
	shape size: self cellSize.
	shape popup.
"TODO:"
"	shape interaction 
		when: TSMouseEnter do: [ :evt | 
			self highlightElements.
			self unhighlightColumn: (evt shape attributeAt: #matrixIndex) x.
			self unhighlightRow: (evt shape attributeAt: #matrixIndex) y.
		];
		when: TSMouseLeave do: [ :evt | 
			self unhighlightElements. ].
"	
	xinteraction := RSInteractionBuilder new.
	yinteraction := RSInteractionBuilder new.
	rotation := self defaultTopLabelRotation.
	wantsLabel := true.
	text := #yourself.
	self labelShapeX: RSShapeBuilder label.
"	self labelShapeX label."
	self labelShapeY: RSShapeBuilder label.
"	self labelShapeY label."
	transparencyWhenHighlighted := 0.4.
	transparencyWhenNonHighlighted := 1.
]

{ #category : #UI }
RSAbstractDSM >> labelShape [
	^ RSShapeBuilder label
		height: self cellSize;
		text: text
]

{ #category : #accessing }
RSAbstractDSM >> labelShapeX [
	^ labelShapeX
]

{ #category : #accessing }
RSAbstractDSM >> labelShapeX: aShapeBuilder [
	labelShapeX := aShapeBuilder
]

{ #category : #accessing }
RSAbstractDSM >> labelShapeY [
	^ labelShapeY
]

{ #category : #accessing }
RSAbstractDSM >> labelShapeY: aShapeBuilder [
	labelShapeY := aShapeBuilder
]

{ #category : #accessing }
RSAbstractDSM >> labelShapesDo: aBlock1arg [
	aBlock1arg value: self labelShapeX.
	aBlock1arg value: self labelShapeY.
]

{ #category : #accessing }
RSAbstractDSM >> labelsXInteraction [
	^ xinteraction
]

{ #category : #accessing }
RSAbstractDSM >> labelsYInteraction [
	^ yinteraction
]

{ #category : #UI }
RSAbstractDSM >> layoutElements: es [
	RSGridLayout new
		gapSize: 1;
		lineItemsCount: objectsX size;
		on: es
]

{ #category : #accessing }
RSAbstractDSM >> numberOfObjects [
	"Return the number of objects"
	^ self objects size
]

{ #category : #accessing }
RSAbstractDSM >> objects [
	^ (objectsX, objectsY) asSet
]

{ #category : #accessing }
RSAbstractDSM >> objects: someObjects [
	objectsX := someObjects.
	objectsY := someObjects
]

{ #category : #accessing }
RSAbstractDSM >> objectsX [
	^ objectsX
]

{ #category : #accessing }
RSAbstractDSM >> objectsX: anObject [
	objectsX := anObject
]

{ #category : #accessing }
RSAbstractDSM >> objectsY [
	^ objectsY
]

{ #category : #accessing }
RSAbstractDSM >> objectsY: anObject [
	objectsY := anObject
]

{ #category : #hooks }
RSAbstractDSM >> renderIn: aView [
	self createElements.
	aView addAll: elements.
	self layoutElements: elements.
	self addLabelsIfNecessary.
	^ aView
]

{ #category : #accessing }
RSAbstractDSM >> rotation [
	"
	Return the rotation of the top labels
	:: Void -> Integer
	"
	^ rotation
]

{ #category : #accessing }
RSAbstractDSM >> rotation: anInteger [
	"Set the rotation of the top label
	:: Integer -> RTDSM
	"
	rotation := anInteger
]

{ #category : #accessing }
RSAbstractDSM >> rowAt: aNumber [
	"Return the elements located at a given row"
	^ (1 to: objectsX size) collect: [ :i | self elementAt: i @ aNumber ]
]

{ #category : #accessing }
RSAbstractDSM >> selectElement [
	 ^ selectElement
]

{ #category : #accessing }
RSAbstractDSM >> selectElement: aBlock [
	selectElement := aBlock
]

{ #category : #accessing }
RSAbstractDSM >> text [
	"Return the text used for labelling"
	^ text
]

{ #category : #accessing }
RSAbstractDSM >> text: aOneArgBlockOrSymbol [
	"Set the text used for each label. Per default, text is #yourself"
	text := aOneArgBlockOrSymbol
]

{ #category : #accessing }
RSAbstractDSM >> transparencyWhenHighlighted [
	^ transparencyWhenHighlighted
]

{ #category : #accessing }
RSAbstractDSM >> transparencyWhenHighlighted: anObject [
	transparencyWhenHighlighted := anObject
]

{ #category : #accessing }
RSAbstractDSM >> transparencyWhenNonHighlighted [
	^ transparencyWhenNonHighlighted
]

{ #category : #accessing }
RSAbstractDSM >> transparencyWhenNonHighlighted: anObject [
	transparencyWhenNonHighlighted := anObject
]

{ #category : #highlighting }
RSAbstractDSM >> unhighlightColumn: aNumber [
	^ self unhighlightElements: (self columnAt: aNumber)
]

{ #category : #highlighting }
RSAbstractDSM >> unhighlightElements [
	self unhighlightElements: elements
]

{ #category : #highlighting }
RSAbstractDSM >> unhighlightElements: someElements [
	(someElements select: [ :e | selectElement rsValue: e ]) do: [ :e | | aShape |
		aShape := e trachelShape class = TSComposite 
			ifTrue: [ e trachelShape firstShape ]
			ifFalse: [ e trachelShape ]. 
		aShape color: (aShape color alpha: self transparencyWhenNonHighlighted ) ].
]

{ #category : #highlighting }
RSAbstractDSM >> unhighlightRow: aNumber [
	^ self unhighlightElements: (self rowAt: aNumber)
]

{ #category : #hooks }
RSAbstractDSM >> view [
	^ super view @ RSControlsView
]

{ #category : #testing }
RSAbstractDSM >> wantsLabel [
	^ wantsLabel
]
