"
I can decorate builders inspired on decorator pattern
"
Class {
	#name : #RSAbstractBuilderDecorator,
	#superclass : #RSAbstractShapesBuilder,
	#instVars : [
		'builder'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSAbstractBuilderDecorator >> builder [
	^ builder
]

{ #category : #accessing }
RSAbstractBuilderDecorator >> builder: aBuilder [
	builder := aBuilder.
	self container: aBuilder container
]

{ #category : #accessing }
RSAbstractBuilderDecorator >> container: aContainer [
	super container: aContainer.
	builder container: aContainer
]

{ #category : #hooks }
RSAbstractBuilderDecorator >> objects [
	^ builder shapes
]
