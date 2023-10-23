"
I do not register any interaction to the RSCanvas and its shapes
"
Class {
	#name : 'RSEmptyContextInteraction',
	#superclass : 'RSAbstractContextInteraction',
	#category : 'Roassal-Inspector-Contexts',
	#package : 'Roassal-Inspector',
	#tag : 'Contexts'
}

{ #category : 'accessing' }
RSEmptyContextInteraction >> inspectorInteractions [
	^ #()
]

{ #category : 'hooks' }
RSEmptyContextInteraction >> interactionsToBeRegistered [
	^ #()
]
