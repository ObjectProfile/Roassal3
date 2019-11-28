"
I can create shapes
I redefine #renderIn: 
My subclasses needs to implement #objects and: #shapesFor:
"
Class {
	#name : #RSAbstractShapesBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#category : #'Roassal3-Core'
}

{ #category : #hooks }
RSAbstractShapesBuilder >> objects [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractShapesBuilder >> renderIn: aCanvas [
	aCanvas addAll: (shapes := self shapesFor: self objects).
]

{ #category : #hooks }
RSAbstractShapesBuilder >> shapeFor: anObject [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractShapesBuilder >> shapesFor: aCollection [
	^ aCollection collect: [ :m | self shapeFor: m ] as: RSGroup.
]
