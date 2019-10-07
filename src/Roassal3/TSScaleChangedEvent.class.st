"
When canvas changes the scale value of the TSCamera
"
Class {
	#name : #TSScaleChangedEvent,
	#superclass : #TSCanvasEvent,
	#instVars : [
		'oldScale',
		'newScale'
	],
	#category : #'Roassal3-Events'
}

{ #category : #accessing }
TSScaleChangedEvent >> newScale [
	^ newScale
]

{ #category : #accessing }
TSScaleChangedEvent >> newScale: aNumber [
	newScale := aNumber
]

{ #category : #accessing }
TSScaleChangedEvent >> oldScale [
	^ oldScale
]

{ #category : #accessing }
TSScaleChangedEvent >> oldScale: aNumber [
	oldScale := aNumber
]
