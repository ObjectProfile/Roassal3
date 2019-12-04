"
I can decorate builders inspired on decorator pattern
"
Class {
	#name : #RSAbstractDecorator,
	#superclass : #RSObject,
	#instVars : [
		'builder'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #accessing }
RSAbstractDecorator >> builder [
	^ builder
]

{ #category : #accessing }
RSAbstractDecorator >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #rendering }
RSAbstractDecorator >> render [
	self subclassResponsibility
]
