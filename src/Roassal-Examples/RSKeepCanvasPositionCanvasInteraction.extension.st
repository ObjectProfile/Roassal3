Extension { #name : 'RSKeepCanvasPositionCanvasInteraction' }

{ #category : '*Roassal-Examples' }
RSKeepCanvasPositionCanvasInteraction class >> example [
	| canvas window |
	canvas := self canvasExample.
	"this interaction is visible when the component changes it extent"
	canvas @ self.
	canvas @ RSDraggableCanvasInteraction.
	window := canvas open.
	window setLabel: 'Drag me'.

	[
	(Delay forSeconds: 5) wait.
	window extent: 300@300 ] fork.
	^ window
]
