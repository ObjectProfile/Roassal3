"
I can decorate builders inspired on decorator pattern
"
Class {
	#name : #RSAbstractPieDecorator,
	#superclass : #RSObject,
	#instVars : [
		'builder'
	],
	#category : #'Roassal3-Pie-Decorators'
}

{ #category : #'instance creation' }
RSAbstractPieDecorator class >> on: aPieBuilder [
	self new builder: aPieBuilder; render
]

{ #category : #accessing }
RSAbstractPieDecorator >> builder [
	^ builder
]

{ #category : #accessing }
RSAbstractPieDecorator >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #rendering }
RSAbstractPieDecorator >> render [
	self subclassResponsibility
]
