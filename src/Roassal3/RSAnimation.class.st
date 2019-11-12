"
I am an abstraction of what an animation should need to do in the trachel canvas. Check package Roassal3-Animation to see a concrete subclasses.

Here is an example on how to create animation

-=-=-=-=-=-=-=-=-=
	c := RSCanvas new.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c add: b.
	c newAnimation
			from: -100 @ -100;
			to: 100 @ 100;
			on: b set: #position:.
	c
-=-=-=-=-=-=-=-=-=
	
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
	"Return true if the animation has completed"
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
