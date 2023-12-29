"
I'm a BlElement that has as children the representation of the regular RSShapes of a RSCanvas. 

Such regular shapes must be translated and scaled according to the camera.
"
Class {
	#name : #RSCameraElement,
	#superclass : #BlElement,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal-Bloc-Elements'
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
		updateFromCanvasCamera
]

{ #category : #accessing }
RSCameraElement >> roassalShape [

	^ roassalCanvas
]

{ #category : #accessing }
RSCameraElement >> updateFromCanvasCamera [

	| aMatrix |
	aMatrix := roassalCanvas camera originMatrix asBlMatrix.
	self transformation: (BlElementAbsoluteTransformation matrix: aMatrix)
]

{ #category : #accessing }
RSCameraElement >> updateFromRoassalShape [
	"The difference with the inherited implementation is to update the camera instead of a shape."
	
	self updateFromCanvasCamera.
	self childrenDo: [ :each | each updateFromRoassalShape ]
]
