"
I can move an element from its position
"
Class {
	#name : #TSDraggable,
	#superclass : #TSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
TSDraggable class >> wantsUniqueInstance [
	^ true
]

{ #category : #hooks }
TSDraggable >> onShape: aShape [
	aShape
		when: TSMouseDragging
		do: [ :evt | 
			| d |
			d := aShape parent camera distanceFromPixelToSpace: evt step.
			aShape translateBy: d.
			aShape signalUpdate ]
]
