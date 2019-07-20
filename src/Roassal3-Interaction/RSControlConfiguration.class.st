"
I have basic information of RSControlsView
"
Class {
	#name : #RSControlConfiguration,
	#superclass : #RSObject,
	#instVars : [
		'padding',
		'maxScale',
		'minScale',
		'shouldZoomToFit',
		'shouldUseBasicZoom'
	],
	#category : #'Roassal3-Interaction-Utils'
}

{ #category : #initialization }
RSControlConfiguration >> initialize [
	super initialize.
	self 
		minScale: 0.04;
		maxScale: 7;
		padding: 25;
		useZoomToFitOnExtendChanged;
		noBasicZoom.
]

{ #category : #accessing }
RSControlConfiguration >> maxScale [
	^ maxScale
]

{ #category : #accessing }
RSControlConfiguration >> maxScale: aNum [
	maxScale := aNum
]

{ #category : #accessing }
RSControlConfiguration >> minScale [
	^ minScale
]

{ #category : #accessing }
RSControlConfiguration >> minScale: aNum [
	minScale := aNum
]

{ #category : #configuration }
RSControlConfiguration >> noBasicZoom [
	shouldUseBasicZoom := false.
]

{ #category : #configuration }
RSControlConfiguration >> noZoomToFitOnExtendChanged [
	shouldZoomToFit := false
]

{ #category : #accessing }
RSControlConfiguration >> padding [
	^ padding
]

{ #category : #accessing }
RSControlConfiguration >> padding: aMargin [
	padding := aMargin asMargin
]

{ #category : #testing }
RSControlConfiguration >> shouldUseBasicZoom [
	^ shouldUseBasicZoom
]

{ #category : #testing }
RSControlConfiguration >> shouldZoomToFitOnExtendChanged [
	^ shouldZoomToFit
]

{ #category : #configuration }
RSControlConfiguration >> useBasicZoom [
	shouldUseBasicZoom := true.
]

{ #category : #configuration }
RSControlConfiguration >> useZoomToFitOnExtendChanged [
	shouldZoomToFit := true
]
