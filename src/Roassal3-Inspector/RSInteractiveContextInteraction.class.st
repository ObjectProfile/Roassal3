"
I put a default interaction for each shape in the canvas
"
Class {
	#name : #RSInteractiveContextInteraction,
	#superclass : #RSAbstractContextInteraction,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #initialization }
RSInteractiveContextInteraction >> initialize [
	super initialize.
	interactions := OrderedCollection new
		add: RSSelectionPresentation new;
		yourself.
]

{ #category : #hooks }
RSInteractiveContextInteraction >> interactionsToBeRegistered [
	^ interactions
]
