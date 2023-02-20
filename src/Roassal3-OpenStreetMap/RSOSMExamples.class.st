"
I have examples for open street map based on roassal2 previous examples
"
Class {
	#name : #RSOSMExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #examples }
RSOSMExamples >> example01Basic [
	<script: 'self new example01Basic inspect'>
	| canvas |
	canvas := RSCanvas new.
	canvas add: RSOSM new.
	canvas add: (RSBox new size: 100; draggable).
	canvas @ RSDraggableCanvas @ RSZoomableCanvas.

	canvas camera scale: 0.05.
	^ canvas
]
