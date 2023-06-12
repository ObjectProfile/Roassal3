Extension { #name : #RSZoomableCanvasInteraction }

{ #category : #'*Roassal3-Examples' }
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
