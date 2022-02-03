"
The intent of this interaction is to be like a scroll from pharo
"
Class {
	#name : #RSKeepCanvasPositionCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #hooks }
RSKeepCanvasPositionCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSExtentChangedEvent send: #processEvent: to: self.
	self processEvent: aCanvas.
]

{ #category : #'events - processing' }
RSKeepCanvasPositionCanvasInteraction >> processEvent: evt [
	| canvas camera |
	self removeRectanglesFor: evt canvas.
	camera := evt camera.
	canvas := evt canvas.
	camera position: (camera fromSpaceToPixel: evt camera position).
	self removeRectanglesFor: evt canvas.
	evt signalUpdate.
]

{ #category : #rendering }
RSKeepCanvasPositionCanvasInteraction >> renderLegendOn: aLegendBuilder [
	
]
