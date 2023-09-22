"
The default timer uses the pharo current time
"
Class {
	#name : 'RSDefaultTimer',
	#superclass : 'RSAbstractTimer',
	#category : 'Roassal3-Animation-Core',
	#package : 'Roassal3-Animation',
	#tag : 'Core'
}

{ #category : 'public' }
RSDefaultTimer >> currentTime [
	^ Time millisecondClockValue
]
