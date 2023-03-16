"
for user input events
"
Class {
	#name : #RSUserInputEvent,
	#superclass : #RSShapeEvent,
	#instVars : [
		'commandKeyPressed',
		'controlKeyPressed',
		'shiftKeyPressed',
		'optionKeyPressed'
	],
	#category : #'Roassal3-Event'
}

{ #category : #'instance creation' }
RSUserInputEvent class >> fromEvent: aUserInputEvent [
	^ self new
		commandKeyPressed: aUserInputEvent commandKeyPressed;
		controlKeyPressed: aUserInputEvent controlKeyPressed;
		shiftKeyPressed: aUserInputEvent shiftPressed;
		optionKeyPressed: aUserInputEvent optionKeyPressed;
		yourself
]

{ #category : #'modifier state' }
RSUserInputEvent >> altKeyPressed [
	"Answer true if the alt/option key on the keyboard was being held down when this event occurred."

	^ self optionKeyPressed
]

{ #category : #'modifier state' }
RSUserInputEvent >> anyModifierKeyPressed [
	"Answer true if command, option/alt or control key on the keyboard was being held down when this event occurred. Ignores shift key."

	^ self commandKeyPressed or: [ self optionKeyPressed or: [ self controlKeyPressed ] ]
]

{ #category : #'modifier state' }
RSUserInputEvent >> commandKeyPressed [
	"Answer true if the command key on the keyboard was being held down when this event occurred."

	^ commandKeyPressed
]

{ #category : #'private - accessing' }
RSUserInputEvent >> commandKeyPressed: aBoolean [
	commandKeyPressed := aBoolean
]

{ #category : #'modifier state' }
RSUserInputEvent >> controlKeyPressed [
	"Answer true if the control key on the keyboard was being held down when this event occurred."

	^ controlKeyPressed
]

{ #category : #'private - accessing' }
RSUserInputEvent >> controlKeyPressed: aBoolean [
	controlKeyPressed := aBoolean
]

{ #category : #initialization }
RSUserInputEvent >> initialize [
	super initialize.
	commandKeyPressed := false.
	controlKeyPressed := false.
	optionKeyPressed := false.
	shiftKeyPressed := false
]

{ #category : #'modifier state' }
RSUserInputEvent >> metaKeyPressed [
	^ Smalltalk platform isMacOS
		ifTrue: [ self commandKeyPressed ]
		ifFalse: [ self controlKeyPressed ]
]

{ #category : #'private - accessing' }
RSUserInputEvent >> modifiers: modifiers [
	commandKeyPressed := modifiers anyMask: 2r01000000.
	controlKeyPressed := modifiers anyMask: 2r00010000.
	optionKeyPressed := modifiers anyMask: 2r00100000.
	shiftKeyPressed := modifiers anyMask: 2r00001000
]

{ #category : #'modifier state' }
RSUserInputEvent >> optionKeyPressed [
	"Answer true if the alt/option key on the keyboard was being held down when this event occurred."

	^ optionKeyPressed
]

{ #category : #'private - accessing' }
RSUserInputEvent >> optionKeyPressed: aBoolean [
	optionKeyPressed := aBoolean
]

{ #category : #'modifier state' }
RSUserInputEvent >> shiftKeyPressed [
	"Answer true if the shift key on the keyboard was being held down when this event occurred"

	^ shiftKeyPressed
]

{ #category : #'private - accessing' }
RSUserInputEvent >> shiftKeyPressed: aBoolean [
	shiftKeyPressed := aBoolean
]

{ #category : #'modifier state' }
RSUserInputEvent >> shiftPressed [
	"Answer true if the shift key on the keyboard was being held down when this event occurred.
	This method is here for Morphic compatibility"

	^ self shiftKeyPressed
]
