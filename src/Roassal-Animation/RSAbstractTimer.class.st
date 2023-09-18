"
Users can set the timer of the canvas this will affect the animations process, by changing the speed of all of them in a canvas
"
Class {
	#name : #RSAbstractTimer,
	#superclass : #RSObject,
	#category : #'Roassal3-Animation-Core'
}

{ #category : #public }
RSAbstractTimer >> currentTime [
	^ self subclassResponsibility
]
