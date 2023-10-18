Extension { #name : 'RSGhostDraggable' }

{ #category : '*Roassal-Examples' }
RSGhostDraggable class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas nodes @ self.
	^ canvas open
		setLabel: 'Drag and find the ghost'
]

{ #category : '*Roassal-Examples' }
RSGhostDraggable class >> exampleChangeColor [
	| canvas int |
	canvas := self canvasExample.
	int := self new.
	int color: Color red.
	canvas nodes @ int.
	^ canvas open
		setLabel: 'Drag and find the ghost'
]
