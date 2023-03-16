"
<keyClass>
All shapes in Roassal are contained in a `RSCanvas`. The canvas has an infinite 2D dimension. The portion of the canvas that is visible within the window is given by a camera. `RSCamera` describes a camera in Roassal. A camera has a scale and a position.

*Responsibility*: identify the portion and the zoom level of a canvas that must be visible. Whenever the canvas is scrolled with the mouse or the key, then the camera is responsible for this.

*Collaborators*: A `RSCanvas` has a `RSCamera`. 

*Variables*:
`position` is a point representing coordinates of the canvas on which the viewing window frame will be centered. Position can be changes with the method `#translateBy:` and `#translateTo:`. Both methods accept canvas based coordinates

`scale` defines a magnitude of zooming applied to the canvas and its elements.

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
	#name : #RSCamera,
	#superclass : #RSObject,
	#traits : 'RSTPositionable',
	#classTraits : 'RSTPositionable classTrait',
	#instVars : [
		'scale',
		'position',
		'canvas',
		'extent',
		'originMode'
	],
	#category : #'Roassal3-Camera'
}

{ #category : #utilities }
RSCamera class >> maxExtentFor: rectangle [
	^ rectangle extent max: self minimumExtent
]

{ #category : #utilities }
RSCamera class >> minimumExtent [
	^ 0.0001 asPoint
]

{ #category : #visiting }
RSCamera >> accept: visitor [
	visitor visitCamera: self
]

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

{ #category : #accessing }
RSCamera >> extent [

	^ extent
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
	scale := 1.000000.
	originMode := #center
]

{ #category : #accessing }
RSCamera >> originMode [

	"#center or #topLeft"

	^ originMode
]

{ #category : #accessing }
RSCamera >> originMode: anObject [

	originMode := anObject
]

{ #category : #accessing }
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
	^ position
]

{ #category : #accessing }
RSCamera >> position: aPoint [
	"Set the camera position"
 	position := aPoint
]

{ #category : #private }
RSCamera >> privExtent: aRect [

	extent := aRect
]

{ #category : #accessing }
RSCamera >> scale [
	^ scale
]

{ #category : #accessing }
RSCamera >> scale: aFloatNumber [
	"Set the scaling factor applied by the camera. A factor of 1.0 means that no zooming is applied. if the factor is < 1, then the perceived effect is a zoom out. If the factor is > 1, then the effect is a zoom out."
	| oldScale |
	scale = aFloatNumber ifTrue: [ ^ self ].
	oldScale := scale.
	scale := aFloatNumber.
	self canvas announce: [ RSScaleChangedEvent new
		canvas: self canvas;
		oldScale: oldScale;
		newScale: aFloatNumber ]
]

{ #category : #public }
RSCamera >> setMatrix: anAthensAffineTransform [
	anAthensAffineTransform
		translateBy: (self canvas extent / 2) asFloatPoint;
		scaleBy: self scale asFloat;
		translateBy: self position negated asFloatPoint
]

{ #category : #accessing }
RSCamera >> visibleRectangle [
	^ Rectangle
		floatCenter: self position
		extent: self canvas extent / self scale
]

{ #category : #zoom }
RSCamera >> zoomToFit [
	self zoomToFit: canvas extent * 0.9
]

{ #category : #zoom }
RSCamera >> zoomToFit: anExtent [
	self
		zoomToFit: anExtent
		rectangle: canvas encompassingRectangle
]

{ #category : #zoom }
RSCamera >> zoomToFit: anExtent extent: otherExtent [
	self
		zoomToFit: anExtent
		rectangle: (Rectangle floatCenter: 0@0 extent: otherExtent)
]

{ #category : #zoom }
RSCamera >> zoomToFit: anExtent rectangle: rect [
	| sc |
	sc := anExtent / (self class maxExtentFor: rect).
	sc := sc x min: sc y.
	self
		translateTo: rect floatCenter;
		scale: sc
]
