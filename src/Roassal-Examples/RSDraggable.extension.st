Extension { #name : 'RSDraggable' }

{ #category : '*Roassal-Examples' }
RSDraggable class >> example [
	| canvas |
	canvas := self canvasExample.
	canvas originTopLeft.
	canvas nodes @ self.
	"
	canvas nodes addInteraction: RSDraggable.
	canvas nodes @ RSDraggable new.
	canvas nodes first @ RSDraggable.
	"
	^ canvas open
		setLabel: 'Drag boxes'
]
