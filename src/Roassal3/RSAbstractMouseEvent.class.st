"
Abstract for mouse events
"
Class {
	#name : #RSAbstractMouseEvent,
	#superclass : #RSUserInputEvent,
	#category : #'Roassal3-Events'
}

{ #category : #testing }
RSAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
