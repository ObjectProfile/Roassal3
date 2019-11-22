"
I am a camera to control the zoom interaction
"
Class {
	#name : #RSConfigurableCamera,
	#superclass : #RSCamera,
	#instVars : [
		'zoomInteraction'
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

{ #category : #zoom }
RSConfigurableCamera >> zoomToFit [
	| shapesRect extent sc canvasRect original int |
	int := self zoomInteraction.
	shapesRect := int encompassingRectangleFor: canvas.
	extent := canvas extent * 0.9.
	sc := extent / (shapesRect extent max: 1 @ 1).
	original := sc x min: sc y.
	sc := int scaleFor: original.
	canvasRect := Rectangle 
		rsCenter: shapesRect rsCenter
		extent: canvas extent / 1.
	self translateTo: shapesRect rsCenter.
	int configuration shouldUseBasicZoom ifTrue: [ 
		(canvasRect containsRect: shapesRect )
			ifTrue: [ self scale: 1]
			ifFalse: [
				int configuration minScale: original.
				self scale: original ]
	] ifFalse: [ self scale: sc].
	int removeRectanglesFor: canvas.
	canvas signalUpdate.
	
]
