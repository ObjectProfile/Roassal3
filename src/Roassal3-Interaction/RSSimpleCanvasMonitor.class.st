"
I am a simple monitor
"
Class {
	#name : #RSSimpleCanvasMonitor,
	#superclass : #RSAbstractCanvasMonitor,
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #initialization }
RSSimpleCanvasMonitor >> initializeShape [
	shape := RSLabel new
		color: Color green;
		yourself
]

{ #category : #update }
RSSimpleCanvasMonitor >> updateShape [
	shape text: self lastFramePerSecond asString, 'fps'
]
