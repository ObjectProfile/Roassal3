"
I'm a RSHost that represents a RSCanvas as BlElement instances, eventually in a BlSpace (window).
"
Class {
	#name : #RSBlocHost,
	#superclass : #RSHost,
	#instVars : [
		'space',
		'canvasElement'
	],
	#category : #'Roassal3-Bloc-Core'
}

{ #category : #opening }
RSBlocHost >> canvasElement [
	"Analog to RSCanvas>>createMorph"

	^ canvasElement ifNil: [
		canvasElement := RSCanvasElement newWithCanvas: canvas.
		canvasElement ]
]

{ #category : #accessing }
RSBlocHost >> defaultWindowTitle [

	^ super defaultWindowTitle , ' - Bloc'
]

{ #category : #opening }
RSBlocHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	space := BlSpace new
		extent: canvas extent;
		title: aTitleAsString;
		yourself.

	space addChild: self canvasElement.
	space show.

	^ space

]

{ #category : #refreshing }
RSBlocHost >> signalUpdate [
	"Request a redraw on the canvas."

	"Skip it if the canvas was already opened."
	canvasElement ifNil: [ ^ self ].
	canvasElement signalUpdate
]

{ #category : #accessing }
RSBlocHost >> space [
	"Answer the BlSpace where the the canvas has been opened. If it wasn't opened, the answer is nil."

	^ space
]
