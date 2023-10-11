"
for loop events
"
Class {
	#name : 'RSAnimationLoopEvent',
	#superclass : 'RSAnimationEvent',
	#category : 'Roassal3-Animation-Events',
	#package : 'Roassal3-Animation',
	#tag : 'Events'
}

{ #category : 'accessing' }
RSAnimationLoopEvent >> currentLoop [
	^ animation currentLoop
]
