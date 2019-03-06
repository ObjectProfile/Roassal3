"
When a bounding shape uses extent:, width: or height: I will trigger 
"
Class {
	#name : #TSExtentShapeEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'oldExtent'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSExtentShapeEvent >> oldExtent [
	^ oldExtent
]

{ #category : #accessing }
TSExtentShapeEvent >> oldExtent: anExtent [
	oldExtent := anExtent
]
