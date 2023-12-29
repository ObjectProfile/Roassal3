"
Subclasses of myself are interaction for the view.
"
Class {
	#name : 'RSAbstractCanvasInteraction',
	#superclass : 'RSInteraction',
	#category : 'Roassal3-Interaction-Core',
	#package : 'Roassal3-Interaction',
	#tag : 'Core'
}

{ #category : 'hooks' }
RSAbstractCanvasInteraction >> onShape: aCanvas [
	self subclassResponsibility
]
