"
When a bounding shape uses extent:, width: or height: I will trigger 
"
Class {
	#name : #RSExtentChangedEvent,
	#superclass : #RSShapeEvent,
	#instVars : [
		'oldExtent',
		'newExtent'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
RSExtentChangedEvent >> newExtent [
	^ newExtent
]

{ #category : #accessing }
RSExtentChangedEvent >> newExtent: anObject [
	newExtent := anObject
]

{ #category : #accessing }
RSExtentChangedEvent >> oldExtent [
	^ oldExtent
]

{ #category : #accessing }
RSExtentChangedEvent >> oldExtent: anExtent [
	oldExtent := anExtent
]
