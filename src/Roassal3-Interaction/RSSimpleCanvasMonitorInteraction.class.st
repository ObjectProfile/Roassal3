"
I am a simple monitor
"
Class {
	#name : #RSSimpleCanvasMonitorInteraction,
	#superclass : #RSAbstractCanvasMonitor,
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #initialization }
RSSimpleCanvasMonitorInteraction >> initializeShape [
	shape := RSLabel new
		color: Color green;
		yourself
]

{ #category : #update }
RSSimpleCanvasMonitorInteraction >> updateShape [
	shape text: self lastFramePerSecond asString, 'fps'
]
