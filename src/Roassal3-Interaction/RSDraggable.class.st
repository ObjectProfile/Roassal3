"
I can move an element from its position
"
Class {
	#name : #RSDraggable,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSDraggable class >> wantsUniqueInstance [
	^ true
]

{ #category : #hooks }
RSDraggable >> onShape: aShape [
	aShape
		when: RSMouseDragging
		do: [ :evt | 
			| d |
			d := aShape parent camera distanceFromPixelToSpace: evt step.
			aShape translateBy: d.
			aShape signalUpdate ]
]
