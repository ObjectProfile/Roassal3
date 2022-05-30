"
A control configuration is made to set a configuration for the canvas. For example, by modifying a control configuraiton, you can decide if you wish to have an horizontal scrollbar or no, the minimum zoom, or maximum zoom, the padding, ...

For example:
-=-=--=-=--=-=--=-=-
c := RSCanvas new. 
controller := RSCanvasController new.
controller configuration: (RSControlConfiguration new maxScale: 10).
c @ controller.
-=-=--=-=--=-=--=-=-


-=-=--=-=--=-=--=-=-
canvas := RSCanvas new.
shapes := #('hello' 'world' 'from' 'Roassal3') collect: [ :s | RSLabel new text: s ] as: RSGroup.
canvas addAll: shapes.
RSVerticalLineLayout on: shapes.
int := RSCanvasController new.
int configuration
	minScale: 1;
	maxScale: 3.
canvas @ int.
canvas
-=-=--=-=--=-=--=-=-
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
		'hasVerticalScrolling',
		'hasDraggableAnimation'
	],
	#category : #'Roassal3-Interaction-Utils'
}

{ #category : #configuration }
RSControlConfiguration >> hasDraggableAnimation [
	^ hasDraggableAnimation
]

{ #category : #configuration }
RSControlConfiguration >> hasDraggableAnimation: aBoolean [
	hasDraggableAnimation := aBoolean
]

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
		hasVerticalScrolling: true;
		hasDraggableAnimation: true.
]

{ #category : #accessing }
RSControlConfiguration >> maxScale [
	^ maxScale
]

{ #category : #accessing }
RSControlConfiguration >> maxScale: aNum [
	"Set the maximum scale for the configuration"
	maxScale := aNum
]

{ #category : #accessing }
RSControlConfiguration >> minScale [
	^ minScale
]

{ #category : #accessing }
RSControlConfiguration >> minScale: aNum [
	"Set the minimum scale allowed by the configuration."
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
