"
Subclasses of myself are interaction for the view.
"
Class {
	#name : #RSAbstractCanvasInteraction,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSAbstractCanvasInteraction >> onShape: aCanvas [
	self subclassResponsibility
]
