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
		'shouldUseBasicZoom',
		'zoomToFitOnStart',
		'zoomToFitOnExtent',
		'hasHorizontalScrolling',
		'hasVerticalScrolling'
	],
	#category : #'Roassal3-Interaction-Utils'
}

{ #category : #'scrollbar managing' }
RSControlConfiguration >> hasHorizontalScrolling [
	^ hasHorizontalScrolling
]

{ #category : #'scrollbar managing' }
RSControlConfiguration >> hasHorizontalScrolling: aBool [
	hasHorizontalScrolling := aBool
]

{ #category : #'scrollbar managing' }
RSControlConfiguration >> hasVerticalScrolling [
	^ hasVerticalScrolling
]

{ #category : #'scrollbar managing' }
RSControlConfiguration >> hasVerticalScrolling: aBool [
	hasVerticalScrolling := aBool
]

{ #category : #initialization }
RSControlConfiguration >> initialize [
	super initialize.
	self 
		minScale: 0.04;
		maxScale: 7;
		padding: 25;
		useZoomToFitOnExtendChanged;
		useZoomToFitOnStart;
		noBasicZoom;
		hasHorizontalScrolling: true;
		hasVerticalScrolling: true.
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
	zoomToFitOnExtent := false
]

{ #category : #configuration }
RSControlConfiguration >> noZoomToFitOnStart [
	zoomToFitOnStart := false.
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
	^ zoomToFitOnExtent
]

{ #category : #testing }
RSControlConfiguration >> shouldZoomToFitOnStart [
	^ zoomToFitOnStart
]

{ #category : #configuration }
RSControlConfiguration >> useBasicZoom [
	shouldUseBasicZoom := true.
]

{ #category : #configuration }
RSControlConfiguration >> useZoomToFitOnExtendChanged [
	zoomToFitOnExtent := true
]

{ #category : #configuration }
RSControlConfiguration >> useZoomToFitOnStart [
	zoomToFitOnStart := true.
]
