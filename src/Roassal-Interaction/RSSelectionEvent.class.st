"
I represent new event with selection for elastic boxes
"
Class {
	#name : 'RSSelectionEvent',
	#superclass : 'RSEvent',
	#instVars : [
		'selectedShapes'
	],
	#category : 'Roassal-Interaction-ElasticBox',
	#package : 'Roassal-Interaction',
	#tag : 'ElasticBox'
}

{ #category : 'accessing' }
RSSelectionEvent >> selectedShapes [
	^ selectedShapes
]

{ #category : 'accessing' }
RSSelectionEvent >> selectedShapes: aRSGroup [
	selectedShapes := aRSGroup
]
