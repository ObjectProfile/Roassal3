Class {
	#name : #GtkRoassalAdapter,
	#superclass : #GtkAdapter,
	#instVars : [
		'trachelCanvas',
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

{ #category : #'instance creation' }
GtkRoassalAdapter class >> trachelCanvas: aCanvas [

	^ self new
		trachelCanvas: aCanvas;
		yourself
]

{ #category : #accessing }
GtkRoassalAdapter >> addModelTo: gtkWidget [

	widget := gtkWidget.
	
	self addModelToTrachelWidget: self innerWidget.
]

{ #category : #accessing }
GtkRoassalAdapter >> addModelToTrachelWidget: trWidget [

	trWidget events: GDK_ALL_EVENTS_MASK value.
	
	self model contextMenu ifNotNil: [ 
		self updateMenu ].

	"widget connectClicked: [ self inspect ]."
	trWidget connectKeyPressEvent:  [ :event | self inform: event type asString. true ].
	
	trWidget connectButtonPressEvent:  [ :event | 
		event isDoubleClick 
			ifTrue: [ self mouseDoubleClick: event ]
			ifFalse: [ self mouseDown: event. true ] .		
		true ].
	trWidget connectButtonReleaseEvent:  [ :event | self mouseUp: event. true ].
	trWidget connectMotionNotify: [ :event | self mouseMove: event. true ].
	trWidget connectEnterNotify: [ :event | self mouseEnter: event. true ].
	trWidget connectLeaveNotify: [ :event | self mouseLeave: event. true ].
	trWidget connectSizeAllocate: [ :aRect | self resizeTo: aRect ].

	
"	widtrWidgetget connectMotionNotify: [ :arg | self inform: arg x asString. false ].
"	trWidget connectScroll: [ :event | self mouseWheel: event. true ].
"	trWidget connect: 'button_press_event' do: [ #down logCr ].	
	trWidget connect: 'button_release_event' do: [ #up logCr ].
	trWidget connect: 'key_press_event' do: [ #keyPress logCr ].
	trWidget connect: 'key_release_event' do: [ #keyRelease logCr ].
	trWidget connect: 'key_press_event' do: [ #keyPress logCr ].
"
"	trWidget connect: 'enter-notify-event' do: [ #enter logCr ].
	trWidget connect: 'leave-notify-event' do: [ #leave logCr ].
"

]

{ #category : #accessing }
GtkRoassalAdapter >> announceToEventOverseer: evt [
	"self eventOverseer ifNil: [ ^ self ].
	self eventOverseer firedEvent: evt "
]

{ #category : #accessing }
GtkRoassalAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent under: aShape [
	| relativePosition shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self
		shapeWithAction: anActionClass
		forPositionInPixels: relativePosition
		under: aShape.
	^ (anEventClass fromGtkEvent: aMorphicEvent)
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition;
		yourself
]

{ #category : #accessing }
GtkRoassalAdapter >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> eventOfClass: anEventClass shape: aShape from: aMorphicEvent [
	| relativePosition trEvent |
	relativePosition := self relativePositionFor: aMorphicEvent.

	trEvent := anEventClass fromGtkEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: aShape;
		position: relativePosition.
	^ trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> eventOverseer [
	^ trachelCanvas eventOverseer
]

{ #category : #accessing }
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
	self trMouseEnter: aMorphicEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> initialize [ 
	
	super initialize.
	
	anyButtonPressed := false.
]

{ #category : #accessing }
GtkRoassalAdapter >> innerWidget [ 

	^ widget children first children first children first.
]

{ #category : #accessing }
GtkRoassalAdapter >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #accessing }
GtkRoassalAdapter >> mouseDoubleClick: evt [

	| trEvent evtClass |
	
	eventBeginingDragging := nil.
	anyButtonPressed := false.
	clickEventClone := nil.

	evtClass := 	nil.
	evt isPrimaryButton ifTrue: [ evtClass := RSMouseDoubleLeftClick ].
	evt isSecondaryButton  ifTrue: [ evtClass := RSMouseDoubleRightClick ].

	trEvent := self eventOfClass: evtClass actionClass: evtClass from: evt.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent

]

{ #category : #accessing }
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

{ #category : #accessing }
GtkRoassalAdapter >> mouseEnter: evt [
	anyButtonPressed
		ifFalse: [ self trMouseEnter: evt ].

]

{ #category : #accessing }
GtkRoassalAdapter >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> mouseLeave: evt [
	anyButtonPressed
		ifFalse: [ self trMouseLeave: evt ].

]

{ #category : #accessing }
GtkRoassalAdapter >> mouseMove: evt [
	clickEventClone
		ifNil: [ anyButtonPressed
				ifTrue: [ self trMouseDragging: evt ]
				ifFalse: [ self trMouseMove: evt ].
			"emulate mouse over"
			self handleMouseOver: evt ].
	(clickEventClone notNil
		and: [ (evt position distanceTo: clickEventClone position) > 5 ])
		ifTrue: [
			self trMouseDragStart: clickEventClone.
			clickEventClone := nil ]
]

{ #category : #accessing }
GtkRoassalAdapter >> mouseUp: evt [

	clickEventClone := nil.

	self isDragging
		ifTrue: [ 
			self trMouseDragEnd: evt ]
		ifFalse: [ 
			self trMouseClick: evt ]

]

{ #category : #accessing }
GtkRoassalAdapter >> mouseWheel: evt [
	self trMouseWheel: evt
]

{ #category : #accessing }
GtkRoassalAdapter >> newWidget [

	trachelCanvas := model canvas.
	^ GtkRoassalDrawingAreaBox new 
		adapter: self;
		canvas: model canvas.		
	
]

{ #category : #accessing }
GtkRoassalAdapter >> relativePositionFor: evt [
	"Return the position within the window"
			
	^ "trachelCanvas camera fromPixelToSpace: "evt position
]

{ #category : #accessing }
GtkRoassalAdapter >> resizeTo: aRect [

	trachelCanvas extent: aRect extent.
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
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeWithAction: eventClass forPositionInPixels: position under: aShape [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position under: aShape
]

{ #category : #accessing }
GtkRoassalAdapter >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithActionForPositionInPixels: point
]

{ #category : #accessing }
GtkRoassalAdapter >> trMouseClick: aMorphicEvent [
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
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> trMouseDragEnd: aMorphicEvent [
	| trEvent dropEvent |
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

{ #category : #accessing }
GtkRoassalAdapter >> trMouseDragStart: aGdkEventButton [
	| trEvent trEventClass trUnderDragEvent |
	eventBeginingDragging := aGdkEventButton copy.
	
	trEventClass := TRMouseDragStart.
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

{ #category : #accessing }
GtkRoassalAdapter >> trMouseDragging: aMorphicEvent [
	| trEvent step underShape trUnderDragEvent overEvent |
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

{ #category : #accessing }
GtkRoassalAdapter >> trMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> trMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> trMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseMove from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> trMouseWheel: aMorphicEvent [
	| trEvent |

	trEvent := self eventOfClass: RSMouseWheelEvent from: aMorphicEvent.
	trEvent
		direction: aMorphicEvent direction;
		position: (trachelCanvas camera fromPixelToSpace: trEvent position);
		controlKeyPressed: (aMorphicEvent state & GdkModifierType GDK_CONTROL_MASK value = GdkModifierType GDK_CONTROL_MASK value).
		
	trEvent shape announce: trEvent.
	self announceToEventOverseer: trEvent
]

{ #category : #accessing }
GtkRoassalAdapter >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #accessing }
GtkRoassalAdapter >> trachelCanvas: anObject [
	trachelCanvas := anObject.

]

{ #category : #accessing }
GtkRoassalAdapter >> unsubscribe [

	super unsubscribe
]
