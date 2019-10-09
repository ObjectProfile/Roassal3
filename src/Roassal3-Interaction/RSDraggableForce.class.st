"
I am a special case to drag elements with the draggable interaction and the RSForceBasedLayout
"
Class {
	#name : #RSDraggableForce,
	#superclass : #TSDraggable,
	#instVars : [
		'layout'
	],
	#category : #'Roassal3-Interaction-Core'
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
RSDraggableForce >> onElement: e [
	| mock |
	super onElement: e.
	e 
		when: TSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: e.
			mock isFixed: true. ];
		when: TSMouseDragging do: [ :evt |
			mock fixPosition: e position.];
		when: TSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil ].
]
