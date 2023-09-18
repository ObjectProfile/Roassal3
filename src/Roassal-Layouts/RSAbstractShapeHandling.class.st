"
I am base class for RSAlignment and RSResize
"
Class {
	#name : #RSAbstractShapeHandling,
	#superclass : #RSObject,
	#instVars : [
		'shapes',
		'fixedShape'
	],
	#category : #'Roassal3-Layouts-PositionAndResize'
}

{ #category : #accessing }
RSAbstractShapeHandling >> fixedShape [
	^ fixedShape
]

{ #category : #accessing }
RSAbstractShapeHandling >> fixedShape: aShape [
	"Designate a particular shape for which all the other will be aligned against"
	fixedShape := aShape
]

{ #category : #'private - configuration' }
RSAbstractShapeHandling >> ifNoFixedShapeThen: aBlock [
	fixedShape ifNil: [ aBlock value  ]
]

{ #category : #accessing }
RSAbstractShapeHandling >> shapes [
	^ shapes
]

{ #category : #accessing }
RSAbstractShapeHandling >> shapes: someShapes [
	shapes := someShapes asGroup
]
