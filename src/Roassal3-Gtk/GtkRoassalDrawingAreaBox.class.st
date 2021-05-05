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
		'textEditor',
		'overlay'
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

	^ drawingArea trachelCanvas extent
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
GtkRoassalDrawingAreaBox >> inPlaceEditConnector [
	^self canvas inPlaceEditConnector
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
	overlay := GtkOverlay new.
	overlay add: drawingArea.
	vbox add: overlay.
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

	(GtkScrollBarValueChangedCallback
		do: [ :anAdjustment|	
			| y |		
			anAdjustment pinInMemory.
			lastVAdjustment := anAdjustment.
			
			y := anAdjustment value.

			(self canvas camera position y - y) abs <= 1.0 ifFalse: [ 
				"prevent loops caused by rounding errors"
				self canvas camera translateTo: self canvas camera position x @ ((anAdjustment value))] .  
			drawingArea changed]) connectTo: verticalAdjustment.

	(GtkScrollBarValueChangedCallback
		do: [ :anAdjustment | 
			| x |
			anAdjustment pinInMemory.
			lastHAdjustment  := anAdjustment.
			x := anAdjustment value.
			(self canvas camera position x - x) abs <= 1.0 ifFalse: [ 
				self canvas camera translateTo: (anAdjustment value) @ self canvas camera position y.].
			drawingArea changed ]) connectTo: horizontalAdjustment.
	
	self initializeTextEditorIn: overlay.
		
	self showAll.
	

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> initializeTextEditorIn: overlayLayout [

	| fixed provider context | 

	textEditor := GtkEntry new.
			
	fixed := GtkFixed new.
	fixed add: textEditor.
	fixed moveChild: textEditor to: (5@5).
	overlayLayout addOverlay: fixed.

	textEditor setSizeRequestWidth: -1 height: -1.

	provider := GtkCssProvider
		newFromString: '* {border: none; padding: 1px;  min-height: 0px;  min-width: 0px; }
		*:active
{
    border: none;
    border-style: none;
}

*:focus
{
    border: none;
    border-style: none; 
}'.
	context := textEditor styleContext.
	context addProvider: provider.
	textEditor connectKeyPressEvent: [ :event | 
		event isEscape ifTrue: [ self inPlaceEditConnector leftWithEscape ]. 
		event isReturn ifTrue: [ self inPlaceEditConnector leftWithReturn ]. 
		textEditor imContextFilterKeypress: event.
	].

	overlayLayout setOverlayPassThrougth: true child: fixed.
	
	overlay := GtkRoassalDrawingAreaBoxOverlay new.
	overlay 
		overlay: overlayLayout;
		fixed: fixed;
		content: textEditor;
		position: 0@0;
		extent: 0@0
		

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> minSize [

	^ 20
]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> overlay [

	^ overlay
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
	"self canvas camera privExtent: cameraRect extent floor."
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
		
	overlay fixed moveChild: overlay content to: overlay position - self camera position.
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
GtkRoassalDrawingAreaBox >> trachelCanvas: aCanvas [

	drawingArea canvas: aCanvas.

]

{ #category : #accessing }
GtkRoassalDrawingAreaBox >> update: anAspect [

	self recalculateScrollbars: false.

]
