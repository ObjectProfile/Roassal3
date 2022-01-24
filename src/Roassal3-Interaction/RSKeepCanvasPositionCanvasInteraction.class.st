"
The intent of this interaction is to be like a scroll from pharo
"
Class {
	#name : #RSKeepCanvasPositionCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'animation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #hooks }
RSKeepCanvasPositionCanvasInteraction >> onShape: aCanvas [
	aCanvas when: RSExtentChangedEvent send: #processEvent: to: self.
	self processEvent: aCanvas.
]

{ #category : #'events - processing' }
RSKeepCanvasPositionCanvasInteraction >> processEvent: evt [
	| correct rect |
	self removeRectanglesFor: evt canvas.
	rect := evt canvas encompassingRectangle.
	
	evt camera position: rect floatCenter * -70.
	correct := self correctCameraPosition: evt canvas.
	evt camera position: correct.
	self removeRectanglesFor: evt canvas.
	evt signalUpdate.
]

{ #category : #rendering }
RSKeepCanvasPositionCanvasInteraction >> renderLegendOn: aLegendBuilder [
	
]
