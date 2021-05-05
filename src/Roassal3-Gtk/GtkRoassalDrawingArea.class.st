Class {
	#name : #GtkRoassalDrawingArea,
	#superclass : #GtkAthensDrawingArea,
	#instVars : [
		'trachelCanvas',
		'renderer',
		'isDrawing'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #private }
GtkRoassalDrawingArea class >> drawingAreaNew [
	^ self ffiCall: #( #GtkRoassalDrawingArea *gtk_drawing_area_new () )
]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawOnAthensCanvas: aCanvas [

	aCanvas surface clear: Color white.


	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[  
		"self checkSession."
		"self recreateSurfaceIfNecessary."
"		
		aCanvas setPaint: trachelCanvas color.
		aCanvas setPaint: Color red.
		trachelCanvas playAnimations.
	"	self drawShapesWithBackground: trachelCanvas color.
"		activeSurface hasBeenFreed ifTrue: [ self createSurface ].	
"
		aCanvas pathTransform restoreAfter: [
			aCanvas pathTransform loadIdentity.
			aCanvas paintMode restoreAfter: [
				aCanvas 
					setPaint: activeSurface;
					drawShape: (0@0 extent: self extent) ] ] ]
	ensure: [ 
		isDrawing := false ]
]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawOnAthensCanvasOld: aCanvas [

	aCanvas surface clear: Color white.

	"We display the elements that are subject to the camera"
	aCanvas pathTransform
		scaleBy: trachelCanvas camera scale asFloat;
		translateBy: trachelCanvas camera position negated asFloatPoint.
	trachelCanvas
		shapes do: [ :trachelShape | 
			(self shouldRender: trachelShape in: trachelCanvas)
				ifTrue: [ trachelShape drawOn: aCanvas ] ].

	"We display the elements that are _NOT_ subject to the camera"
	aCanvas pathTransform loadIdentity scaleBy: 1.001.
	"trachelCanvas
		fixedShapesDo: [ :trachelShape | 
			trachelShape isMarkedAsVisible
				ifTrue: [ trachelShape drawOn: aCanvas ] ]"
]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawShapes [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	
	activeSurface drawDuring: [ :athensCanvas | 
		| camera canvasRect |
		trachelCanvas clearBackground
			ifTrue: [ activeSurface clear: Color white ].
		"We display the elements that are subject to the camera"
		camera := trachelCanvas camera.
		athensCanvas pathTransform
			"translateBy: (self extent / 2) asFloatPoint;"
			scaleBy: camera scale asFloat;
			translateBy: camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
		canvasRect := Rectangle 
			origin: trachelCanvas camera position
			extent: trachelCanvas extent / camera scale.
		trachelCanvas shapes do: [ :trachelShape | 
			(trachelShape encompassingRectangle intersects: canvasRect)
				ifTrue: [ 
					trachelShape accept: renderer ] ].
		self showRectanglesIfNecessary: trachelCanvas shapes.
		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.0001.
		trachelCanvas fixedShapes do: [ :trachelShape | 
			trachelShape accept: renderer ].
		"debug mode to show encompassingRectangles"
		self showRectanglesIfNecessary: trachelCanvas fixedShapes. ]
		

]

{ #category : #drawing }
GtkRoassalDrawingArea >> drawShapesWithBackground: backgroundColor [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	
	activeSurface drawDuring: [ :athensCanvas | 
		| camera canvasRect |
		trachelCanvas clearBackground
			ifTrue: [ activeSurface clear: backgroundColor ].
		"We display the elements that are subject to the camera"
		camera := trachelCanvas camera.
		athensCanvas pathTransform
			"translateBy: (self extent / 2) asFloatPoint;"
			scaleBy: camera scale asFloat;
			translateBy: camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
		canvasRect := Rectangle 
			origin: trachelCanvas camera position
			extent: trachelCanvas extent / camera scale.
		trachelCanvas shapes do: [ :trachelShape | 
			((trachelShape encompassingRectangle) intersects: canvasRect)
				ifTrue: [ 
					trachelShape accept: renderer ] ].
		self showRectanglesIfNecessary: trachelCanvas shapes.
		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.0001.
		trachelCanvas fixedShapes do: [ :trachelShape | 
			trachelShape accept: renderer ].
		"debug mode to show encompassingRectangles"
		self showRectanglesIfNecessary: trachelCanvas fixedShapes. ]
		

]

{ #category : #drawing }
GtkRoassalDrawingArea >> extent [

	^ self trachelCanvas extent
]

{ #category : #drawing }
GtkRoassalDrawingArea >> initialize [

	super initialize.
	
	renderer := RSAthensRenderer new.
	isDrawing := false.

]

{ #category : #drawing }
GtkRoassalDrawingArea >> shouldRender: aShape in: aTrachelCanvas [

	| shapeRectangle cameraRectangle |

	cameraRectangle := (aTrachelCanvas camera position extent: (aTrachelCanvas extent / aTrachelCanvas camera scale)).
	shapeRectangle := aShape encompassingRectangle.
	
	^ true "aShape isVisible isMarkedAsVisible and: [ (cameraRectangle intersects: shapeRectangle)]"
]

{ #category : #drawing }
GtkRoassalDrawingArea >> showRectanglesIfNecessary: shapes [
	trachelCanvas showRectangles ifFalse: [ ^ self ].
	
	renderer canvas setPaint: (Color blue alpha: 0.2).
	shapes do: [ :shape |
		renderer canvas drawShape: shape encompassingRectangle.
		].
]

{ #category : #drawing }
GtkRoassalDrawingArea >> sizeRequest: aPoint [

	self setSizeRequestWidth: aPoint x height: aPoint y
]

{ #category : #accessing }
GtkRoassalDrawingArea >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
GtkRoassalDrawingArea >> trachelCanvas: anObject [
	trachelCanvas := anObject.
	trachelCanvas morph: self.
	
	activeSurface := self newCairoSurface.
	self repaint
	
"	self sizeRequest: trachelCanvas extent"
]
