"
Gtk drawing area with an Athens canvas
"
Class {
	#name : #GtkAthensDrawingArea,
	#superclass : #GtkDrawingArea,
	#instVars : [
		'activeSurface',
		'rect',
		'adapter',
		'lastExtent',
		'paintMutex'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #private }
GtkAthensDrawingArea class >> drawingAreaNew [
	^ self ffiCall: #( GtkAthensDrawingArea *gtk_drawing_area_new () )
]

{ #category : #accessing }
GtkAthensDrawingArea >> adapter [
	^ adapter
]

{ #category : #accessing }
GtkAthensDrawingArea >> adapter: anObject [
	adapter := anObject
]

{ #category : #drawing }
GtkAthensDrawingArea >> basicDraw: cr [

	self 
		setSourceSurfaceTo: cr
		surface: activeSurface getHandle
		x: 0.0 
		y: 0.0.
	self paint: cr
]

{ #category : #drawing }
GtkAthensDrawingArea >> changed [ 

	super changed.
	self repaint.
]

{ #category : #accessing }
GtkAthensDrawingArea >> critical: aBlock [

	paintMutex ifNil: [ paintMutex := Mutex new ].
	paintMutex critical: aBlock
]

{ #category : #drawing }
GtkAthensDrawingArea >> dpi [

	^ 92
]

{ #category : #drawing }
GtkAthensDrawingArea >> draw: cr [

	self basicDraw: cr.
	^ true
]

{ #category : #drawing }
GtkAthensDrawingArea >> drawOnAthensCanvas: aCanvas [

	"redefine me in subclasses"
]

{ #category : #drawing }
GtkAthensDrawingArea >> extent [ 

	^ 100@100
]

{ #category : #drawing }
GtkAthensDrawingArea >> initialize [

	super initialize.
	
	self vExpand: false.

]

{ #category : #accessing }
GtkAthensDrawingArea >> newCairoSurface [
	| newSurface |
	
	newSurface := AthensCairoSurface extent: self extent.
	^ newSurface
]

{ #category : #drawing }
GtkAthensDrawingArea >> paint: cr [

	self 
		ffiCall: #(void cairo_paint (void *cr))
		module: CairoLibrary
]

{ #category : #accessing }
GtkAthensDrawingArea >> rect [
	^ rect
]

{ #category : #accessing }
GtkAthensDrawingArea >> rect: anObject [
	rect := anObject
]

{ #category : #accessing }
GtkAthensDrawingArea >> repaint [
	| currentExtent |
	currentExtent := self extent.
	currentExtent = lastExtent
		ifFalse: [ self resetSurface ].
	lastExtent := currentExtent.
	self
		critical: [ activeSurface
				drawDuring: [ :canvas | self drawOnAthensCanvas: canvas ] ].
	self queueDraw
]

{ #category : #accessing }
GtkAthensDrawingArea >> resetSurface [

	activeSurface := self newCairoSurface.

]

{ #category : #drawing }
GtkAthensDrawingArea >> setSourceSurfaceTo: cr surface: surface x: x y: y [

	self 
		ffiCall: #(void cairo_set_source_surface (void *cr, void *surface, double x,  double y))
		module: CairoLibrary
]

{ #category : #accessing }
GtkAthensDrawingArea >> sizeRequest: aPoint [

	self setSizeRequestWidth: aPoint x height: aPoint y
]

{ #category : #accessing }
GtkAthensDrawingArea >> viewPortExtent [

	^ adapter rect 
		ifNotNil: [ :aRect | aRect extent ]
		ifNil: [ self extent ]

]
