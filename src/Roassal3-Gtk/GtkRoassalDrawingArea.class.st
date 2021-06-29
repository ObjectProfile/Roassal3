"
Gtk Athens drawing area with an associated Roassal canvas
"
Class {
	#name : #GtkRoassalDrawingArea,
	#superclass : #GtkAthensDrawingArea,
	#instVars : [
		'canvas',
		'renderer',
		'isDrawing'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #private }
GtkRoassalDrawingArea class >> drawingAreaNew [
	^ self ffiCall: #( #GtkRoassalDrawingArea *gtk_drawing_area_new () )
]

{ #category : #accessing }
GtkRoassalDrawingArea >> canvas [
	^ canvas
]

{ #category : #accessing }
GtkRoassalDrawingArea >> canvas: anObject [
	canvas := anObject.
	canvas morph: self.
	
	activeSurface := self newCairoSurface.
	self repaint
]

{ #category : #private }
GtkRoassalDrawingArea >> checkSession [
]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawOnAthensCanvas: anAthensCanvas [

	anAthensCanvas surface clear: canvas color.

	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[  
		self checkSession.
		
		anAthensCanvas setPaint: canvas color.
		canvas playAnimations.
	
		self drawShapesWithBackground: canvas color.

		anAthensCanvas pathTransform restoreAfter: [
			anAthensCanvas pathTransform loadIdentity.
			anAthensCanvas paintMode restoreAfter: [
				anAthensCanvas 
					setPaint: activeSurface;
					drawShape: (0@0 extent: self extent) ] ] ]
	ensure: [ 
		isDrawing := false ]
]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawShapesWithBackground: backgroundColor [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	
	activeSurface drawDuring: [ :athensCanvas | 
		| camera canvasRect |
		canvas clearBackground
			ifTrue: [ activeSurface clear: backgroundColor ].
		"We display the elements that are subject to the camera"
		camera := canvas camera.

		camera originMode = #center ifTrue: [ 
			athensCanvas pathTransform translateBy: (self extent / 2) asFloatPoint ].
		
		athensCanvas pathTransform
			scaleBy: camera scale asFloat;
			translateBy: camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
		canvasRect := Rectangle 
			origin: canvas camera position
			extent: canvas extent / camera scale.
		canvas shapes do: [ :trachelShape | 
			((trachelShape encompassingRectangle) intersects: canvasRect)
				ifTrue: [ 
					trachelShape accept: renderer ] ].
		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.0001.
		canvas fixedShapes do: [ :trachelShape | 
			trachelShape accept: renderer ].
		"debug mode to show encompassingRectangles"
		self showRectanglesIfNecessary: canvas fixedShapes. ]
		

]

{ #category : #accessing }
GtkRoassalDrawingArea >> extent [

	^ self canvas extent
]

{ #category : #initialization }
GtkRoassalDrawingArea >> initialize [

	super initialize.
	
	renderer := RSAthensRenderer new.
	isDrawing := false.

]

{ #category : #drawing }
GtkRoassalDrawingArea >> showRectanglesIfNecessary: shapes [
	canvas showRectangles ifFalse: [ ^ self ].
	
	renderer canvas setPaint: (Color blue alpha: 0.2).
	shapes do: [ :shape |
		renderer canvas drawShape: shape encompassingRectangle.
		].
]

{ #category : #drawing }
GtkRoassalDrawingArea >> sizeRequest: aPoint [

	self setSizeRequestWidth: aPoint x height: aPoint y
]