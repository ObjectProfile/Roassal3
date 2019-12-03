"
I can create shapes
I redefine #renderIn: 
My subclasses needs to implement #objects and: #shapesFor:
"
Class {
	#name : #RSAbstractShapesBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'decorators'
	],
	#category : #'Roassal3-Core'
}

{ #category : #decoration }
RSAbstractShapesBuilder >> addDecorator: aBuilderDecorator [
	aBuilderDecorator builder: self.
	self decorators add: aBuilderDecorator
]

{ #category : #decoration }
RSAbstractShapesBuilder >> decorators [
	^ decorators ifNil: [ decorators := OrderedCollection new ]
]

{ #category : #hooks }
RSAbstractShapesBuilder >> hasDecorators [
	^ decorators notNil and: [ decorators isNotEmpty ]
]

{ #category : #hooks }
RSAbstractShapesBuilder >> objects [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractShapesBuilder >> renderDecoratorsIfNecessary: aCanvas [
	self hasDecorators ifFalse: [ ^ self ].
	decorators do: [ :decorator | decorator renderIn: aCanvas ].
]

{ #category : #hooks }
RSAbstractShapesBuilder >> renderIn: aCanvas [
	aCanvas addAll: (shapes := self shapesFor: self objects).
	self renderDecoratorsIfNecessary: aCanvas
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
		 ] as: RSGroup.
]
