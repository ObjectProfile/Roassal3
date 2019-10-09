"
TODO
"
Class {
	#name : #TSDirectLayoutTranslator,
	#superclass : #TSLayoutTranslator,
	#category : #'Roassal3-Layouts-Utils'
}

{ #category : #testing }
TSDirectLayoutTranslator class >> isDefault [
	^ true
]

{ #category : #hook }
TSDirectLayoutTranslator >> translate: element to: newPosition [
	element translateTo: newPosition
]
