"
I can create shapes
I redefine #renderIn: 
My subclasses needs to implement #objects and: #shapesFor:
"
Class {
	#name : #RSAbstractShapesBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#category : #'Roassal3-Builders-Core'
}

{ #category : #hooks }
RSAbstractShapesBuilder >> objects [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractShapesBuilder >> renderIn: aCanvas [
	aCanvas addAll: (shapes := self shapesFor: self objects)
]

{ #category : #hooks }
RSAbstractShapesBuilder >> shapeFor: anObject index: index [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractShapesBuilder >> shapesFor: aCollection [
	| k |
	k := 0.
	^ aCollection collect: [ :m |
		k := k + 1.
		self shapeFor: m yourself index: k.
		 ] as: RSGroup
]
