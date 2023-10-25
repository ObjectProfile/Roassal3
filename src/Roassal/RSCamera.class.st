"
All shapes in Roassal are contained in a `RSCanvas`. The canvas has an infinite 2D dimension. The portion of the canvas that is visible within the window is given by a camera. `RSCamera` describes a camera in Roassal. A camera has a scale and a position. The camera contains a matrix tranformation `AthensAffineTransform`

### Responsibility: 
Identify the portion and the zoom level of a canvas that must be visible. Whenever the canvas is scrolled with the mouse or the key, then the camera is responsible for this.

### Collaborators:
A `RSCanvas` has a `RSCamera`. 

### Variables:
- `position` is a point representing coordinates of the canvas on which the viewing window frame will be centered. Position can be changes with the method `#translateBy:` and `#translateTo:`. Both methods accept morph based coordinates.

- `scale` defines a magnitude of zooming applied to the canvas and its elements.

- `origin` defines system coordinate `RSCoordinates`. By default is `RSCenterMiddleCoordinates` but you can use `RSCamera >> #originMode:` to change it.

*Example*:
```Smalltalk
c := RSCanvas new.
1 to: 100 do: [ :i |
	| g |
	g := RSGroup new.
	g add: (RSEllipse new size: 30; color: Color gray lighter).
	g add: (RSLabel new text: i).
	c add: g asShape ].
RSGridLayout on: c shapes.
camera := c canvas camera.
camera translateBy: 500 @ 50.
camera scale: 0.5.
c
```
"
Class {
	#name : 'RSCamera',
	#superclass : 'RSObject',
	#traits : 'RSTPositionable',
	#classTraits : 'RSTPositionable classTrait',
	#instVars : [
		'scale',
		'canvas',
		'extent',
		'originMode',
		'matrix'
	],
	#category : 'Roassal-Camera',
	#package : 'Roassal',
	#tag : 'Camera'
}

{ #category : 'examples' }
RSCamera class >> example [
	| camera canvas |
	camera := self new.
	camera position: 100@100.
	canvas := RSCanvas new.
	camera canvas: canvas.
	canvas camera: camera.
	^ StInspector openOn: camera
]

{ #category : 'utilities' }
RSCamera class >> maxExtentFor: rectangle [
	^ rectangle extent max: self minimumExtent
]

{ #category : 'utilities' }
RSCamera class >> minimumExtent [
	^ 0.0001 asPoint
]

{ #category : 'accessing coordinates' }
RSCamera class >> originCenterMiddle [
	^ RSCoordinates originCenterMiddle
]

{ #category : 'accessing coordinates' }
RSCamera class >> originTopLeft [
	^ RSCoordinates originTopLeft
]

{ #category : 'visiting' }
RSCamera >> accept: visitor [
	visitor visitCamera: self
]

{ #category : 'announce' }
RSCamera >> announce: anEvent [
	canvas announce: anEvent
]

{ #category : 'accessing' }
RSCamera >> canvas [
	^ canvas
]

{ #category : 'accessing' }
RSCamera >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : 'zoom' }
RSCamera >> computeScaleFor: anExtent rectangle: rect [
	| sc |
	sc := anExtent / (self class maxExtentFor: rect).
	sc := sc x min: sc y.
	^ sc
]

{ #category : 'convertion' }
RSCamera >> distanceFromPixelToSpace: aPoint [
	^ (aPoint / self scale) asFloatPoint
]

{ #category : 'accessing' }
RSCamera >> extent [

	^ extent
]

{ #category : 'convertion' }
RSCamera >> fromPixelToSpace: aPoint [
	^ originMode fromPixelToSpace: aPoint camera: self
]

{ #category : 'convertion' }
RSCamera >> fromSpaceToPixel: aPoint [
	^ originMode fromSpaceToPixel: aPoint camera: self
]

{ #category : 'initialization' }
RSCamera >> initialize [
	super initialize.
	matrix := AthensAffineTransform new.
	scale := 1.000000.
	originMode := RSCoordinates originCenterMiddle
]

{ #category : 'public' }
RSCamera >> invalidate [
	canvas ifNil: [ ^ self ].
	self canvas dirtyRectangle: self visibleRectangle
]

{ #category : 'accessing' }
RSCamera >> matrix [
	^ matrix
]

{ #category : 'accessing' }
RSCamera >> matrix: anAthensAffineTransform [
	matrix := anAthensAffineTransform
]

{ #category : 'public' }
RSCamera >> originMatrix [
	^ originMode matrixFor: self
]

{ #category : 'accessing' }
RSCamera >> originMode [

	"#center or #topLeft"

	^ originMode
]

{ #category : 'accessing' }
RSCamera >> originMode: anObject [

	originMode := anObject
]

{ #category : 'accessing' }
RSCamera >> position [
	"Return the position of the camera. For example:
```
c := RSCanvas new.
c add: (RSEllipse new size: 30).
c camera translateBy: 25 @ 15.
c camera position
```

returns the value `25 @ 15`
"
	^ matrix translation
]

{ #category : 'accessing' }
RSCamera >> position: aPoint [
	"Set the camera position"
	matrix translation: aPoint.
	self invalidate
]

{ #category : 'accessing' }
RSCamera >> positionFromSpace: aPoint [
	| morphPosition zeroPosition |
	morphPosition := self fromSpaceToPixel: aPoint.
	zeroPosition := self fromSpaceToPixel: 0@0.
	^ (morphPosition - zeroPosition) negated + (originMode gapToCenter: self)
]

{ #category : 'private' }
RSCamera >> privExtent: aRect [

	extent := aRect
]

{ #category : 'private' }
RSCamera >> privateScale: aFloatNumber [
	| position |
	scale := aFloatNumber.
	position := matrix translation.
	matrix
		loadIdentity;
		scaleBy: scale;
		translation: position
]

{ #category : 'accessing' }
RSCamera >> scale [
	^ scale
]

{ #category : 'accessing' }
RSCamera >> scale: aFloatNumber [
	"Set the scaling factor applied by the camera. A factor of 1.0 means that no zooming is applied. if the factor is < 1, then the perceived effect is a zoom out. If the factor is > 1, then the effect is a zoom out."

	| oldScale |
	scale = aFloatNumber ifTrue: [ ^ self ].
	oldScale := scale.
	"this method will call loadIdentity in camera matrix"
	self privateScale: aFloatNumber.
	self canvas announce: [
		RSScaleChangedEvent new
			canvas: self canvas;
			oldScale: oldScale;
			newScale: aFloatNumber ].
	self invalidate
]

{ #category : 'public' }
RSCamera >> setMatrix: anAthensAffineTransform [
	anAthensAffineTransform multiplyBy: self originMatrix
]

{ #category : 'accessing' }
RSCamera >> visibleRectangle [
	^ originMode visibleRectangleFor: self
]

{ #category : 'zoom' }
RSCamera >> zoomToFit [
	self zoomToFit: canvas extent * 0.9
]

{ #category : 'zoom' }
RSCamera >> zoomToFit: anExtent [
	self
		zoomToFit: anExtent
		rectangle: canvas encompassingRectangle
]

{ #category : 'zoom' }
RSCamera >> zoomToFit: anExtent extent: otherExtent [
	self
		zoomToFit: anExtent
		rectangle: (Rectangle floatCenter: 0@0 extent: otherExtent)
]

{ #category : 'zoom' }
RSCamera >> zoomToFit: anExtent rectangle: rect [
	| sc |
	sc := (self computeScaleFor: anExtent rectangle: rect).
	"we can improve this method"

	self scale: sc.
	self translateTo: (self positionFromSpace: rect floatCenter)
]
