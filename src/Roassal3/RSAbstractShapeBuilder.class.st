"
I am an abstract class that creates a shape from a model
"
Class {
	#name : #RSAbstractShapeBuilder,
	#superclass : #RSObject,
	#category : #'Roassal3-Core'
}

{ #category : #'as yet unclassified' }
RSAbstractShapeBuilder >> shapeOn: anObject [
	^ self subclassResponsibility
]
