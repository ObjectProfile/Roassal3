"
I an an event for animations in trachel
"
Class {
	#name : #RSAnimationEvent,
	#superclass : #RSEvent,
	#instVars : [
		'animation'
	],
	#category : #'Roassal-Animation-Events'
}

{ #category : #accessing }
RSAnimationEvent >> animation [
	^ animation
]

{ #category : #accessing }
RSAnimationEvent >> animation: anAnimation [
	animation := anAnimation
]

{ #category : #accessing }
RSAnimationEvent >> canvas [
	^ self animation canvas
]
