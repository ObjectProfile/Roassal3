Class {
	#name : #RSCameraElement,
	#superclass : #BlElement,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal3-Bloc-Core'
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

	self transformDo: [ :aBuilder | 
		aBuilder
			centerOrigin;
			translateBy: (roassalCanvas extent / 2) asFloatPoint;
			translateBy: roassalCanvas camera position negated asFloatPoint;
			scaleBy: roassalCanvas camera scale asFloat;
			yourself ]
]

{ #category : #accessing }
RSCameraElement >> updateFromRoassalShape [
	"The difference with the inherited implementation is to update the camera instead of a shape."
	
	self updateFromCanvasCamera.
	self childrenDo: [ :each | each updateFromRoassalShape ]
]
