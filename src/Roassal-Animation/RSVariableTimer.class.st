"
This roassal timer, changes the time depending the user's needs. Ideally you add time when you complete a task with the canvas
"
Class {
	#name : 'RSVariableTimer',
	#superclass : 'RSAbstractTimer',
	#instVars : [
		'currentTime'
	],
	#category : 'Roassal-Animation-Core',
	#package : 'Roassal-Animation',
	#tag : 'Core'
}

{ #category : 'public' }
RSVariableTimer >> addTime: aDuration [
	currentTime := currentTime + aDuration asMilliSeconds
]

{ #category : 'public' }
RSVariableTimer >> currentTime [
	^ currentTime
]

{ #category : 'initialization' }
RSVariableTimer >> initialize [
	super initialize.
	currentTime := RSDefaultTimer new currentTime
]
