Class {
	#name : #RSShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'shapeClass',
		'color',
		'width',
		'height'
	],
	#category : #'Roassal3-Mondrian-Core'
}

{ #category : #'instance creation' }
RSShapeBuilder >> arrowedLine [
	
]

{ #category : #initialization }
RSShapeBuilder >> box [
	shapeClass := RSBox.
	self extent: 5 @ 5.
]

{ #category : #initialization }
RSShapeBuilder >> circle [
	shapeClass := RSEllipse.
	self extent: 5 @ 5.
]

{ #category : #accessing }
RSShapeBuilder >> color [
	^ color
]

{ #category : #accessing }
RSShapeBuilder >> color: aOneArgBlockOrAValue [
	color := aOneArgBlockOrAValue
]

{ #category : #initialization }
RSShapeBuilder >> ellipse [
	shapeClass := RSEllipse.
	self extent: 5 @ 5.
]

{ #category : #initialization }
RSShapeBuilder >> extent: aPoint [
	width := aPoint x.
	height := aPoint y
]

{ #category : #accessing }
RSShapeBuilder >> height [
	^ height
]

{ #category : #accessing }
RSShapeBuilder >> height: anObject [
	height := anObject
]

{ #category : #accessing }
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

{ #category : #initialization }
RSShapeBuilder >> label [
	shapeClass := RSLabel.
	width := nil.
	height := nil
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ shapeClass
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: aClass [
	shapeClass := aClass
]

{ #category : #'building - graph' }
RSShapeBuilder >> shapesOn: someObjects [
	| result |
	^ someObjects collect: [ :obj | 
			result := shapeClass new 
							model: obj;
							yourself.
			width ifNotNil: [ result width: (width rsValue: obj) ].
			height ifNotNil: [ result height: (height rsValue: obj) ].
			result color: (color rsValue: obj) .
			result ] as: RSGroup
]

{ #category : #accessing }
RSShapeBuilder >> size: integerOrBlockOrSymbol [
	self width: integerOrBlockOrSymbol.
	self height: integerOrBlockOrSymbol
]

{ #category : #accessing }
RSShapeBuilder >> width [
	^ width
]

{ #category : #accessing }
RSShapeBuilder >> width: anObject [
	width := anObject
]
