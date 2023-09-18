Extension { #name : #RSDraggableCanvasInteraction }

{ #category : #'*Roassal3-Examples' }
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

{ #category : #'*Roassal3-Examples' }
RSDraggableCanvasInteraction class >> exampleOriginTopLeft [
	| canvas |
	canvas := self canvasExample.
	canvas originTopLeft.
	canvas @ self.
	^ canvas open
]
