"
TSEvent is the root of all the events handled by Trachel (and therefore Roassal).
"
Class {
	#name : #TSEvent,
	#superclass : #Announcement,
	#instVars : [
		'canvas',
		'morph'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSEvent >> canvas [
	^ canvas
]

{ #category : #accessing }
TSEvent >> canvas: aTrachelCanvas [
	"Set the Trachel canvas"
	canvas := aTrachelCanvas
]

{ #category : #accessing }
TSEvent >> morph [
	^ morph
]

{ #category : #accessing }
TSEvent >> morph: aMorph [
	morph := aMorph
]

{ #category : #accessing }
TSEvent >> signalUpdate [
	morph notNil ifTrue: [ morph changed ]
	
]
