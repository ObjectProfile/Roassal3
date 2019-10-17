"
I have basic information of RSControlsView
"
Class {
	#name : #TSControlConfiguration,
	#superclass : #TSObject,
	#instVars : [
		'padding',
		'maxScale',
		'minScale',
		'shouldUseBasicZoom',
		'zoomToFitOnStart',
		'zoomToFitOnExtent'
	],
	#category : #'Roassal3-Interaction-Utils'
}

{ #category : #initialization }
TSControlConfiguration >> initialize [
	super initialize.
	self 
		minScale: 0.04;
		maxScale: 7;
		padding: 25;
		useZoomToFitOnExtendChanged;
		useZoomToFitOnStart;
		noBasicZoom.
]

{ #category : #accessing }
TSControlConfiguration >> maxScale [
	^ maxScale
]

{ #category : #accessing }
TSControlConfiguration >> maxScale: aNum [
	maxScale := aNum
]

{ #category : #accessing }
TSControlConfiguration >> minScale [
	^ minScale
]

{ #category : #accessing }
TSControlConfiguration >> minScale: aNum [
	minScale := aNum
]

{ #category : #configuration }
TSControlConfiguration >> noBasicZoom [
	shouldUseBasicZoom := false.
]

{ #category : #configuration }
TSControlConfiguration >> noZoomToFitOnExtendChanged [
	zoomToFitOnExtent := false
]

{ #category : #configuration }
TSControlConfiguration >> noZoomToFitOnStart [
	zoomToFitOnStart := false.
]

{ #category : #accessing }
TSControlConfiguration >> padding [
	^ padding
]

{ #category : #accessing }
TSControlConfiguration >> padding: aMargin [
	padding := aMargin asMargin
]

{ #category : #testing }
TSControlConfiguration >> shouldUseBasicZoom [
	^ shouldUseBasicZoom
]

{ #category : #testing }
TSControlConfiguration >> shouldZoomToFitOnExtendChanged [
	^ zoomToFitOnExtent
]

{ #category : #testing }
TSControlConfiguration >> shouldZoomToFitOnStart [
	^ zoomToFitOnStart
]

{ #category : #configuration }
TSControlConfiguration >> useBasicZoom [
	shouldUseBasicZoom := true.
]

{ #category : #configuration }
TSControlConfiguration >> useZoomToFitOnExtendChanged [
	zoomToFitOnExtent := true
]

{ #category : #configuration }
TSControlConfiguration >> useZoomToFitOnStart [
	zoomToFitOnStart := true.
]
