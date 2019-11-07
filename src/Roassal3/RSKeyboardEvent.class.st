"
A base class for keyboard events.
"
Class {
	#name : #RSKeyboardEvent,
	#superclass : #RSUserInputEvent,
	#instVars : [
		'keyValue',
		'symbol',
		'keyCharacter',
		'keyCombination'
	],
	#classVars : [
		'KeySymbolMap'
	],
	#category : #'Roassal3-Events'
}

{ #category : #comparing }
RSKeyboardEvent >> = anotherKeyDown [
	"Do we really need this method? It has been imported from Roassal1"
	(self class == anotherKeyDown) ifFalse: [  ^ false ].
	^ self keyValue = anotherKeyDown keyValue
]

{ #category : #initialize }
RSKeyboardEvent >> initialize [
	super initialize.
	keyValue := 0
]

{ #category : #accessing }
RSKeyboardEvent >> keyCharacter [
	^ keyCharacter
]

{ #category : #accessing }
RSKeyboardEvent >> keyCharacter: anObject [
	keyCharacter := anObject
]

{ #category : #accessing }
RSKeyboardEvent >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
RSKeyboardEvent >> keyCombination: aKeyCombination [
	keyCombination := aKeyCombination
]

{ #category : #accessing }
RSKeyboardEvent >> keyValue [
	^ keyValue
]

{ #category : #accessing }
RSKeyboardEvent >> keyValue: anObject [
	keyValue := anObject
]
