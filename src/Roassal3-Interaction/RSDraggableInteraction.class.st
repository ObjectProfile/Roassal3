"
I can move an element from its position
"
Class {
	#name : #RSDraggableInteraction,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSDraggableInteraction class >> wantsUniqueInstance [
	^ true
]

{ #category : #hooks }
RSDraggableInteraction >> onShape: aShape [
	aShape
		when: RSMouseDragging
		do: [ :evt | 
			| d |
			d := evt camera distanceFromPixelToSpace: evt step.
			evt shape translateBy: d.
			evt signalUpdate ]
]
