"
This interaction creates a new box(a ghost box) and it moves the box instead of the entire shape
"
Class {
	#name : #RSGhostDraggable,
	#superclass : #RSInteraction,
	#instVars : [
		'color'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
RSGhostDraggable >> color [
	^ color ifNil: [ color := Color gray ]
]

{ #category : #accessing }
RSGhostDraggable >> color: anObject [

	color := anObject
]

{ #category : #hooks }
RSGhostDraggable >> createGhost: evt [
	| shape ghost |
	shape := evt shape.
	ghost := shape copy
		fromRectangle: shape encompassingRectangle;
		border: (RSBorder new joinMiter; color: self color; dashArray: #(7 5));
		connectedLines: nil;
		resetChildren;
		noPaint;
		yourself.
	shape propertyAt: #ghost put: ghost.
	shape parent add: ghost
]

{ #category : #hooks }
RSGhostDraggable >> onShape: aShape [
	aShape
		when: RSMouseDragStart send: #createGhost: to: self;
		when: RSMouseDragging send: #updateGhost: to: self;
		when: RSMouseDragEnd send: #removeGhost: to: self
]

{ #category : #hooks }
RSGhostDraggable >> removeGhost: evt [
	| ghost |
	ghost := evt shape propertyAt: #ghost.
	ghost remove.
	evt shape translateTo: ghost position.
	evt shape removeKey: #ghost.
	evt signalUpdate
]

{ #category : #hooks }
RSGhostDraggable >> updateGhost: evt [
	| d |
	d := evt camera distanceFromPixelToSpace: evt step.
	(evt shape propertyAt: #ghost) translateBy: d.
	evt signalUpdate
]
