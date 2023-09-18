"
TODO
"
Class {
	#name : #RSDirectLayoutTranslator,
	#superclass : #RSLayoutTranslator,
	#category : #'Roassal-Layouts-Util'
}

{ #category : #testing }
RSDirectLayoutTranslator class >> isDefault [
	^ true
]

{ #category : #hook }
RSDirectLayoutTranslator >> translate: element to: newPosition [
	element translateTo: newPosition
]
