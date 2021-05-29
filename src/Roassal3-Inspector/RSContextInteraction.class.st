"
I put a default interaction for each shape in the canvas
"
Class {
	#name : #RSContextInteraction,
	#superclass : #RSAbstractContextInteraction,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #initialization }
RSContextInteraction >> initialize [
	super initialize.
	interactions := OrderedCollection new
		add: RSSelectionPresentation new;
		yourself.
]

{ #category : #hooks }
RSContextInteraction >> interactionsToBeRegistered [
	^ interactions
]
