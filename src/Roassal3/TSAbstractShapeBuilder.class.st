"
I am an abstract class that creates a shape from a model
"
Class {
	#name : #TSAbstractShapeBuilder,
	#superclass : #TSObject,
	#category : #'Roassal3-Core'
}

{ #category : #'as yet unclassified' }
TSAbstractShapeBuilder >> shapeOn: anObject [
	^ self subclassResponsibility
]
