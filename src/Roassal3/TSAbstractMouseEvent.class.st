"
Abstract for mouse events
"
Class {
	#name : #TSAbstractMouseEvent,
	#superclass : #TSUserInputEvent,
	#category : #'Roassal3-Events'
}

{ #category : #testing }
TSAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
