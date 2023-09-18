"
called when user changes the selection area with mouse dragging event
"
Class {
	#name : #RSSelectionChangedEvent,
	#superclass : #RSSelectionEvent,
	#instVars : [
		'oldSelectedShapes'
	],
	#category : #'Roassal3-Interaction-ElasticBox'
}

{ #category : #accessing }
RSSelectionChangedEvent >> oldSelectedShapes [
	^ oldSelectedShapes
]

{ #category : #accessing }
RSSelectionChangedEvent >> oldSelectedShapes: aRSGroup [
	oldSelectedShapes := aRSGroup
]
