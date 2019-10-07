"
When a bounding shape uses extent:, width: or height: I will trigger 
"
Class {
	#name : #TSExtentChangedEvent,
	#superclass : #TSShapeEvent,
	#instVars : [
		'oldExtent',
		'newExtent'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
TSExtentChangedEvent >> newExtent [
	^ newExtent
]

{ #category : #accessing }
TSExtentChangedEvent >> newExtent: anObject [
	newExtent := anObject
]

{ #category : #accessing }
TSExtentChangedEvent >> oldExtent [
	^ oldExtent
]

{ #category : #accessing }
TSExtentChangedEvent >> oldExtent: anExtent [
	oldExtent := anExtent
]
