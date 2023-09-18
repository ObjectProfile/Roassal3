Class {
	#name : #RSShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'shapeClass',
		'color',
		'width',
		'height',
		'borderColor',
		'borderWidth',
		'labelBlock'
	],
	#category : #'Roassal3-Mondrian-Core'
}

{ #category : #'instance creation' }
RSShapeBuilder >> arrowedLine [
]

{ #category : #accessing }
RSShapeBuilder >> borderColor [

	^ borderColor
]

{ #category : #'public - configuration' }
RSShapeBuilder >> borderColor: aColorOrASymbolOrOneArgBlock [

	borderColor := aColorOrASymbolOrOneArgBlock.
	borderWidth ifNil: [ borderWidth := 2 ]
]

{ #category : #accessing }
RSShapeBuilder >> borderWidth [

	^ borderWidth
]

{ #category : #'public - configuration' }
RSShapeBuilder >> borderWidth: anIntegerOrASymbolOrOneArgBlock [

	borderWidth := anIntegerOrASymbolOrOneArgBlock.
	borderColor ifNil: [ borderColor := Color black ]
]

{ #category : #'public - configuration' }
RSShapeBuilder >> box [
	shapeClass := RSBox.
	self extent: 5 @ 5
]

{ #category : #'public - configuration' }
RSShapeBuilder >> circle [
	shapeClass := RSEllipse.
	self extent: 5 @ 5
]

{ #category : #accessing }
RSShapeBuilder >> color [
	^ color
]

{ #category : #'public - configuration' }
RSShapeBuilder >> color: aOneArgBlockOrAValue [
	color := aOneArgBlockOrAValue
]

{ #category : #building }
RSShapeBuilder >> configureNotCompositeShape: aShape model: model [

	width ifNotNil: [ aShape width: (width rsValue: model) ].
	height ifNotNil: [ aShape height: (height rsValue: model) ].
	(borderColor notNil and: [ borderWidth notNil ]) ifTrue: [
		aShape border: (RSBorder new
				 color: (borderColor rsValue: model);
				 width: (borderWidth rsValue: model)) ].
	aShape color: (color rsValue: model)
]

{ #category : #building }
RSShapeBuilder >> configureShape: aShape [

	"Configure the shape. Note that it returns the same shape, or a different one (in case a composite has to be built)"

	| newResult result model |
	"The composite shape must have the model, and not the inner shape"
	self
		assert: [ aShape model notNil ]
		description: 'Must have a model set'.
	result := aShape.
	model := aShape model.
	self configureNotCompositeShape: aShape model: model.
	labelBlock notNil ifTrue: [
		newResult := RSComposite model: aShape model.
		aShape model: nil.
		newResult children: {
				aShape.
				(RSLabel new
					 text: (labelBlock rsValue: model);
					 color: Color black) }.
		result := newResult ].
	^ result
]

{ #category : #accessing }
RSShapeBuilder >> doesUseLabel [
	"Return true or false on whether the shape builder has to label the created shapes"
	^ labelBlock notNil
]

{ #category : #'public - configuration' }
RSShapeBuilder >> ellipse [
	shapeClass := RSEllipse.
	self extent: 5 @ 5
]

{ #category : #'public - configuration' }
RSShapeBuilder >> extent: aPoint [
	width := aPoint x.
	height := aPoint y
]

{ #category : #accessing }
RSShapeBuilder >> height [
	^ height
]

{ #category : #'public - configuration' }
RSShapeBuilder >> height: aValueOrAOneArgBlock [
	height := aValueOrAOneArgBlock
]

{ #category : #'public - configuration' }
RSShapeBuilder >> if: oneArgBlock color: aOneArgBlockOrAValue [
	| aColor |
	aColor := color.
	self color: [ :obj | (oneArgBlock rsValue: obj)
											ifTrue: [ aOneArgBlockOrAValue rsValue: obj ]
											ifFalse: [ aColor rsValue: obj ] ]
]

{ #category : #initialization }
RSShapeBuilder >> initialize [
	super initialize.
	self box.
	color := Color gray
]

{ #category : #'public - configuration' }
RSShapeBuilder >> label [
	shapeClass := RSLabel.
	width := nil.
	height := nil
]

{ #category : #accessing }
RSShapeBuilder >> labelBlock [
	"Could be nil if the shape builder must not label"
	^ labelBlock
]

{ #category : #'public - configuration' }
RSShapeBuilder >> labeled [
	self labeled: #asString
]

{ #category : #'public - configuration' }
RSShapeBuilder >> labeled: aOneArgBlock [
	"The block takes a model object as argument and must return a string"
	labelBlock := aOneArgBlock
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ shapeClass
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: aClass [
	shapeClass := aClass
]

{ #category : #building }
RSShapeBuilder >> shapeOn: anObject [
	"Return a new shape from the specified configuration"
	| aShape |
	aShape := shapeClass new
		          model: anObject;
		          yourself.
	^ self configureShape: aShape
]

{ #category : #building }
RSShapeBuilder >> shapesOn: someObjects [

	^ someObjects collect: [ :obj | self shapeOn: obj ] as: RSGroup
]

{ #category : #'public - configuration' }
RSShapeBuilder >> size: integerOrBlockOrSymbol [
	self width: integerOrBlockOrSymbol.
	self height: integerOrBlockOrSymbol
]

{ #category : #accessing }
RSShapeBuilder >> width [
	^ width
]

{ #category : #'public - configuration' }
RSShapeBuilder >> width: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock
]

{ #category : #'public - configuration' }
RSShapeBuilder >> withBorder [
	self borderColor: Color black.
	self borderWidth: 3
]
