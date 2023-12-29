"
I am a camera to control the zoom interaction.
This camera allows to connect the interaction configuration with the zoomToFit interaction.
Also this camera has a configurable`zoomRatio:` default value is 0.9(90%) of the total extent of the canvas.
I work with `RSZoomToFitCanvasInteraction`
"
Class {
	#name : 'RSConfigurableCamera',
	#superclass : 'RSCamera',
	#instVars : [
		'zoomInteraction',
		'zoomRatio'
	],
	#category : 'Roassal-Interaction-Utils',
	#package : 'Roassal-Interaction',
	#tag : 'Utils'
}

{ #category : 'zoom' }
RSConfigurableCamera >> computeScaleFor: anExtent rectangle: rect [
	| sc int canvasRect |
	sc := super computeScaleFor: anExtent rectangle: rect.
	int := self zoomInteraction.
	sc := int scaleFor: sc.
	canvasRect := Rectangle
		floatCenter: rect floatCenter
		extent: canvas extent.
	sc := int configuration shouldUseBasicZoom ifTrue: [
		(canvasRect containsRect: rect)
			ifTrue: [ 1 ]
			ifFalse: [
				int configuration minScale: sc.
				sc ]
	] ifFalse: [ sc ].
	^ sc
]

{ #category : 'accessing' }
RSConfigurableCamera >> zoomInteraction [
	^ zoomInteraction
]

{ #category : 'accessing' }
RSConfigurableCamera >> zoomInteraction: aRSZoomToFitCanvasInteraction [
	zoomInteraction := aRSZoomToFitCanvasInteraction
]

{ #category : 'accessing' }
RSConfigurableCamera >> zoomRatio [
	^ zoomRatio ifNil: [ 0.9 ]
]

{ #category : 'accessing' }
RSConfigurableCamera >> zoomRatio: aNumber [
	zoomRatio := aNumber
]

{ #category : 'zoom' }
RSConfigurableCamera >> zoomToFit [
	| int |
	int := self zoomInteraction.
	self
		zoomToFit: canvas extent * self zoomRatio
		rectangle: (int encompassingRectangleFor: canvas).
	int removeRectanglesFor: canvas.
	canvas signalUpdate
]
