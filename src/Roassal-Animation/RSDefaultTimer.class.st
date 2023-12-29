"
The default timer uses the pharo current time
"
Class {
	#name : 'RSDefaultTimer',
	#superclass : 'RSAbstractTimer',
	#category : 'Roassal-Animation-Core',
	#package : 'Roassal-Animation',
	#tag : 'Core'
}

{ #category : 'public' }
RSDefaultTimer >> currentTime [
	^ Time millisecondClockValue
]
