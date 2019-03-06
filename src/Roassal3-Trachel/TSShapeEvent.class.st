"
TSShapeEvent represent all events with shapes and the canvas
"
Class {
	#name : #TSShapeEvent,
	#superclass : #TSEvent,
	#instVars : [
		'position',
		'shape'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSShapeEvent >> canvas [
	^ canvas ifNil: [ canvas := shape canvas ].
]

{ #category : #accessing }
TSShapeEvent >> morph [
	^ morph ifNil: [ ^ morph := self canvas morph ]
]

{ #category : #accessing }
TSShapeEvent >> position [ 
	^ position ifNil: [ self shape position ]
]

{ #category : #accessing }
TSShapeEvent >> position: anObject [
	position := anObject 
]

{ #category : #accessing }
TSShapeEvent >> positionFromCamera [
	"Return the position from the camera. I.e., 0 @ 0 is at the center of the window if the camera has not been translated"
	^ canvas 
		ifNotNil: [ canvas camera fromPixelToSpace: self position ]
		ifNil: [ -250 @ -250 ]

]

{ #category : #accessing }
TSShapeEvent >> shape [
	^ shape
]

{ #category : #accessing }
TSShapeEvent >> shape: aTrachelShape [
	shape := aTrachelShape
]
