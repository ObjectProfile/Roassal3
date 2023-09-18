"
I am a special case to drag elements with the draggable interaction and the RSForceBasedLayout
"
Class {
	#name : #RSDraggableForceInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'layout'
	],
	#category : #'Roassal-Layouts-Interactions'
}

{ #category : #hooks }
RSDraggableForceInteraction >> layout [
	^ layout
]

{ #category : #hooks }
RSDraggableForceInteraction >> layout: aForceLayout [
	layout := aForceLayout
]

{ #category : #hooks }
RSDraggableForceInteraction >> onShape: aShape [

	aShape removeInteractionIfPresent: RSDraggable.
	aShape
		when: RSMouseDragStart do: [ :evt |
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock isFixed: true ] ]
			for: self;
		when: RSMouseDragging do: [ :evt |
			| d |
			d := evt shape parent camera distanceFromPixelToSpace: evt step.
			evt shape translateBy: d.
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock fixPosition: evt shape position ].
			evt shape signalUpdate ]
			for: self;
		when: RSMouseDragEnd do:[:evt |
			layout
				mockElementAt: evt shape
				ifPresent: [ :mock | mock isFixed: false ] ]
			for: self
]
