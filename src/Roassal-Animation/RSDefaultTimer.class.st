"
The default timer uses the pharo current time
"
Class {
	#name : #RSDefaultTimer,
	#superclass : #RSAbstractTimer,
	#category : #'Roassal-Animation-Core'
}

{ #category : #public }
RSDefaultTimer >> currentTime [
	^ Time millisecondClockValue
]
