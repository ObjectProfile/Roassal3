"
This class is used by `RSCanvasController class >> #simple `
This is not a default interaction in `RSCanvasController >> #defaultInteractions`

When the canvas is resized this interaction puts the camera view in the top left corner, (this because roassal origin is in the window's center).
Because we have coordinates now, may be we can remove this class.
"
Class {
	#name : 'RSKeepCanvasPositionCanvasInteraction',
	#superclass : 'RSAbstractControlCanvasInteraction',
	#category : 'Roassal-Interaction-Controls',
	#package : 'Roassal-Interaction',
	#tag : 'Controls'
}

{ #category : 'hooks' }
RSKeepCanvasPositionCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSExtentChangedEvent send: #processEvent: to: self.
	self processEvent: aCanvas
]

{ #category : 'events - processing' }
RSKeepCanvasPositionCanvasInteraction >> processEvent: evt [
	| canvas camera r padding topLeftPadding zero origin |
	self removeRectanglesFor: evt canvas.
	camera := evt camera.
	canvas := evt canvas.

	r := self expandedRectangle: canvas.
	padding := self configuration padding.
	topLeftPadding := padding left @ padding top.
	zero := camera fromSpaceToPixel: 0@0.
	origin := camera fromSpaceToPixel: r origin.
	camera translateTo: 0@0 - (origin - zero) - (camera originMode gapDistance: camera).

	self removeRectanglesFor: canvas.
	evt signalUpdate
]

{ #category : 'rendering' }
RSKeepCanvasPositionCanvasInteraction >> renderLegendOn: aLegendBuilder [
]
