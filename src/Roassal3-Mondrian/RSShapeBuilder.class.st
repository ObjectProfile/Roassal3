Class {
	#name : #RSShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'shapeClass',
		'color',
		'width',
		'height'
	],
	#category : #'Roassal3-Mondrian'
}

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
RSShapeBuilder >> color: anObject [
	color := anObject
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

{ #category : #initialization }
RSShapeBuilder >> initialize [
	super initialize.
	self box.
	color := Color gray
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ shapeClass
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: anObject [
	shapeClass := anObject
]

{ #category : #'building - graph' }
RSShapeBuilder >> shapesOn: someObjects [
	^ someObjects collect: [ :obj | 
			shapeClass new 
				model: obj; 
				width: (width rsValue: obj); 
				height: (width rsValue: obj);
				color: (color rsValue: obj) ] as: RSGroup
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
