"
Special event for RSElements and RSEdges, invoked by RSView
"
Class {
	#name : #RSShapedObjectAdded,
	#superclass : #RSCanvasEvent,
	#instVars : [
		'shapedObject'
	],
	#category : #'Roassal3-Scripting-Events'
}

{ #category : #accessing }
RSShapedObjectAdded >> shapedObject [
	^ shapedObject
]

{ #category : #accessing }
RSShapedObjectAdded >> shapedObject: aRSShapedObject [
	"a RSElement or RSEdge"
	shapedObject := aRSShapedObject
]
