"
I am base class for RSAlignment and RSResize
"
Class {
	#name : #RSAbstractElementHandling,
	#superclass : #RSObject,
	#instVars : [
		'shapes',
		'fixedShape'
	],
	#category : #'Roassal3-Layouts-PositionAndResize'
}

{ #category : #accessing }
RSAbstractElementHandling >> fixedShape [
	^ fixedShape
]

{ #category : #accessing }
RSAbstractElementHandling >> fixedShape: aShape [
	"Designate a particular shape for which all the other will be aligned against"
	fixedShape := aShape
]

{ #category : #'private - configuration' }
RSAbstractElementHandling >> ifNoFixedShapeThen: aBlock [
	fixedShape ifNil: [ aBlock value  ]
]

{ #category : #accessing }
RSAbstractElementHandling >> shapes [
	^ shapes
]

{ #category : #accessing }
RSAbstractElementHandling >> shapes: someShapes [
	shapes := someShapes asGroup
]
