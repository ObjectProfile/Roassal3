"
Abstract for mouse events
"
Class {
	#name : #RSAbstractMouseEvent,
	#superclass : #RSUserInputEvent,
	#category : #'Roassal-Event'
}

{ #category : #testing }
RSAbstractMouseEvent >> isPositionAboveShape [
	^ shape encompassingRectangle containsPoint: self positionFromCamera
]
