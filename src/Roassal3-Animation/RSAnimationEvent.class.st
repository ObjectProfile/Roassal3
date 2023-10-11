"
I an an event for animations in trachel
"
Class {
	#name : 'RSAnimationEvent',
	#superclass : 'RSEvent',
	#instVars : [
		'animation'
	],
	#category : 'Roassal3-Animation-Events',
	#package : 'Roassal3-Animation',
	#tag : 'Events'
}

{ #category : 'accessing' }
RSAnimationEvent >> animation [
	^ animation
]

{ #category : 'accessing' }
RSAnimationEvent >> animation: anAnimation [
	animation := anAnimation
]

{ #category : 'accessing' }
RSAnimationEvent >> canvas [
	^ self animation canvas
]
