Class {
	#name : #RSHost,
	#superclass : #RSObject,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSHost >> canvas [

	^ canvas
]

{ #category : #accessing }
RSHost >> canvas: aRSCanvas [

	canvas := aRSCanvas
]

{ #category : #accessing }
RSHost >> defaultWindowTitle [

	^ 'Roassal'
]

{ #category : #opening }
RSHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	^ self subclassResponsibility
]

{ #category : #opening }
RSHost >> signalUpdate [
	"Signal a platform signal that the canvas should be refreshed. This is important when some shapes are modified (color or position)."

	self subclassResponsibility
]
