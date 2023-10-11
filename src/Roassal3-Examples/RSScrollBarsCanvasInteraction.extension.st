Extension { #name : 'RSScrollBarsCanvasInteraction' }

{ #category : '*Roassal3-Examples' }
RSScrollBarsCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ self.
	^ canvas open
]

{ #category : '*Roassal3-Examples' }
RSScrollBarsCanvasInteraction class >> exampleOriginTopLeft [
	| canvas |
	canvas := self canvasExample.
	canvas originTopLeft.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ self.
	^ canvas open
]
