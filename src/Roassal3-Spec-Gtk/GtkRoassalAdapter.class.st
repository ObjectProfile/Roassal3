Class {
	#name : #GtkRoassalAdapter,
	#superclass : #GtkAdapter,
	#instVars : [
		'roassalCanvas',
		'drawingArea',
		'anyButtonPressed',
		'eventBeginingDragging',
		'shapeBeingPointed',
		'shapeUnderDrag',
		'lastButton',
		'clickEventClone'
	],
	#pools : [
		'GdkEventMask'
	],
	#category : #'Roassal3-Spec-Gtk'
}

{ #category : #examples }
GtkRoassalAdapter class >> example [ 

	<example>
	
	| app presenter box | 

	app := SpApplication new.
	app useBackend: #Gtk.
	presenter := SpRoassalPresenter newApplication: app.
	box := RSBox new size: 200.
	presenter openWithSpec.
	presenter canvas addShape: box.
	presenter canvas signalUpdate
]

{ #category : #'instance creation' }
GtkRoassalAdapter class >> trachelCanvas: aCanvas [

	^ self new
		trachelCanvas: aCanvas;
		yourself
]

{ #category : #building }
GtkRoassalAdapter >> addModelTo: gtkWidget [

	widget := gtkWidget.
	
	self addModelToDrawingArea: self innerWidget.
]

{ #category : #building }
GtkRoassalAdapter >> addModelToDrawingArea: aGtkRoassalDrawingArea [

	aGtkRoassalDrawingArea events: GDK_ALL_EVENTS_MASK value.
	
	self model contextMenu ifNotNil: [ 
		self updateMenu ].

	"widget connectClicked: [ self inspect ]."
	aGtkRoassalDrawingArea connectKeyPressEvent:  [ :event | 
		self inform: event type asString. true ].
	
	aGtkRoassalDrawingArea connectButtonPressEvent:  [ :event | 
		event isDoubleClick 
			ifTrue: [ self mouseDoubleClick: event ]
			ifFalse: [ self mouseDown: event. true ] .		
		true ].
	aGtkRoassalDrawingArea connectButtonReleaseEvent:  [ :event | self mouseUp: event. true ].
	aGtkRoassalDrawingArea connectMotionNotify: [ :event | self mouseMove: event. true ].
	aGtkRoassalDrawingArea connectEnterNotify: [ :event | self mouseEnter: event. true ].
	aGtkRoassalDrawingArea connectLeaveNotify: [ :event | self mouseLeave: event. true ].
	aGtkRoassalDrawingArea connectSizeAllocate: [ :aRect | self resizeTo: aRect ].
	
	aGtkRoassalDrawingArea connectScroll: [ :event | self mouseWheel: event. true ].

"	widtrWidgetget connectMotionNotify: [ :arg | self inform: arg x asString. false ].
	trWidget connect: 'button_press_event' do: [ #down logCr ].	
	trWidget connect: 'button_release_event' do: [ #up logCr ].
	trWidget connect: 'key_press_event' do: [ #keyPress logCr ].
	trWidget connect: 'key_release_event' do: [ #keyRelease logCr ].
	trWidget connect: 'key_press_event' do: [ #keyPress logCr ].
	trWidget connect: 'enter-notify-event' do: [ #enter logCr ].
	trWidget connect: 'leave-notify-event' do: [ #leave logCr ].
"

]

{ #category : #'events support' }
GtkRoassalAdapter >> announceToEventOverseer: evt [

]

{ #category : #accessing }
GtkRoassalAdapter >> canvas [
	^ roassalCanvas
]

{ #category : #accessing }
GtkRoassalAdapter >> canvas: anObject [
	roassalCanvas := anObject.

]

{ #category : #events }
GtkRoassalAdapter >> eventMouseClick: aMorphicEvent [
	| trEvent evtClass |
	
	evtClass := RSMouseClick.
	aMorphicEvent isPrimaryButton ifTrue: [ 
		lastButton := #left.
		evtClass := RSMouseLeftClick ].
	aMorphicEvent isSecondaryButton ifTrue: [ 
		lastButton := #right.		
		evtClass := RSMouseRightClick ].
	aMorphicEvent isDoubleClick ifTrue: [ 
		lastButton = #left ifTrue: [ evtClass := RSMouseDoubleLeftClick ].
		lastButton = #right ifTrue: [ evtClass := RSMouseDoubleRightClick ]  ].

	trEvent := self eventOfClass: evtClass actionClass: RSMouseClick from: aMorphicEvent.
"	trEvent := self
		mouseEventOfClass: TRMouseClick
		ifLeftButton: TRMouseLeftClick
		ifRightButton: TRMouseRightClick
		from: aMorphicEvent."
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseDragEnd: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseDragEnd from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.

	"(shapeBeingPointed isKindOf: RSCanvas) ifFalse: [
		dropEvent := self eventOfClass: RSMouseDragDrop shape: shapeUnderDrag from: aMorphicEvent.
		dropEvent draggedShape: shapeBeingPointed.
		shapeUnderDrag announce: dropEvent.
		self announceToEventOverseer: dropEvent.
	]."
	
	eventBeginingDragging := nil.
	shapeBeingPointed := nil.
	shapeUnderDrag := nil.
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseDragStart: aGdkEventButton [
	| trEvent trEventClass |
	eventBeginingDragging := aGdkEventButton copy.
	
	trEventClass := RSMouseDragStart.
	aGdkEventButton button = 1
		ifTrue: [ trEventClass := RSMouseLeftDragStart ].
	aGdkEventButton button = 2
		ifTrue: [ trEventClass := RSMouseRightDragStart ].
	aGdkEventButton button = 3
		ifTrue: [ trEventClass := RSMouseMiddleDragStart ].
	trEvent := self eventOfClass: trEventClass actionClass: RSMouseDragging from: aGdkEventButton.

	shapeBeingPointed := trEvent shape.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	
	(shapeBeingPointed isKindOf: RSCanvas)
		ifTrue: [ ^self ].
	
"	trUnderDragEvent := self eventOfClass: RSMouseAbstractDrop actionClass: TRSMouseAbstractDrop from:  aGdkEventButton under: shapeBeingPointed.
	
	shapeUnderDrag := trUnderDragEvent shape"
	
	
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseDragging: aMorphicEvent [
	| trEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.

	trEvent := self eventOfClass: RSMouseDragging from: aMorphicEvent.
	trEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := trEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed canvas
		ifNil: [ eventBeginingDragging := nil.
			shapeBeingPointed := nil.
			^ self ].

	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	self announceToEventOverseer: trEvent.
	eventBeginingDragging := aMorphicEvent copy.

	(shapeBeingPointed isKindOf: RSCanvas) ifTrue: [ ^self ].	

	"trUnderDragEvent := self eventOfClass: RSMouseAbstractDrop actionClass: RSMouseAbstractDrop from:  aMorphicEvent under: shapeBeingPointed.
	trUnderDragEvent draggedShape: shapeBeingPointed.
	underShape := trUnderDragEvent shape.
		
	underShape = shapeUnderDrag ifFalse: [ |leaveEvent enterEvent|
		leaveEvent := self eventOfClass: TRMouseDragLeave shape: shapeUnderDrag from: aMorphicEvent.
		leaveEvent draggedShape: shapeBeingPointed.
		shapeUnderDrag announce: leaveEvent.
		self announceToEventOverseer: leaveEvent.
		enterEvent := self eventOfClass: TRMouseDragEnter shape: underShape from: aMorphicEvent.
		enterEvent draggedShape: shapeBeingPointed.
		underShape announce: enterEvent.
		self announceToEventOverseer: enterEvent.
		shapeUnderDrag := underShape.
	].

	overEvent := self eventOfClass: RSMouseDragOver shape: shapeUnderDrag from: aMorphicEvent.
	overEvent draggedShape: shapeBeingPointed.
	shapeUnderDrag announce: overEvent.
	self announceToEventOverseer: overEvent.
	"
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseMove from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #events }
GtkRoassalAdapter >> eventMouseWheel: aMorphicEvent [
	| trEvent |

	trEvent := self eventOfClass: RSMouseWheelEvent from: aMorphicEvent.
	trEvent
		direction: aMorphicEvent direction;
		position: (roassalCanvas camera fromPixelToSpace: trEvent position);
		controlKeyPressed: (aMorphicEvent state & GdkModifierType GDK_CONTROL_MASK value = GdkModifierType GDK_CONTROL_MASK value).
		
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #'events support' }
GtkRoassalAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: roassalCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'events support' }
GtkRoassalAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent under: aShape [
	| relativePosition shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self
		shapeWithAction: anActionClass
		forPositionInPixels: relativePosition
		under: aShape.
	^ (anEventClass fromGtkEvent: aMorphicEvent)
		morph: self;
		canvas: roassalCanvas;
		shape: shape;
		position: relativePosition;
		yourself
]

{ #category : #'events support' }
GtkRoassalAdapter >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #'events support' }
GtkRoassalAdapter >> eventOfClass: anEventClass shape: aShape from: aMorphicEvent [
	| relativePosition trEvent |
	relativePosition := self relativePositionFor: aMorphicEvent.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: roassalCanvas;
		shape: aShape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'events support' }
GtkRoassalAdapter >> eventOverseer [
	^ roassalCanvas eventOverseer
]

{ #category : #events }
GtkRoassalAdapter >> handleMouseOver: aMorphicEvent [
	| currentElement trEvent |

	self isDragging
		ifTrue: [ ^ self ].	"Do nothing if we are dragging"
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	currentElement := self shapeForEvent: aMorphicEvent.
	currentElement == shapeBeingPointed
		ifTrue: [ ^ self ].
	trEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	shapeBeingPointed := currentElement.
	self eventMouseEnter: aMorphicEvent
]

{ #category : #initialization }
GtkRoassalAdapter >> initialize [ 
	
	super initialize.
	
	anyButtonPressed := false.
]

{ #category : #'private accessing' }
GtkRoassalAdapter >> innerWidget [ 

	^ widget children first children first children first.
]

{ #category : #testing }
GtkRoassalAdapter >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseDoubleClick: evt [

	| trEvent evtClass |
	
	eventBeginingDragging := nil.
	anyButtonPressed := false.
	clickEventClone := nil.

	evtClass := 	nil.
	evt isPrimaryButton ifTrue: [ evtClass := RSMouseDoubleLeftClick ].
	evt isSecondaryButton  ifTrue: [ evtClass := RSMouseDoubleRightClick ].

	trEvent := self eventOfClass: evtClass actionClass: evtClass from: evt.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent

]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseDown: evt [

	anyButtonPressed := true.
	
	clickEventClone := evt copyInMemory.
	
	"TRMouseLeftClick"
	
"	self inform: 'evt: ', (evt position) asString.
	self inform: 'point: ', (self relativePositionFor: evt) asString.
"	
"	self trMouseDragStart: evt.	
"


"	eventBeginingDragging
		ifNil:
			[ evt hand
				waitForClicksOrDrag: self
				event: evt
				selectors: {#trMouseClick:. #trMouseDoubleClick:. nil. #trMouseDragStart:. }
				threshold: 5.
			^ self ]."

"	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ].
	evt wasHandled: true"
]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseEnter: evt [
	anyButtonPressed
		ifFalse: [ self eventMouseEnter: evt ].

]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseLeave: evt [
	anyButtonPressed
		ifFalse: [ self eventMouseLeave: evt ].

]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseMove: evt [
	clickEventClone
		ifNil: [ anyButtonPressed
				ifTrue: [ self eventMouseDragging: evt ]
				ifFalse: [ self eventMouseMove: evt ].
			"emulate mouse over"
			self handleMouseOver: evt ].
	(clickEventClone notNil
		and: [ (evt position distanceTo: clickEventClone position) > 5 ])
		ifTrue: [
			self eventMouseDragStart: clickEventClone.
			clickEventClone := nil ]
]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseUp: evt [

	clickEventClone := nil.

	self isDragging
		ifTrue: [ 
			self eventMouseDragEnd: evt ]
		ifFalse: [ 
			self eventMouseClick: evt ]

]

{ #category : #'gtk events' }
GtkRoassalAdapter >> mouseWheel: evt [
	self eventMouseWheel: evt
]

{ #category : #building }
GtkRoassalAdapter >> newWidget [

	roassalCanvas := model canvas.
	^ GtkRoassalDrawingAreaBox new 
		adapter: self;
		canvas: model canvas.		
	
]

{ #category : #accessing }
GtkRoassalAdapter >> relativePositionFor: evt [
	"Return the position within the window"
			
	^ evt position
]

{ #category : #protocol }
GtkRoassalAdapter >> removeSubWidgets [
]

{ #category : #accessing }
GtkRoassalAdapter >> resizeTo: aRect [

	roassalCanvas extent: aRect extent.
	model announcer announce: (PresenterResized new extent: aRect extent).
	self innerWidget repaint.
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeForEvent: anEvent [
	"Return the Trachel shape for the event provided as argument"
	^ self shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"
	 ^ roassalCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeWithAction: eventClass forPositionInPixels: position under: aShape [
	"Return the shape with event handler located that contains point"
	 ^ roassalCanvas shapeWithAction: eventClass forPositionInPixels: position under: aShape
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ roassalCanvas shapeWithActionForPositionInPixels: point
]
