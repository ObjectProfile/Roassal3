"
I can create shapes for roassal based on a model
"
Class {
	#name : #RSShapeBuilder,
	#superclass : #RSAbstractModelBuilder,
	#instVars : [
		'interaction'
	],
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSShapeBuilder class >> box [
	^ self rectangle
]

{ #category : #'instance creation' }
RSShapeBuilder class >> circle [
	^ self ellipse
]

{ #category : #'instance creation' }
RSShapeBuilder class >> ellipse [
	^ self new
		shapeClass: TSEllipse;
		yourself 
]

{ #category : #'instance creation' }
RSShapeBuilder class >> rectangle [
	^ self new
		shapeClass: TSBox;
		yourself 
]

{ #category : #'public - accessing' }
RSShapeBuilder >> elementOn: object index: index [
	| el shape |
	el := self elementClass new.
	el
		model: object;
		index: index.
	self executeActions: #isPreload on: el.
	shape := self shapeClass new.
	self updateElement: el innerComponent: shape.
	el trachelShape: shape.
	self executeActions: #isPostload on: el.
	^ el
	
]

{ #category : #accessing }
RSShapeBuilder >> interaction [
	^ interaction ifNil: [
		interaction := RSInteractionBuilder new.
		self addAction: (RSAction new
			action: [ :el | interaction setUpElement: el ]).
		interaction ].
]

{ #category : #accessing }
RSShapeBuilder >> interactionDo: aBlock [
	aBlock value: self interaction
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass [
	^ self innerClass 
]

{ #category : #accessing }
RSShapeBuilder >> shapeClass: aClass [
	self innerClass: aClass;
		size: 5;
		color: Color gray;
		elementClass: RSElement.
]
