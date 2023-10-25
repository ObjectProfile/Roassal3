"
A class to change the system coordinates in `RSCanvas` and `RSCamera`
"
Class {
	#name : 'RSCoordinates',
	#superclass : 'RSObject',
	#category : 'Roassal-Camera',
	#package : 'Roassal',
	#tag : 'Camera'
}

{ #category : 'examples' }
RSCoordinates class >> example [
	| canvas |
	canvas := RSCanvas new.
	canvas newCircle radius: 100.
	canvas camera originMode: self originTopLeft.
	^ canvas open
]

{ #category : 'coordinates' }
RSCoordinates class >> originCenterMiddle [
	^ RSCenterMiddleCoordinates new
]

{ #category : 'coordinates' }
RSCoordinates class >> originTopLeft [
	^ RSTopLeftCoordinates new
]

{ #category : 'public' }
RSCoordinates >> fromPixelToSpace: aPoint camera: camera [
	^ (self matrixFor: camera) inverseTransform: aPoint
]

{ #category : 'public' }
RSCoordinates >> fromSpaceToPixel: aPoint camera: camera [
	^ (self matrixFor: camera) transform: aPoint
]

{ #category : 'hooks' }
RSCoordinates >> gapDistance: anRSCamera [
	^ 0@0
]

{ #category : 'hooks' }
RSCoordinates >> gapToCenter: camera [
	^ 0@0
]

{ #category : 'public' }
RSCoordinates >> matrixFor: anRSCamera [
	^ AthensAffineTransform new
		translateBy: (self gapDistance: anRSCamera);
		multiplyBy: anRSCamera matrix;
		yourself
]

{ #category : 'public' }
RSCoordinates >> visibleRectangleFor: anRSCamera [

	| rectangle |
	"returns the visible rectangle in the canvas space"
	rectangle := 0 @ 0 corner: anRSCamera canvas extent.

	^ self visibleRectangleFor: anRSCamera rectangle: rectangle
]

{ #category : 'public' }
RSCoordinates >> visibleRectangleFor: anRSCamera rectangle: aRectangle [

	| matrix |
	"returns the visible rectangle in the canvas space"
	matrix := self matrixFor: anRSCamera.

	^ Rectangle encompassing: (aRectangle corners collect: [ :point |
			   matrix inverseTransform: point ])
]
