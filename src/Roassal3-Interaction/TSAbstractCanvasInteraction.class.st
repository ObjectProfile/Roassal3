"
Subclasses of myself are interaction for the view.
"
Class {
	#name : #TSAbstractCanvasInteraction,
	#superclass : #TSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
TSAbstractCanvasInteraction >> onShape: aView [
	self subclassResponsibility 
	
]
