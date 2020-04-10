"
I do not register any interaction to the RSCanvas and its shapes
"
Class {
	#name : #RSEmptyContext,
	#superclass : #RSAbstractContext,
	#category : #'Roassal3-Inspector-Context'
}

{ #category : #hooks }
RSEmptyContext >> interactionsToBeRegistered [
	^ #()
]
