"
I can move an element from its position
"
Class {
	#name : #RSDraggable,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction'
}

{ #category : #'instance creation' }
RSDraggable class >> wantsUniqueInstance [
	^ true
]

{ #category : #hooks }
RSDraggable >> onElement: e [
	| d |
	e when: TSMouseDragging do: [ :evt |
		d := e parent camera distanceFromPixelToSpace: evt step. 
		e translateBy: d.
		e signalUpdate.
		 ].
]
