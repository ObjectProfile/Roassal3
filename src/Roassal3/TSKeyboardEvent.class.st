"
A base class for keyboard events.
"
Class {
	#name : #TSKeyboardEvent,
	#superclass : #TSUserInputEvent,
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
TSKeyboardEvent >> = anotherKeyDown [
	"Do we really need this method? It has been imported from Roassal1"
	(self class == anotherKeyDown) ifFalse: [  ^ false ].
	^ self keyValue = anotherKeyDown keyValue
]

{ #category : #initialize }
TSKeyboardEvent >> initialize [
	super initialize.
	keyValue := 0
]

{ #category : #accessing }
TSKeyboardEvent >> keyCharacter [
	^ keyCharacter
]

{ #category : #accessing }
TSKeyboardEvent >> keyCharacter: anObject [
	keyCharacter := anObject
]

{ #category : #accessing }
TSKeyboardEvent >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
TSKeyboardEvent >> keyCombination: aKeyCombination [
	keyCombination := aKeyCombination
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue [
	^ keyValue
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue: anObject [
	keyValue := anObject
]
