"
I an an event for animations in trachel
"
Class {
	#name : #TSAnimationEvent,
	#superclass : #TSEvent,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Animation-Events'
}

{ #category : #accessing }
TSAnimationEvent >> animation [
	^ animation
]

{ #category : #accessing }
TSAnimationEvent >> animation: anAnimation [
	animation := anAnimation.
]
