"
A base class for keyboard events.
"
Class {
	#name : #RSKeyboardEvent,
	#superclass : #RSUserInputEvent,
	#instVars : [
		'keyValue',
		'keyName'
	],
	#category : #'Roassal3-Events'
}

{ #category : #comparing }
RSKeyboardEvent >> = anotherKeyEvent [
	"Do we really need this method? It has been imported from Roassal1"
	(self class == anotherKeyEvent) ifFalse: [  ^ false ].
	^ self keyValue = anotherKeyEvent keyValue
]

{ #category : #initialize }
RSKeyboardEvent >> initialize [
	super initialize.
	keyValue := 0
]

{ #category : #accessing }
RSKeyboardEvent >> keyName [
	^ keyName
]

{ #category : #accessing }
RSKeyboardEvent >> keyName: aString [
	keyName := aString
]

{ #category : #accessing }
RSKeyboardEvent >> keyValue [
	^ keyValue
]

{ #category : #accessing }
RSKeyboardEvent >> keyValue: anObject [
	keyValue := anObject
]

{ #category : #printing }
RSKeyboardEvent >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' keyName: ';
		print: keyName.
	aStream
		nextPutAll: ' keyValue: ';
		print: keyValue.
	aStream
		nextPutAll: ' commandKeyPressed: ';
		print: commandKeyPressed.
	aStream
		nextPutAll: ' controlKeyPressed: ';
		print: controlKeyPressed.
	aStream
		nextPutAll: ' optionKeyPressed: ';
		print: optionKeyPressed.
	aStream
		nextPutAll: ' shiftKeyPressed: ';
		print: shiftKeyPressed
]
