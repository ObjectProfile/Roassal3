"
Special event for RSElements and RSEdges, invoked by RSView
"
Class {
	#name : #TSShapedObjectAdded,
	#superclass : #TSCanvasEvent,
	#instVars : [
		'shapedObject'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
TSShapedObjectAdded >> shapedObject [
	^ shapedObject
]

{ #category : #accessing }
TSShapedObjectAdded >> shapedObject: aRSShapedObject [
	"a RSElement or RSEdge"
	shapedObject := aRSShapedObject
]
