"
for loop events
"
Class {
	#name : #RSAnimationLoopEvent,
	#superclass : #RSAnimationEvent,
	#category : #'Roassal-Animation-Events'
}

{ #category : #accessing }
RSAnimationLoopEvent >> currentLoop [
	^ animation currentLoop
]
