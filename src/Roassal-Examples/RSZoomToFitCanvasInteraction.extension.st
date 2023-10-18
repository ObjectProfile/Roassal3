Extension { #name : 'RSZoomToFitCanvasInteraction' }

{ #category : '*Roassal-Examples' }
RSZoomToFitCanvasInteraction class >> example [
	| canvas interaction |
	canvas := self canvasExample.
	canvas originTopLeft.
	interaction := self new.

	interaction useZoomToFitOnStart; useZoomToFitOnExtentChanged.

	canvas @ interaction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSScrollBarsCanvasInteraction.
	^ canvas open
		setLabel: 'Resize the window';
		yourself
]
