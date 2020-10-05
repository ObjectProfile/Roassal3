"
I put a default interaction for each shape in the canvas
"
Class {
	#name : #RSInteractiveContext,
	#superclass : #RSAbstractContext,
	#instVars : [
		'interactions'
	],
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #initialization }
RSInteractiveContext >> initialize [
	super initialize.
	interactions := OrderedCollection new
		add: RSSelectionPresentation new;
		yourself.
]

{ #category : #hooks }
RSInteractiveContext >> interactionsToBeRegistered [
	^ interactions
]
