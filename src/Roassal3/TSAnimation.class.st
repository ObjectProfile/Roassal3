"
I am an abstraction of what an animation should need to do in the trachel canvas. Check package Roassal3-Animation to see a concrete subclasses.
"
Class {
	#name : #TSAnimation,
	#superclass : #TSObject,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Animation'
}

{ #category : #dependencies }
TSAnimation >> canvas [
	^ canvas
]

{ #category : #dependencies }
TSAnimation >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #dependencies }
TSAnimation >> hasCompleted [
	^ self subclassResponsibility
]

{ #category : #dependencies }
TSAnimation >> refresh [
	self subclassResponsibility
]

{ #category : #dependencies }
TSAnimation >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #dependencies }
TSAnimation >> start [
	"self subclassResponsibility"
]
