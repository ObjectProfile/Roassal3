"
I put a default interaction for each shape in the canvas
"
Class {
	#name : 'RSContextInteraction',
	#superclass : 'RSAbstractContextInteraction',
	#instVars : [
		'interactions'
	],
	#category : 'Roassal-Inspector-Contexts',
	#package : 'Roassal-Inspector',
	#tag : 'Contexts'
}

{ #category : 'initialization' }
RSContextInteraction >> defaultInteractions [
	^ { RSSelectionPresentationInteraction new } asOrderedCollection
]

{ #category : 'initialization' }
RSContextInteraction >> initialize [
	super initialize.
	interactions := self defaultInteractions
]

{ #category : 'hooks' }
RSContextInteraction >> interactionsToBeRegistered [
	^ interactions
]
