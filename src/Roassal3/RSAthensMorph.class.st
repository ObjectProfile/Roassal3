"
A RSAthensMorph is at the interface between Morphic and Roassal. 
I am directly referenced by RSCanvas
"
Class {
	#name : #RSAthensMorph,
	#superclass : #Morph,
	#instVars : [
		'renderer',
		'session',
		'surface',
		'isDrawing',
		'eventBeginingDragging',
		'shapeBeingPointed',
		'lastMousePosition',
		'roassalCanvas'
	],
	#category : #'Roassal3-Morph'
}

{ #category : #accessing }
RSAthensMorph >> canvas [
	^ roassalCanvas
]

{ #category : #accessing }
RSAthensMorph >> canvas: aRoassalCanvas [
	roassalCanvas := aRoassalCanvas
]

{ #category : #'session management' }
RSAthensMorph >> checkSession [
	"The mechanism of session is useful in case you have a visualization open, save-and-quit the image, and open the image again.
	Naturally, you wish to see the visualization again. The session mechanism makes sure that low-level resources that belongs to Cairo are properly recreated"
	session == Smalltalk session ifTrue: [ ^ self ].
	surface := nil.
	self createSurface.
	roassalCanvas shapes do: [ :s | s sessionChanged ].
	roassalCanvas fixedShapes do: [ :s | s sessionChanged ].
	
]

{ #category : #'surface management' }
RSAthensMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint.
	session := Smalltalk session.
]

{ #category : #drawing }
RSAthensMorph >> drawOn: aCanvas [
	"Draw the whole visualization"
	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[ 
		self checkSession.
		self recreateSurfaceIfNecessary.
		aCanvas fillRectangle: bounds color: roassalCanvas color.
		roassalCanvas playAnimations.
		self drawShapes.

		surface hasBeenFreed
			ifTrue: [ self createSurface ].
		[ aCanvas
			image: surface asForm
			at: self bounds origin asIntegerPoint
			sourceRect: (0 @ 0 extent: surface extent)
			rule: 34 ]
		on: Exception
		do: [ :ex |  ] ] 
	ensure: [ 
		isDrawing := false ]
]

{ #category : #drawing }
RSAthensMorph >> drawOnAthensCanvas: aCanvas [
	self fullDrawOnAthensCanvas: aCanvas
]

{ #category : #drawing }
RSAthensMorph >> drawOnMockCanvas [
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
RSAthensMorph >> drawShapes [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	
	surface drawDuring: [ :athensCanvas | 
		| camera canvasRect |
		roassalCanvas clearBackground
			ifTrue: [ surface clear ].
		"We display the elements that are subject to the camera"
		camera := roassalCanvas camera.
		athensCanvas pathTransform
			translateBy: (self extent / 2) asFloatPoint;
			scaleBy: camera scale asFloat;
			translateBy: camera position negated asFloatPoint.
		renderer canvas: athensCanvas.
		canvasRect := roassalCanvas visibleRectangle.
		
		roassalCanvas shapes do: [ :roassalShape | 
			(roassalShape intersects: canvasRect)
				ifTrue: [ roassalShape accept: renderer ] ].
		
		self showRectanglesIfNecessary: roassalCanvas shapes.
		"We display the elements that are _NOT_ subject to the camera"
		athensCanvas pathTransform loadIdentity scaleBy: 1.0001.
		roassalCanvas fixedShapes do: [ :roassalShape | 
			roassalShape accept: renderer ].
		"debug mode to show encompassingRectangles"
		self showRectanglesIfNecessary: roassalCanvas fixedShapes. ]
		

]

{ #category : #'event-processed' }
RSAthensMorph >> eventKeyDown: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSKeyDown from: aMorphicEvent.
	trEvent
		position: (roassalCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyName: aMorphicEvent key name. "(self class keyNameFor: aMorphicEvent keyValue)".
	trEvent shape announce: trEvent.

]

{ #category : #'event-processed' }
RSAthensMorph >> eventKeyUp: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSKeyUp from: aMorphicEvent.
	trEvent
		position: (roassalCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyName: aMorphicEvent key name.
	trEvent shape announce: trEvent
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: RSMouseClick
		ifLeftButton: RSMouseLeftClick
		ifRightButton: RSMouseRightClick
		from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseDoubleClick: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: RSMouseDoubleClick
		ifLeftButton: RSMouseDoubleLeftClick
		ifRightButton: RSMouseDoubleRightClick
		from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseDragEnd: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseDragEnd from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	
	eventBeginingDragging := nil.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseDragStart: aMorphicEvent [
	| trEvent trEventClass |
	eventBeginingDragging := aMorphicEvent copy.
	
	trEventClass := RSMouseDragStart.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := RSMouseLeftDragStart ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := RSMouseRightDragStart ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ trEventClass := RSMouseMiddleDragStart ].
	trEvent := self eventOfClass: trEventClass actionClass: RSMouseDragging from: aMorphicEvent.

	shapeBeingPointed := trEvent shape.
	shapeBeingPointed announce: trEvent.
	
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseDragging: aMorphicEvent [
	| trEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.

	trEvent := self eventOfClass: RSMouseDragging from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := trEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed parent ifNil: [
		eventBeginingDragging := nil.
		shapeBeingPointed := nil.
		^ self ].

	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	eventBeginingDragging := aMorphicEvent copy.
	
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseEnter: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseEnter from: aMorphicEvent.
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseLeave: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	shapeBeingPointed ifNotNil: [ 
		trEvent shape: shapeBeingPointed].
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseMove: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseMove from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseUp: aMorphicEvent [
	| trEvent |
	trEvent := self
		mouseEventOfClass: RSMouseUp
		ifLeftButton: RSMouseUpLeft  
		ifRightButton: RSMouseUpRight
		from: aMorphicEvent.
	trEvent position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventMouseWheel: aMorphicEvent [
	| trEvent |
	trEvent := self eventOfClass: RSMouseWheelEvent from: aMorphicEvent.
	trEvent
		direction: aMorphicEvent direction;
		position: (roassalCanvas camera fromPixelToSpace: trEvent position).
	trEvent shape announce: trEvent.
]

{ #category : #'event-processed' }
RSAthensMorph >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition trEvent shape |
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition. 
	
	trEvent := anEventClass fromEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: roassalCanvas;
		shape: shape;
		position: relativePosition.
	^ trEvent
]

{ #category : #'event-processed' }
RSAthensMorph >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : #'event-processed' }
RSAthensMorph >> eventOfClass: anEventClass shape: aShape from: aMorphicEvent [
	| relativePosition trEvent |
	relativePosition := self relativePositionFor: aMorphicEvent.

	trEvent := anEventClass fromEvent: aMorphicEvent.
	trEvent
		morph: self;
		canvas: roassalCanvas;
		shape: aShape;
		position: relativePosition.
	^ trEvent
]

{ #category : #drawing }
RSAthensMorph >> fullDrawOnAthensCanvas: aCanvas [

	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[  
		self checkSession.
		self recreateSurfaceIfNecessary.
		
		aCanvas setPaint: roassalCanvas color.
		aCanvas drawShape: bounds.
		roassalCanvas playAnimations.
		self drawShapes.
		surface hasBeenFreed ifTrue: [ self createSurface ].	

		aCanvas pathTransform restoreAfter: [
			aCanvas pathTransform loadIdentity.
			aCanvas paintMode restoreAfter: [
				aCanvas 
					setPaint: surface;
					drawShape: (0@0 extent: self extent) ] ] ]
	ensure: [ 
		isDrawing := false ]
]

{ #category : #'event handling' }
RSAthensMorph >> handleKeyDown: anEvent [
	
	super handleKeyDown: anEvent.
	self eventKeyDown: anEvent.
]

{ #category : #'events-processing' }
RSAthensMorph >> handleKeyUp: anEvent [
	super handleKeyUp: anEvent.
	self eventKeyUp: anEvent
]

{ #category : #'events-processing' }
RSAthensMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	anEvent anyButtonPressed ifFalse: [ self eventMouseMove: anEvent ].
	
	
]

{ #category : #'events-processing' }
RSAthensMorph >> handleMouseOver: aMorphicEvent [
	| currentElement trEvent |
	super handleMouseOver: aMorphicEvent.
	aMorphicEvent wasHandled
		ifTrue: [ ^ self ].	"Do nothing if it was already handled"
	self isDragging
		ifTrue: [ ^ self ].	"Do nothing if we are dragging"
	lastMousePosition = aMorphicEvent position 
		ifTrue: [ ^ self].		"Do nothing if it is in the same position"
	shapeBeingPointed ifNil: [ shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	
	currentElement := self shapeForEvent: aMorphicEvent.
	lastMousePosition := aMorphicEvent position.
	currentElement == shapeBeingPointed 
		ifTrue: [ ^ self ].
	trEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	trEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: trEvent.
	shapeBeingPointed := currentElement.
	self eventMouseEnter: aMorphicEvent.
]

{ #category : #testing }
RSAthensMorph >> handlesKeyboard: evt [
	^true
]

{ #category : #'event handling' }
RSAthensMorph >> handlesMouseDown: anEvent [
	^ anEvent wasHandled not	"not interested if handled"
]

{ #category : #'event handling' }
RSAthensMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : #'events-processing' }
RSAthensMorph >> handlesMouseWheel: evt [
	^true
]

{ #category : #'event handling' }
RSAthensMorph >> hasFocus [
	^ true
]

{ #category : #initialization }
RSAthensMorph >> initialize [
	super initialize.
	self createSurface.
	session := Smalltalk session.
	isDrawing := false
]

{ #category : #testing }
RSAthensMorph >> isDragging [
	^ eventBeginingDragging notNil
]

{ #category : #accessing }
RSAthensMorph >> isDrawing [
	^ isDrawing
]

{ #category : #initialization }
RSAthensMorph >> layoutChanged [
	"react on morph resize"

	super layoutChanged.
	self checkSession.
	
]

{ #category : #'event handling' }
RSAthensMorph >> mouseDown: evt [
	eventBeginingDragging
		ifNil:
			[ evt hand
				waitForClicksOrDrag: self
				event: evt
				selectors: {#eventMouseClick:. #eventMouseDoubleClick:. nil. #eventMouseDragStart:. }
				threshold: 5.
			^ self ].

	evt anyButtonPressed
		ifTrue: [ self eventMouseDragging: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
RSAthensMorph >> mouseEnter: evt [
	evt anyButtonPressed
		ifFalse: [ self eventMouseEnter: evt ].
	evt wasHandled: true
]

{ #category : #'event-processed' }
RSAthensMorph >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| trEventClass |
	trEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ trEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ trEventClass := rightButtonClass ].
	^ self eventOfClass: trEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : #'event handling' }
RSAthensMorph >> mouseLeave: evt [
	evt anyButtonPressed
		ifFalse: [ self eventMouseLeave: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
RSAthensMorph >> mouseMove: evt [
	evt anyButtonPressed
		ifTrue: [ self eventMouseDragging: evt ]
		ifFalse: [ self eventMouseMove: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
RSAthensMorph >> mouseUp: evt [
	self isDragging
		ifTrue: [ self eventMouseDragEnd: evt ]
		ifFalse: [ self eventMouseUp: evt ].
	evt wasHandled: true
]

{ #category : #'event handling' }
RSAthensMorph >> mouseWheel: evt [
	self eventMouseWheel: evt.
	evt wasHandled: true
]

{ #category : #recategorized }
RSAthensMorph >> recreateSurfaceIfNecessary [
	surface
		ifNotNil: [ self extent asIntegerPoint ~= surface extent
				ifTrue: [ self createSurface.
					roassalCanvas extent: self extent ] ]
]

{ #category : #'events-roassal' }
RSAthensMorph >> relativePositionFor: evt [
	^ evt position - self bounds origin
]

{ #category : #dependencies }
RSAthensMorph >> release [
	"This method is useful in case some references of TRMorph cannot be garbage collected, as it may happen with GT."
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #accessing }
RSAthensMorph >> renderer [
	^ renderer
]

{ #category : #accessing }
RSAthensMorph >> renderer: aRenderer [
	renderer := aRenderer
]

{ #category : #accessing }
RSAthensMorph >> roassalCanvas [
	"Return the Roassal canvas that I have to render"
	^ roassalCanvas
]

{ #category : #public }
RSAthensMorph >> setTakeKeyboardFocus [
	self takeKeyboardFocus.
	roassalCanvas when: RSUserInputEvent do: [ self takeKeyboardFocus ].
]

{ #category : #'event-processed' }
RSAthensMorph >> shapeForEvent: anEvent [
	"Return the Trachel shape for the event provided as argument"
	^ self shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : #accessing }
RSAthensMorph >> shapeForPositionInPixels: point [
	"Return the shape located that contains point"
	 ^ roassalCanvas shapeForPositionInPixels: point
]

{ #category : #accessing }
RSAthensMorph >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"
	 ^ roassalCanvas shapeWithAction: eventClass forPositionInPixels: position
]

{ #category : #accessing }
RSAthensMorph >> shapeWithActionForPositionInPixels: point [
	"Return the shape with event handler located that contains point"
	 ^ roassalCanvas shapeWithActionForPositionInPixels: point
]

{ #category : #drawing }
RSAthensMorph >> showRectanglesIfNecessary: shapes [
	roassalCanvas showRectangles ifFalse: [ ^ self ].
	
	renderer canvas setPaint: (Color blue alpha: 0.2).
	shapes do: [ :shape | | r |
		r := shape encompassingRectangle.
		r := r origin asFloatPoint corner: r corner asFloatPoint.
		renderer canvas drawShape: r.
		].
]

{ #category : #signaling }
RSAthensMorph >> signalUpdate [
	self changed
]

{ #category : #signaling }
RSAthensMorph >> step [
	self wantsSteps ifFalse: [ ^ self ].
	self changed
]

{ #category : #signaling }
RSAthensMorph >> stepTime [
	"Answer the desired time between steps in milliseconds. This default implementation requests that the 'step' method be called once every second."

	^ 20
]

{ #category : #accessing }
RSAthensMorph >> surface [
	^ surface
]

{ #category : #accessing }
RSAthensMorph >> surface: anAthensCairoSurface [ 
	surface := anAthensCairoSurface
]

{ #category : #'events-processing' }
RSAthensMorph >> takesKeyboardFocus [
	^ true
]

{ #category : #testing }
RSAthensMorph >> wantsSteps [
	^ roassalCanvas hasAnimation 
]

{ #category : #'event handling' }
RSAthensMorph >> wouldAcceptKeyboardFocusUponTab [
	"Answer whether the receiver might accept keyboard focus if 
	tab were hit in some container playfield"
	^ true
]
