Class {
	#name : #RSCameraElement,
	#superclass : #BlElement,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal-Bloc-Core'
}

{ #category : #'instance creation' }
RSCameraElement class >> newWithCanvas: aRSCanvas [

	^ self basicNew
		  initializeWithCanvas: aRSCanvas;
		  yourself
]

{ #category : #initialization }
RSCameraElement >> initializeWithCanvas: aRSCanvas [

	self initialize.

	roassalCanvas := aRSCanvas.

	self
"		border: (BlBorder builder paint: Color blue translucent; width: 1; dashArray: #(3 3); build);"
		clipChildren: false;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		updateFromCanvasCamera.
]

{ #category : #accessing }
RSCameraElement >> roassalShape [

	^ roassalCanvas
]

{ #category : #accessing }
RSCameraElement >> updateFromCanvasCamera [
	| matrix |
	matrix := roassalCanvas camera originMatrix asBlMatrix.
	self transformation: (BlElementAbsoluteTransformation matrix: matrix)
]

{ #category : #accessing }
RSCameraElement >> updateFromRoassalShape [
	"The difference with the inherited implementation is to update the camera instead of a shape."
	
	self updateFromCanvasCamera.
	self childrenDo: [ :each | each updateFromRoassalShape ]
]
