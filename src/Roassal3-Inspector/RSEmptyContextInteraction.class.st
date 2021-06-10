"
I do not register any interaction to the RSCanvas and its shapes
"
Class {
	#name : #RSEmptyContextInteraction,
	#superclass : #RSAbstractContextInteraction,
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #hooks }
RSEmptyContextInteraction >> interactionsToBeRegistered [
	^ #()
]
