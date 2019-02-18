"
When canvas changes of size for a window resizes
"
Class {
	#name : #TSResizeCanvasEvent,
	#superclass : #TSEvent,
	#instVars : [
		'newExtent',
		'oldExtent'
	],
	#category : #'Roassal3-Trachel-Events'
}

{ #category : #accessing }
TSResizeCanvasEvent >> newExtent [
	^ newExtent
]

{ #category : #accessing }
TSResizeCanvasEvent >> newExtent: aPoint [
	newExtent := aPoint
]

{ #category : #accessing }
TSResizeCanvasEvent >> oldExtent [
	^ oldExtent
]

{ #category : #accessing }
TSResizeCanvasEvent >> oldExtent: aPoint [
	oldExtent := aPoint
]
