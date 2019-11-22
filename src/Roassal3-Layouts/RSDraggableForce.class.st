"
I am a special case to drag elements with the draggable interaction and the RSForceBasedLayout
"
Class {
	#name : #RSDraggableForce,
	#superclass : #RSDraggable,
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
	| mock |
	super onShape: aShape.
	aShape 
		when: RSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: aShape.
			mock isFixed: true. ];
		when: RSMouseDragging do: [ :evt |
			mock fixPosition: aShape position.];
		when: RSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil ].
]
