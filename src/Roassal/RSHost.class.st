"
A host is a backend object that allows to roassal to render in Morphic orr in other Bloc
"
Class {
	#name : 'RSHost',
	#superclass : 'RSObject',
	#instVars : [
		'canvas'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'examples' }
RSHost class >> example [
	| canvas |
	"default is morphic"
	canvas := RSCanvas new.
	canvas useMorphicHost.
	^ canvas open
]

{ #category : 'accessing' }
RSHost >> canvas [

	^ canvas
]

{ #category : 'accessing' }
RSHost >> canvas: aRSCanvas [

	canvas := aRSCanvas
]

{ #category : 'accessing' }
RSHost >> defaultWindowTitle [

	^ 'Roassal'
]

{ #category : 'opening' }
RSHost >> openWithTitle: aTitleAsString [
	"Open a canvas with a given title"

	^ self subclassResponsibility
]

{ #category : 'opening' }
RSHost >> signalUpdate [
	"Signal a platform signal that the canvas should be refreshed. This is important when some shapes are modified (color or position)."

	self subclassResponsibility
]
