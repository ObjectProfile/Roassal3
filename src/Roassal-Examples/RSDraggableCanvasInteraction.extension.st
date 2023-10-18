Extension { #name : 'RSDraggableCanvasInteraction' }

{ #category : '*Roassal-Examples' }
RSDraggableCanvasInteraction class >> example [
	| canvas interaction |
	canvas := self canvasExample.
	"canvas @ RSDraggableCanvasInteraction."
	interaction := self new.
	interaction hasDraggableAnimation: false.
	canvas @ interaction.
	"or"
	"canvas addInteraction RSDraggableCanvasInteraction new"
	^ canvas open
]

{ #category : '*Roassal-Examples' }
RSDraggableCanvasInteraction class >> exampleOriginTopLeft [
	| canvas |
	canvas := self canvasExample.
	canvas originTopLeft.
	canvas @ self.
	^ canvas open
]
