"
I can maximize or restore the window of one view
"
Class {
	#name : #RSMaximizeView,
	#superclass : #RSAbstractViewInteraction,
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSMaximizeView >> onElement: aView [
	aView morph owner expandBoxHit.
	
]
