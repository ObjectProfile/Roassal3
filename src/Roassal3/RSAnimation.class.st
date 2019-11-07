"
I am an abstraction of what an animation should need to do in the trachel canvas. Check package Roassal3-Animation to see a concrete subclasses.
"
Class {
	#name : #RSAnimation,
	#superclass : #RSObject,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-AnimationBase'
}

{ #category : #dependencies }
RSAnimation >> canvas [
	^ canvas
]

{ #category : #dependencies }
RSAnimation >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #dependencies }
RSAnimation >> hasCompleted [
	^ self subclassResponsibility
]

{ #category : #dependencies }
RSAnimation >> refresh [
	self subclassResponsibility
]

{ #category : #dependencies }
RSAnimation >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #dependencies }
RSAnimation >> start [
	self subclassResponsibility
]
