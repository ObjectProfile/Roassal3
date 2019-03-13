"
A TSAthensMorph is at the interface between Morphic and Trachel. 
"
Class {
	#name : #TSAthensMorph,
	#superclass : #Morph,
	#instVars : [
		'renderer',
		'session',
		'surface',
		'isDrawing',
		'trachelCanvas',
		'eventBeginingDragging',
		'shapeBeingPointed'
	],
	#category : #'Roassal3-Trachel-Morph'
}

{ #category : #accessing }
TSAthensMorph >> canvas [
	^ trachelCanvas
]

{ #category : #accessing }
TSAthensMorph >> canvas: aTrachelCanvas [
	trachelCanvas := aTrachelCanvas
]

{ #category : #'session management' }
TSAthensMorph >> checkSession [
	session == Smalltalk session ifTrue: [ ^ self ].
	surface := nil.
	trachelCanvas shapes do: [ :s | s path: nil ].
	trachelCanvas fixedShapes do: [ :s | s path: nil ].
	self createSurface
]

{ #category : #'surface management' }
TSAthensMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint.
	session := Smalltalk session.
]

{ #category : #drawing }
TSAthensMorph >> drawOn: aCanvas [
	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	self checkSession.
	self recreateSurfaceIfNecessary.
	aCanvas fillRectangle: bounds color: trachelCanvas color.
	trachelCanvas playAnimations.
	self drawShapes.

	surface hasBeenFreed
		ifTrue: [ self createSurface ].
	[ aCanvas
		image: surface asForm
		at: self bounds origin asIntegerPoint
		sourceRect: (0 @ 0 extent: surface extent)
		rule: 34 ]
		on: Exception
		do: [ :ex |  ].
	isDrawing := false
]

{ #category : #drawing }
TSAthensMorph >> drawOnMockCanvas [
	"This method is used to trigger all the rendering in a temporary FormCanvas. This method is useful when a bug happens when rendering. Such situation are difficult to debug to the multi-threading and low level graphical primitive. The method #drawOnMockCanvas helps addressing this.

Here is an example:
v := RTView new.
es := RTBox elementsOn: (1 to: 10).
v addAll: es.
RTGridLayout on: es.
v canvas buildMorph drawOnMockCanvas

	"
	self drawOn: (FormCanvas extent: self extent)
]

{ #category : #drawing }
TSAthensMorph >> drawShapes [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [ :athensCanvas | 
		trachelCanvas clearBackground
			ifTrue: [ surface clear ].
		"We display the elements that are subject to the camera"
		athensCanvas pathTransform
			translateBy: (self extent / 2) asFloatPoint;
			scaleBy: trachelCanvas camera scale asFloat;
			translateBy: trachelCanvas camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
			
		trachelCanvas shapes do: [ :trachelShape | 
			trachelShape accept: renderer.
			self showRectangleIfNecessary: trachelShape.
		 ].

		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.0001.
		trachelCanvas fixedShapes do: [ :trachelShape | 
			trachelShape accept: renderer.
			self showRectangleIfNecessary: trachelShape. ] ]
		

]

{ #category : #'event-processed' }
TSAthensMorph >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition.

	trEvent := anEventClass fromEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'event-processed' }
TSAthensMorph >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent under: aShape [
	| relativePosition shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self
		shapeWithAction: anActionClass
		forPositionInPixels: relativePosition
		under: aShape.
	^ (anEventClass fromEvent: aMorphicEvent)
		morph: self;
		canvas: trachelCanvas;
		shape: shape;
		position: relativePosition;
		yourself
]

{ #category : #'event-processed' }
TSAthensMorph >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #'event-processed' }
TSAthensMorph >> eventOfClass: anEventClass shape: aShape from: aMorphicEvent [
	| relativePosition trEvent |
	relativePosition := self relativePositionFor: aMorphicEvent.

	trEvent := anEventClass fromEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: trachelCanvas;
		shape: aShape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'events-processing' }
TSAthensMorph >> handleKeyUp: anEvent [
	super handleKeyUp: anEvent.
	self trKeyUp: anEvent
]

{ #category : #'event handling' }
TSAthensMorph >> handleKeystroke: anEvent [
	self trKeyDown: anEvent.
]

{ #category : #'events-processing' }
TSAthensMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	anEvent anyButtonPressed ifFalse: [ self trMouseMove: anEvent ].
	
	
]

{ #category : #'events-processing' }
TSAthensMorph >> handleMouseOver: aMorphicEvent [
	| currentElement trEvent |
	super handleMouseOver: aMorphicEvent.
	aMorphicEvent wasHandled
		ifTrue: [ ^ self ].	"Do nothing if it was already handled"
	self isDragging
		ifTrue: [ ^ self ].	"Do nothing if we are dragging"
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	currentElement := self shapeForEvent: aMorphicEvent.
	currentElement == shapeBeingPointed
		ifTrue: [ ^ self ].
	trEvent := self eventOfClass: TSMouseLeave from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	shapeBeingPointed := currentElement.
	self trMouseEnter: aMorphicEvent
]

{ #category : #'event handling' }
TSAthensMorph >> handlesKeyboard: evt [
	^true
]

{ #category : #'event handling' }
TSAthensMorph >> handlesMouseDown: anEvent [
	^ anEvent wasHandled not	"not interested if handled"
]

{ #category : #'event handling' }
TSAthensMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : #'events-processing' }
TSAthensMorph >> handlesMouseWheel: evt [
	^true
]

{ #category : #initialization }
TSAthensMorph >> initialize [
	super initialize.
	self createSurface.
	session := Smalltalk session.
	isDrawing := false
]

{ #category : #testing }
TSAthensMorph >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #accessing }
TSAthensMorph >> isDrawing [
	^ isDrawing
]

{ #category : #initialization }
TSAthensMorph >> layoutChanged [
	"react on morph resize"

	super layoutChanged.
	self checkSession.
	
]

{ #category : #'event handling' }
TSAthensMorph >> mouseDown: evt [
	eventBeginingDragging
		ifNil:
			[ evt hand
				waitForClicksOrDrag: self
				event: evt
				selectors: {#trMouseClick:. #trMouseDoubleClick:. nil. #trMouseDragStart:. }
				threshold: 5.
			^ self ].

	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TSAthensMorph >> mouseEnter: evt [
	evt anyButtonPressed
		ifFalse: [ self trMouseEnter: evt ].
	evt wasHandled: true
]

{ #category : #'event-processed' }
TSAthensMorph >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #'event handling' }
TSAthensMorph >> mouseLeave: evt [
	evt anyButtonPressed
		ifFalse: [ self trMouseLeave: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TSAthensMorph >> mouseMove: evt [
	evt anyButtonPressed
		ifTrue: [ self trMouseDragging: evt ]
		ifFalse: [ self trMouseMove: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TSAthensMorph >> mouseUp: evt [
	self isDragging
		ifTrue: [ self trMouseDragEnd: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
TSAthensMorph >> mouseWheel: evt [
	self trMouseWheel: evt.
	evt wasHandled: true
]

{ #category : #recategorized }
TSAthensMorph >> recreateSurfaceIfNecessary [
	surface
		ifNotNil: [ self extent asIntegerPoint ~= surface extent
				ifTrue: [ self createSurface.
					trachelCanvas extent: self extent ] ]
]

{ #category : #'events-roassal' }
TSAthensMorph >> relativePositionFor: evt [
	^ evt position - self bounds origin
]

{ #category : #dependencies }
TSAthensMorph >> release [
	"This method is useful in case some references of TRMorph cannot be garbage collected, as it may happen with GT."
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #accessing }
TSAthensMorph >> renderer [
	^ renderer
]

{ #category : #accessing }
TSAthensMorph >> renderer: aRenderer [
	renderer := aRenderer
]

{ #category : #'event-processed' }
TSAthensMorph >> shapeForEvent: anEvent [
	"Return the Trachel shape for the event provided as argument"
	^ self shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : #accessing }
TSAthensMorph >> shapeForPositionInPixels: point [
	"Return the shape located that contains point"
	 ^ trachelCanvas shapeForPositionInPixels: point
]

{ #category : #accessing }
TSAthensMorph >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
TSAthensMorph >> shapeWithAction: eventClass forPositionInPixels: position under: aShape [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithAction: eventClass forPositionInPixels: position under: aShape
]

{ #category : #accessing }
TSAthensMorph >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ trachelCanvas shapeWithActionForPositionInPixels: point
]

{ #category : #drawing }
TSAthensMorph >> showRectangleIfNecessary: shape [
	| box rect |
	trachelCanvas showRectangles ifFalse: [ ^ self ].
	rect := shape encompassingRectangle.
	box := TSBox new
		position: rect center;
		extent: rect extent;
		color: (Color blue alpha: 0.2).
	box accept: renderer.
]

{ #category : #signaling }
TSAthensMorph >> signalUpdate [
	self changed
]

{ #category : #signaling }
TSAthensMorph >> step [
	self wantsSteps ifFalse: [ ^ self ].
	self changed
]

{ #category : #signaling }
TSAthensMorph >> stepTime [
	"Answer the desired time between steps in milliseconds. This default implementation requests that the 'step' method be called once every second."

	^ 20
]

{ #category : #accessing }
TSAthensMorph >> surface [
	^ surface
]

{ #category : #'events-processing' }
TSAthensMorph >> takesKeyboardFocus [
	^ true
]

{ #category : #'event-processed' }
TSAthensMorph >> trKeyDown: aMorphicEvent [
	| trEvent |
	(aMorphicEvent commandKeyPressed and: [ aMorphicEvent keyCharacter = $w ])
		ifTrue: [ self owner delete ].

	trEvent := self eventOfClass: TSKeyDown from: aMorphicEvent.
	trEvent
		position: (trachelCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyCombination: aMorphicEvent asKeyCombination.
	trEvent shape announce: trEvent
]

{ #category : #'event-processed' }
TSAthensMorph >> trKeyUp: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSKeyUp from: aMorphicEvent.
	trEvent
		position: (trachelCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyCombination: aMorphicEvent asKeyCombination.
	trEvent shape announce: trEvent
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: TSMouseClick
		ifLeftButton: TSMouseLeftClick
		ifRightButton: TSMouseRightClick
		from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseDoubleClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: TSMouseDoubleClick
		ifLeftButton: TSMouseDoubleLeftClick
		ifRightButton: TSMouseDoubleRightClick
		from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseDragEnd: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSMouseDragEnd from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	
	eventBeginingDragging := nil.
	shapeBeingPointed := nil.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseDragStart: aMorphicEvent [
	| trEvent trEventClass |
	eventBeginingDragging := aMorphicEvent copy.
	
	trEventClass := TSMouseDragStart.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := TSMouseLeftDragStart ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := TSMouseRightDragStart ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ trEventClass := TSMouseMiddleDragStart ].
	trEvent := self eventOfClass: trEventClass actionClass: TSMouseDragging from: aMorphicEvent.

	shapeBeingPointed := trEvent shape.
	shapeBeingPointed announce: trEvent.
	
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseDragging: aMorphicEvent [
	| trEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.

	trEvent := self eventOfClass: TSMouseDragging from: aMorphicEvent.
	trEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := trEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed canvas ifNil: [
		eventBeginingDragging := nil.
		shapeBeingPointed := nil.
		^ self ].

	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	eventBeginingDragging := aMorphicEvent copy.
	
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSMouseLeave from: aMorphicEvent.
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSMouseMove from: aMorphicEvent.
	trEvent position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
TSAthensMorph >> trMouseWheel: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: TSMouseWheelEvent from: aMorphicEvent.
	trEvent
		direction: aMorphicEvent direction;
		position: (trachelCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #accessing }
TSAthensMorph >> trachelCanvas [
	^ trachelCanvas
]

{ #category : #testing }
TSAthensMorph >> wantsSteps [
	^ trachelCanvas hasAnimation 
]
