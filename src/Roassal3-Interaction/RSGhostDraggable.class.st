"
This interaction creates a new box(a ghost box) and it moves the box instead of the entire shape
"
Class {
	#name : #RSGhostDraggable,
	#superclass : #RSInteraction,
	#instVars : [
		'ghost'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSGhostDraggable >> createGhost: evt [
	| shape |
	shape := evt shape.
	ghost := RSBox new
		fromRectangle: shape encompassingRectangle;
		border: (RSBorder new joinMiter; color: Color gray; dashArray: #(7 5));
		noPaint;
		yourself.
		
	shape parent add: ghost.

	
]

{ #category : #hooks }
RSGhostDraggable >> onShape: aShape [
	aShape
		when: RSMouseDragStart send: #createGhost: to: self;
		when: RSMouseDragging send: #updateGhost: to: self;
		when: RSMouseDragEnd send: #removeGhost: to: self.
]

{ #category : #hooks }
RSGhostDraggable >> removeGhost: evt [
	ghost remove.
	evt shape translateTo: ghost position.
	ghost := nil.
	evt signalUpdate.
]

{ #category : #hooks }
RSGhostDraggable >> updateGhost: evt [
	| d |
	d := evt camera distanceFromPixelToSpace: evt step.
	ghost translateBy: d.
	evt signalUpdate 
]
