"
TSEvent is the root of all the events handled by Trachel (and therefore Roassal).
"
Class {
	#name : #RSEvent,
	#superclass : #Announcement,
	#instVars : [
		'canvas',
		'morph',
		'shape'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
RSEvent >> camera [
	^ self canvas camera
]

{ #category : #accessing }
RSEvent >> canvas [
	^ canvas ifNil: [ canvas := shape canvas ].
]

{ #category : #accessing }
RSEvent >> canvas: aTrachelCanvas [
	"Set the Trachel canvas"
	canvas := aTrachelCanvas
]

{ #category : #accessing }
RSEvent >> morph [
	^ morph ifNil: [ ^ morph := self canvas morph ]
]

{ #category : #accessing }
RSEvent >> morph: aMorph [
	morph := aMorph
]

{ #category : #accessing }
RSEvent >> shape [
	^ shape
]

{ #category : #accessing }
RSEvent >> shape: aTrachelShape [
	"An event should now the shape to which it is related to. 
	The shape has to be set before emitting the event. See TSShape>>announce:"
	"self assert: [ aTrachelShape isKindOf: TSShape ]."
	shape := aTrachelShape
]

{ #category : #accessing }
RSEvent >> signalUpdate [
	morph notNil ifTrue: [ morph changed ]
	
]
