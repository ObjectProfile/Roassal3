Extension { #name : 'RSZoomableCanvasInteraction' }

{ #category : '*Roassal-Examples' }
RSZoomableCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ self.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ RSScrollBarsCanvasInteraction.
	canvas @ RSZoomToFitCanvasInteraction.
	^ canvas open
]
