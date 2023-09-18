"
I do not register any interaction to the RSCanvas and its shapes
"
Class {
	#name : #RSEmptyContextInteraction,
	#superclass : #RSAbstractContextInteraction,
	#category : #'Roassal-Inspector-Contexts'
}

{ #category : #accessing }
RSEmptyContextInteraction >> inspectorInteractions [
	^ #()
]

{ #category : #hooks }
RSEmptyContextInteraction >> interactionsToBeRegistered [
	^ #()
]
