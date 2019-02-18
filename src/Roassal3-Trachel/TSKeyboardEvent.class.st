"
A base class for keyboard events.
"
Class {
	#name : #TSKeyboardEvent,
	#superclass : #TSUserInputEvent,
	#instVars : [
		'keyValue',
		'keyCombination'
	],
	#category : #'Roassal3-Trachel-Events'
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
TSKeyboardEvent >> keyCombination [
	^ keyCombination
]

{ #category : #accessing }
TSKeyboardEvent >> keyCombination: anObject [
	keyCombination := anObject
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue [
	^ keyValue
]

{ #category : #accessing }
TSKeyboardEvent >> keyValue: anObject [
	keyValue := anObject
]
