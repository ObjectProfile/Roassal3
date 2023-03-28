"
A class to change the system coordinates in `RSCanvas` and `RSCamera`
"
Class {
	#name : #RSCoordinates,
	#superclass : #RSObject,
	#category : #'Roassal3-Camera'
}

{ #category : #coordinates }
RSCoordinates class >> originCenterMiddle [
	^ RSCenterMiddleCoordinates new
]

{ #category : #coordinates }
RSCoordinates class >> originTopLeft [
	^ RSTopLeftCoordinates new
]

{ #category : #public }
RSCoordinates >> fromPixelToSpace: aPoint camera: camera [
	^ (self matrixFor: camera) inverseTransform: aPoint
]

{ #category : #public }
RSCoordinates >> fromSpaceToPixel: aPoint camera: camera [
	^ (self matrixFor: camera) transform: aPoint
]

{ #category : #hooks }
RSCoordinates >> gapDistance: anRSCamera [
	^ 0@0
]

{ #category : #hooks }
RSCoordinates >> gapToCenter: camera [
	^ 0@0
]

{ #category : #public }
RSCoordinates >> matrixFor: anRSCamera [
	^ AthensAffineTransform new
		translateBy: (self gapDistance: anRSCamera);
		multiplyBy: anRSCamera matrix;
		yourself
]

{ #category : #public }
RSCoordinates >> visibleRectangleFor: anRSCamera [
	| matrix rectangle |
	"returns the visible rectangle in the canvas space"
	matrix := self matrixFor: anRSCamera.
	rectangle := 0@0 corner: anRSCamera canvas extent.
	
	^ Rectangle encompassing: ( rectangle corners collect: [:point | 
		matrix inverseTransform: point]).
]
