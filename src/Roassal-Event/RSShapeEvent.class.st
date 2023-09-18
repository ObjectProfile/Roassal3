"
TSShapeEvent represent all events with shapes and the canvas
"
Class {
	#name : #RSShapeEvent,
	#superclass : #RSEvent,
	#instVars : [
		'position'
	],
	#category : #'Roassal3-Event'
}

{ #category : #accessing }
RSShapeEvent >> position [
	^ position ifNil: [ self shape position ]
]

{ #category : #accessing }
RSShapeEvent >> position: aPoint [
	position := aPoint
]

{ #category : #accessing }
RSShapeEvent >> positionFromCamera [
	"Return the position from the camera. I.e., 0 @ 0 is at the center of the window if the camera has not been translated"
	^ canvas
		ifNotNil: [ canvas camera fromPixelToSpace: self position ]
		ifNil: [ -250 @ -250 ]
]
