"
for loop events
"
Class {
	#name : 'RSAnimationLoopEvent',
	#superclass : 'RSAnimationEvent',
	#category : 'Roassal-Animation-Events',
	#package : 'Roassal-Animation',
	#tag : 'Events'
}

{ #category : 'accessing' }
RSAnimationLoopEvent >> currentLoop [
	^ animation currentLoop
]
