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
	#name : #RSCamera,
	#superclass : #RSObject,
	#traits : 'TPositionable',
	#classTraits : 'TPositionable classTrait',
	#instVars : [
		'scale',
		'position',
		'canvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #announce }
RSCamera >> announce: anEvent [
	canvas announce: anEvent
]

{ #category : #accessing }
RSCamera >> canvas [
	^ canvas
]

{ #category : #accessing }
RSCamera >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #convertion }
RSCamera >> distanceFromPixelToSpace: aPoint [
	^ (aPoint / self scale) asFloatPoint
]

{ #category : #convertion }
RSCamera >> fromPixelToSpace: aPoint [

	^ AthensAffineTransform new
		translateBy: self position;
		scaleBy: 1 / self scale;
		translateBy: (self canvas extent / 2) negated;
		transform: aPoint
]

{ #category : #convertion }
RSCamera >> fromSpaceToPixel: aPoint [

	^ AthensAffineTransform new
		translateBy: self canvas extent / 2;
		scaleBy: self scale;
		translateBy: self position negated;
		transform: aPoint
	
]

{ #category : #initialization }
RSCamera >> initialize [
	super initialize.
	position := 0@0.
	scale := 1.0000001.
]

{ #category : #accessing }
RSCamera >> position [
	^ position
]

{ #category : #accessing }
RSCamera >> position: aPoint [
 	position := aPoint
]

{ #category : #accessing }
RSCamera >> scale [
	^ scale
]

{ #category : #accessing }
RSCamera >> scale: aNumber [
	| oldScale |
	scale = aNumber ifTrue: [ ^ self ].
	oldScale := scale.
	scale := aNumber.
	self canvas announce: [ RSScaleChangedEvent new
		canvas: self canvas;
		oldScale: oldScale;
		newScale: aNumber ]
]

{ #category : #actions }
RSCamera >> translateTo: aPoint [
	| oldPosition |
	oldPosition := self position.
	oldPosition = aPoint ifTrue: [ ^ self ].
	self position: aPoint.
	self announce: [RSPositionChangedEvent new 
		shape: self; 
		oldPosition: oldPosition;
		newPosition: aPoint ].

]

{ #category : #actions }
RSCamera >> zoomToFit: anExtent [
	self 
		zoomToFit: anExtent 
		rectangle: canvas encompassingRectangle
	
]

{ #category : #actions }
RSCamera >> zoomToFit: anExtent extent: otherExtent [
	self 
		zoomToFit: anExtent 
		rectangle: (Rectangle rsCenter: 0@0 extent: otherExtent)
	
]

{ #category : #actions }
RSCamera >> zoomToFit: anExtent rectangle: rect [
	| sc |
	sc := anExtent / (rect extent max: 1 @ 1).
	sc := sc x min: sc y.
	self 
		translateTo: rect rsCenter;
		scale: sc.
]
