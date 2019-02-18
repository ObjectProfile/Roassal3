"
Abstract for mouse events
"
Class {
	#name : #TSAbstractMouseEvent,
	#superclass : #TSUserInputEvent,
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #testing }
TSAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
