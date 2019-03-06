"
TODO
"
Class {
	#name : #RSDirectLayoutTranslator,
	#superclass : #RSLayoutTranslator,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
RSDirectLayoutTranslator class >> isDefault [
	^ true
]

{ #category : #hook }
RSDirectLayoutTranslator >> translate: element to: newPosition [
	element translateTo: newPosition
]
