"
TSShapeEvent represent all events with shapes and the canvas
"
Class {
	#name : 'RSShapeEvent',
	#superclass : 'RSEvent',
	#instVars : [
		'position'
	],
	#category : 'Roassal-Event',
	#package : 'Roassal-Event'
}

{ #category : 'accessing' }
RSShapeEvent >> fromEvent: aMorphicEvent [
	"this method is to transform the current position into a new position"
]

{ #category : 'accessing' }
RSShapeEvent >> position [
	^ position ifNil: [ self shape position ]
]

{ #category : 'accessing' }
RSShapeEvent >> position: aPoint [
	position := aPoint
]

{ #category : 'private' }
RSShapeEvent >> positionFromCamera [
	"Return the position from the camera. I.e., 0 @ 0 is at the center of the window if the camera has not been translated"
	self position: (canvas camera fromPixelToSpace: self position)
]
