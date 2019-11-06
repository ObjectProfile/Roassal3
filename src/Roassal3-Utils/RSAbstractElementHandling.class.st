"
I am base class for RSAlignment and RSResize
"
Class {
	#name : #RSAbstractElementHandling,
	#superclass : #TSObject,
	#instVars : [
		'shapes',
		'fixedShape'
	],
	#category : #'Roassal3-Utils-PositionAndResize'
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
