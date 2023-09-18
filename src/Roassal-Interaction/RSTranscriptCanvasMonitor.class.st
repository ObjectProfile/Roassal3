Class {
	#name : #RSTranscriptCanvasMonitor,
	#superclass : #RSAbstractCanvasMonitorInteraction,
	#instVars : [
		'canvasIdString'
	],
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #initialization }
RSTranscriptCanvasMonitor >> initialize [

	canvasIdString := 'RSCanvas#{1}' format: { canvas identityHash }.
	super initialize.

]

{ #category : #initialization }
RSTranscriptCanvasMonitor >> initializeShape [

	shape := RSLabel new
		         text: 'Tracing FPS in Transcript - ', canvasIdString;
		         yourself
]

{ #category : #update }
RSTranscriptCanvasMonitor >> updateShape [
	"Hacky: instead of updating the shape, we trace on the transcript."

	('{1} - {2} fps' format: {
			 canvasIdString.
			 self lastFramePerSecond }) traceCr
]
