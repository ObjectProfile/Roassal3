"
for user input events
"
Class {
	#name : #TSUserInputEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'commandKeyPressed',
		'controlKeyPressed',
		'shiftKeyPressed',
		'optionKeyPressed'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #'instance creation' }
TSUserInputEvent class >> fromEvent: aUserInputEvent [
	^ self new
		commandKeyPressed: aUserInputEvent commandKeyPressed;
		controlKeyPressed: aUserInputEvent controlKeyPressed;
		shiftKeyPressed: aUserInputEvent shiftPressed;
		optionKeyPressed: aUserInputEvent optionKeyPressed;
		yourself
]

{ #category : #'modifier state' }
TSUserInputEvent >> altKeyPressed [
	"Answer true if the alt/option key on the keyboard was being held down when this event occurred."

	^ self optionKeyPressed
]

{ #category : #'modifier state' }
TSUserInputEvent >> anyModifierKeyPressed [
	"Answer true if command, option/alt or control key on the keyboard was being held down when this event occurred. Ignores shift key."

	^ self commandKeyPressed or: [ self optionKeyPressed or: [ self controlKeyPressed ] ]
]

{ #category : #'modifier state' }
TSUserInputEvent >> commandKeyPressed [
	"Answer true if the command key on the keyboard was being held down when this event occurred."

	^ commandKeyPressed
]

{ #category : #'private - accessing' }
TSUserInputEvent >> commandKeyPressed: aBoolean [
	commandKeyPressed := aBoolean
]

{ #category : #'modifier state' }
TSUserInputEvent >> controlKeyPressed [
	"Answer true if the control key on the keyboard was being held down when this event occurred."

	^ controlKeyPressed
]

{ #category : #'private - accessing' }
TSUserInputEvent >> controlKeyPressed: aBoolean [
	controlKeyPressed := aBoolean
]

{ #category : #initialization }
TSUserInputEvent >> initialize [
	super initialize.
	commandKeyPressed := false.
	controlKeyPressed := false.
	optionKeyPressed := false.
	shiftKeyPressed := false
]

{ #category : #'private - accessing' }
TSUserInputEvent >> modifiers: modifiers [
	commandKeyPressed := modifiers anyMask: 2r01000000.
	controlKeyPressed := modifiers anyMask: 2r00010000.
	optionKeyPressed := modifiers anyMask: 2r00100000.
	shiftKeyPressed := modifiers anyMask: 2r00001000
]

{ #category : #'modifier state' }
TSUserInputEvent >> optionKeyPressed [
	"Answer true if the alt/option key on the keyboard was being held down when this event occurred."

	^ optionKeyPressed
]

{ #category : #'private - accessing' }
TSUserInputEvent >> optionKeyPressed: aBoolean [
	optionKeyPressed := aBoolean
]

{ #category : #'modifier state' }
TSUserInputEvent >> shiftKeyPressed [
	"Answer true if the shift key on the keyboard was being held down when this event occurred"

	^ shiftKeyPressed
]

{ #category : #'private - accessing' }
TSUserInputEvent >> shiftKeyPressed: aBoolean [
	shiftKeyPressed := aBoolean
]

{ #category : #'modifier state' }
TSUserInputEvent >> shiftPressed [
	"Answer true if the shift key on the keyboard was being held down when this event occurred.
	This method is here for Morphic compatibility"

	^ self shiftKeyPressed
]
