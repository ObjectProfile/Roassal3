"
I am a camera to control the zoom interaction
"
Class {
	#name : #RSConfigurableCamera,
	#superclass : #RSCamera,
	#instVars : [
		'zoomInteraction',
		'zoomRatio'
	],
	#category : #'Roassal3-Interaction-Utils'
}

{ #category : #accessing }
RSConfigurableCamera >> zoomInteraction [
	^ zoomInteraction
]

{ #category : #accessing }
RSConfigurableCamera >> zoomInteraction: anInteraction [
	zoomInteraction := anInteraction
]

{ #category : #accessing }
RSConfigurableCamera >> zoomRatio [
	^ zoomRatio ifNil: [ 0.9 ]
]

{ #category : #accessing }
RSConfigurableCamera >> zoomRatio: aNumber [
	zoomRatio := aNumber
]

{ #category : #zoom }
RSConfigurableCamera >> zoomToFit [
	| shapesRect canvasExtent sc canvasRect original int |
	int := self zoomInteraction.
	shapesRect := int encompassingRectangleFor: canvas.
	canvasExtent := canvas extent * self zoomRatio.
	sc := canvasExtent / (self class maxExtentFor: shapesRect).
	original := sc x min: sc y.
	sc := int scaleFor: original.
	canvasRect := Rectangle
		floatCenter: shapesRect floatCenter
		extent: canvas extent / 1.
	self translateTo: shapesRect floatCenter.
	int configuration shouldUseBasicZoom ifTrue: [
		(canvasRect containsRect: shapesRect )
			ifTrue: [ self scale: 1]
			ifFalse: [
				int configuration minScale: original.
				self scale: original ]
	] ifFalse: [ self scale: sc].
	int removeRectanglesFor: canvas.
	canvas signalUpdate
]
