"
I am a simple monitor
"
Class {
	#name : 'RSSimpleCanvasMonitorInteraction',
	#superclass : 'RSAbstractCanvasMonitorInteraction',
	#category : 'Roassal-Interaction-Extra',
	#package : 'Roassal-Interaction',
	#tag : 'Extra'
}

{ #category : 'initialization' }
RSSimpleCanvasMonitorInteraction >> initializeShape [
	shape := RSLabel new
		color: Color green;
		yourself
]

{ #category : 'update' }
RSSimpleCanvasMonitorInteraction >> updateShape [
	shape text: self lastFramePerSecond asString, 'fps'
]
