Extension { #name : #RSScrollWheelCanvasInteraction }

{ #category : #'*Roassal3-Examples' }
RSScrollWheelCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ self.
	canvas @ RSDraggableCanvasInteraction.
	canvas @ RSKeyNavigationCanvasInteraction.
	canvas @ RSScrollBarsCanvasInteraction.
	canvas when: RSExtentChangedEvent do: [ :evt | canvas zoomToFit; signalUpdate ].
	^ canvas open
		setLabel: 'Use mouse wheel';
		yourself
]
