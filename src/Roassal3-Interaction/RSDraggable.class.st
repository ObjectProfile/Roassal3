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
	aShape when: RSMouseDragging send: #processDrag: to: self
]

{ #category : #hooks }
RSDraggable >> processDrag: evt [ 
	| d |
	d := evt camera distanceFromPixelToSpace: evt step.
	evt shape translateBy: d.
	evt signalUpdate 
]
