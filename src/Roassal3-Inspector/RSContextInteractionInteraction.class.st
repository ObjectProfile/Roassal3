"
I put a default interaction for each shape in the canvas
"
Class {
	#name : #RSContextInteractionInteraction,
	#superclass : #RSAbstractContextInteraction,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #initialization }
RSContextInteractionInteraction >> initialize [
	super initialize.
	interactions := OrderedCollection new
		add: RSSelectionPresentationInteraction new;
		yourself.
]

{ #category : #hooks }
RSContextInteractionInteraction >> interactionsToBeRegistered [
	^ interactions
]
