"
Gtk Roassal canvas drawing area with scrollbars and overlay for putting Gtk elements into the canvas.
"
Class {
	#name : #GtkRoassalDrawingAreaBox,
	#superclass : #GtkBox,
	#instVars : [
		'drawingArea',
		'horizontalScrollbar',
		'verticalScrollbar',
		'verticalAdjustment',
		'horizontalAdjustment',
		'lastEncompassingRectangle',
		'lastHAdjustment',
		'lastVAdjustment',
		'lastCameraPosition',
		'lastScale',
		'overlayInfo'
	],
	#pools : [
		'GdkEventMask'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #'instance creation' }
GtkRoassalDrawingAreaBox class >> boxNewOrientation: orientation spacing: spacing [

	^ self ffiCall: #(GtkRoassalDrawingAreaBox *gtk_box_new (GtkOrientation orientation, gint spacing))
]

{ #category : #'instance creation' }
GtkRoassalDrawingAreaBox class >> new [ 

	^ (self boxNewOrientation: GTK_ORIENTATION_HORIZONTAL spacing: 0) initialize
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> adapter: anAdapter [

	drawingArea adapter: anAdapter
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> camera [
	
	^ self gtkTrachel canvas camera
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> cameraRectangle [ 

	^ self camera position extent: (self canvas extent / self camera scale)
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> canvas [
	
	^ self gtkTrachel canvas
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> canvas: aCanvas [

	drawingArea canvas: aCanvas.

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> encompassingRectangle [

	| anEncompassingRectangle |
	anEncompassingRectangle := drawingArea canvas encompassingRectangle.
	^ (0@0 min: anEncompassingRectangle topLeft) corner: (anEncompassingRectangle bottomRight) 
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> extent [

	^ drawingArea canvas extent
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> gtkTrachel [
	^ drawingArea
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> gtkTrachel: anObject [
	drawingArea := anObject.

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> initialize [

	| horizontalOrientation verticalOrientation vbox  |

	super initialize.
	drawingArea := GtkRoassalDrawingArea new.
	
	drawingArea addDependent: self.

	horizontalOrientation := GtkOrientation GTK_ORIENTATION_HORIZONTAL.
	horizontalAdjustment := GtkAdjustment newDefault.
	horizontalAdjustment pinInMemory.

	verticalOrientation := GtkOrientation GTK_ORIENTATION_VERTICAL.
	verticalAdjustment := GtkAdjustment newDefault.
	verticalAdjustment pinInMemory.
	
	horizontalScrollbar := GtkScrollBar orientation: horizontalOrientation adjustment: horizontalAdjustment.
	verticalScrollbar := GtkScrollBar orientation: verticalOrientation adjustment: verticalAdjustment.

	vbox := GtkBox newVertical.
	self initializeOverlayInfo.
	vbox add: overlayInfo overlay.
	vbox
		packEnd: horizontalScrollbar
		expand: false
		fill: false
		padding: 0.
	self packStart: vbox.
	self
		packEnd: verticalScrollbar
		expand: false
		fill: false
		padding: 0.
		
	drawingArea connectSizeAllocate: [ :aRect | self sizeChangedTo: aRect ].

	(GtkAdjustmentValueChangedCallback
		do: [ :anAdjustment|	
			| y |		
			anAdjustment pinInMemory.
			lastVAdjustment := anAdjustment.
			
			y := anAdjustment value.

			(self canvas camera position y - y) abs <= 1.0 ifFalse: [ 
				"prevent loops caused by rounding errors"
				self canvas camera translateTo: self canvas camera position x @ ((anAdjustment value))] .  
			drawingArea changed]) connectTo: verticalAdjustment.

	(GtkAdjustmentValueChangedCallback
		do: [ :anAdjustment | 
			| x |
			anAdjustment pinInMemory.
			lastHAdjustment  := anAdjustment.
			x := anAdjustment value.
			(self canvas camera position x - x) abs <= 1.0 ifFalse: [ 
				self canvas camera translateTo: (anAdjustment value) @ self canvas camera position y.].
			drawingArea changed ]) connectTo: horizontalAdjustment.
		
	self showAll.
	

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> initializeOverlayInfo [

	| fixed  overlayContainer | 
			
	overlayContainer := GtkOverlay new.
	fixed := GtkFixed new.
	overlayContainer add: drawingArea.
	overlayContainer addOverlay: fixed.

	overlayContainer setOverlayPassThrougth: true child: fixed.
	
	overlayInfo := GtkRoassalDrawingAreaBoxOverlay new.
	overlayInfo 
		overlay: overlayContainer;
		fixed: fixed;
		position: 0@0;
		extent: 0@0.
		
	^ overlayInfo
		

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> minSize [

	^ 20
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> recalculateOverlay [

	"do nothing here. Override in subclasses"
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> recalculateScrollbars: forceUpdate [
	| vScrollbarPosition needsUpdate cameraRect contentRect |
	needsUpdate := forceUpdate.
	self canvas camera = lastScale
		ifFalse: [ needsUpdate := true ].
	lastScale := self canvas camera scale.
	contentRect := self encompassingRectangle.
	cameraRect := self cameraRectangle.
	self canvas camera privExtent: cameraRect extent floor.
	vScrollbarPosition := self camera position = lastCameraPosition
		ifTrue: [ verticalAdjustment value asFloat ]
		ifFalse: [ needsUpdate := true.
			cameraRect topLeft y ].

	lastCameraPosition := self camera position.
	needsUpdate
		ifFalse: [ contentRect = lastEncompassingRectangle
				ifTrue: [ ^ self ] ].
	lastEncompassingRectangle := contentRect.

	verticalAdjustment
		configureValue:
			(vScrollbarPosition min: contentRect bottom max: contentRect top) asFloat
		lower: contentRect top asInteger
		upper: contentRect bottom asInteger
		stepIncrement: (self stepIncrement / self scale) asInteger
		pageIncrement: cameraRect height asInteger
		pageSize: cameraRect height asInteger.
	horizontalAdjustment
		configureValue:
			(horizontalAdjustment value min: contentRect right max: contentRect left) asFloat
		lower: contentRect left asInteger
		upper: contentRect right asInteger
		stepIncrement: (self stepIncrement / self scale) asInteger
		pageIncrement: cameraRect width asInteger
		pageSize: cameraRect width asInteger.
		
	self recalculateOverlay.
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> scale [ 
	^ self camera scale
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> sizeChangedTo: aRect [ 

	drawingArea canvas extent: aRect extent.
	drawingArea resetSurface.

	self recalculateScrollbars: true.
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> sizeRequest: aPoint [

	drawingArea setSizeRequestWidth: aPoint x height: aPoint y
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> stepIncrement [

	^ 10
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> update: anAspect [

	self recalculateScrollbars: false.

]
