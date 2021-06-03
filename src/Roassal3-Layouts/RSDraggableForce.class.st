"
I am a special case to drag elements with the draggable interaction and the RSForceBasedLayout
"
Class {
	#name : #RSDraggableForce,
	#superclass : #RSInteraction,
	#instVars : [
		'layout'
	],
	#category : #'Roassal3-Layouts-Interactions'
}

{ #category : #hooks }
RSDraggableForce >> layout [
	^ layout
]

{ #category : #hooks }
RSDraggableForce >> layout: aForceLayout [
	layout := aForceLayout
]

{ #category : #hooks }
RSDraggableForce >> onShape: aShape [

	aShape removeInteractionIfPresent: RSDraggable.
	aShape 
		when: RSMouseDragStartEvent do: [ :evt | 
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock isFixed: true ] ];
		when: RSMouseDraggingEvent do: [ :evt |
			| d |
			d := evt shape parent camera distanceFromPixelToSpace: evt step.
			evt shape translateBy: d.
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock fixPosition: evt shape position ].
			evt shape signalUpdate ];
		when: RSMouseDragEndEvent do:[:evt | 
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock isFixed: false ] ].
]
