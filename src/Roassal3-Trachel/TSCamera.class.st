"
I am main tool which helps to move across Trachel's canvas.

My two main properties are position and scale.

- position 
  is a point representing coordinates of the canvas on which the ""viewing window"" will be centered.
  position can be changes with:
  * #translateBy:
  * #translateTo:
  both methods accept canvas based coordinates

- scale
  defines a magnitude of zooming applied to the canvas and it's elements.

"
Class {
	#name : #TSCamera,
	#superclass : #TSObject,
	#instVars : [
		'scale',
		'position',
		'canvas'
	],
	#category : #'Roassal3-Trachel-Core'
}

{ #category : #accessing }
TSCamera >> canvas [
	^ canvas
]

{ #category : #accessing }
TSCamera >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #convertion }
TSCamera >> distanceFromPixelToSpace: aPoint [
	^ (aPoint / self scale) asFloatPoint
]

{ #category : #convertion }
TSCamera >> fromPixelToSpace: aPoint [

	^ AthensAffineTransform new
		translateBy: self position;
		scaleBy: 1 / self scale;
		translateBy: (self canvas extent / 2) negated;
		transform: aPoint
]

{ #category : #convertion }
TSCamera >> fromSpaceToPixel: aPoint [

	^ AthensAffineTransform new
		translateBy: self canvas extent / 2;
		scaleBy: self scale;
		translateBy: self position negated;
		transform: aPoint
	
]

{ #category : #initialization }
TSCamera >> initialize [
	super initialize.
	position := 0@0.
	scale := 1.0000001.
]

{ #category : #accessing }
TSCamera >> position [
	^ position
]

{ #category : #accessing }
TSCamera >> position: aPoint [
 	position := aPoint
]

{ #category : #accessing }
TSCamera >> scale [
	^ scale
]

{ #category : #accessing }
TSCamera >> scale: aNumber [
	scale := aNumber
]

{ #category : #actions }
TSCamera >> translateBy: aPoint [
	self translateTo: self position + aPoint.
]

{ #category : #actions }
TSCamera >> translateTo: aPoint [
	self position: aPoint
]

{ #category : #actions }
TSCamera >> zoomToFit: anExtent [
	self 
		zoomToFit: anExtent 
		rectangle: canvas encompassingRectangle
	
]

{ #category : #actions }
TSCamera >> zoomToFit: anExtent extent: otherExtent [
	self 
		zoomToFit: anExtent 
		rectangle: (Rectangle rsCenter: 0@0 extent: otherExtent)
	
]

{ #category : #actions }
TSCamera >> zoomToFit: anExtent rectangle: rect [
	| sc |
	sc := anExtent / (rect extent max: 1 @ 1).
	sc := sc x min: sc y.
	self 
		translateTo: rect rsCenter;
		scale: sc.
]
