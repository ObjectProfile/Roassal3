"
for loop events
"
Class {
	#name : #RSAnimationLoopEvent,
	#superclass : #RSAnimationEvent,
	#category : #'Roassal3-Animation-Events'
}

{ #category : #accessing }
RSAnimationLoopEvent >> currentLoop [
	^ animation currentLoop
]
