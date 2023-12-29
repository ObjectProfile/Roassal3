"
Use int the calypso system setting, you can create a new subclass and define a new selection strategy
"
Class {
	#name : 'RSInitialSelection',
	#superclass : 'RSObject',
	#instVars : [
		'targetClass'
	],
	#category : 'Roassal-UML-Calypso-Utilities',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
RSInitialSelection >> on: aCanvas [
	self subclassResponsibility
]

{ #category : 'accessing' }
RSInitialSelection >> targetClass [

	^ targetClass
]

{ #category : 'accessing' }
RSInitialSelection >> targetClass: anObject [

	targetClass := anObject
]
