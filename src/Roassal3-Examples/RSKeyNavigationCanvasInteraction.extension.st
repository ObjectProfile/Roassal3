Extension { #name : 'RSKeyNavigationCanvasInteraction' }

{ #category : '*Roassal3-Examples' }
RSKeyNavigationCanvasInteraction class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas @ self.
	canvas zoomToFit.
	^ canvas open
		setLabel: 'Use key arrows';
		yourself
]

{ #category : '*Roassal3-Examples' }
RSKeyNavigationCanvasInteraction class >> exampleNoHorizontalScroll [
	| canvas interaction |
	canvas := self canvasExample.
	interaction := self new.
	interaction hasHorizontalScrolling: false.
	canvas @ interaction.
	canvas zoomToFit.
	^ canvas open
		setLabel: 'No horizontal scroll';
		yourself
]

{ #category : '*Roassal3-Examples' }
RSKeyNavigationCanvasInteraction class >> exampleNoVerticalScroll [
	| canvas interaction |
	canvas := self canvasExample.
	interaction := self new.
	interaction hasVerticalScrolling: false.
	canvas @ interaction.
	canvas zoomToFit.
	^ canvas open
		setLabel: 'No vertical scroll';
		yourself
]
