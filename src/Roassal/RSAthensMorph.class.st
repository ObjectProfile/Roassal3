"
A RSAthensMorph is at the interface between Morphic and Roassal. 
I am directly referenced by RSCanvas
"
Class {
	#name : 'RSAthensMorph',
	#superclass : 'Morph',
	#instVars : [
		'renderer',
		'session',
		'surface',
		'isDrawing',
		'roassalCanvas',
		'eventProcessor'
	],
	#category : 'Roassal-Morph',
	#package : 'Roassal',
	#tag : 'Morph'
}

{ #category : 'examples' }
RSAthensMorph class >> example [
	| morph roassalCanvas |
	"this class is used by RSCanvas, if you can use RSCanvas insted use directly RSAthensMorph"
	morph := self new.
	roassalCanvas := RSCanvas new.
	roassalCanvas newLabel
		text: 'Hello Roassal';
		color: Color lightGray translucent;
		fontSize: 80;
		bold;
		borderDo: [:border | border color: Color black; width: 3].

	morph canvas: roassalCanvas.
	morph renderer: RSAthensRenderer new.

	^ (morph openInWindowLabeled: 'Demo')
		extent: 600@300;
		yourself
]

{ #category : 'accessing' }
RSAthensMorph >> canvas [
	^ roassalCanvas
]

{ #category : 'accessing' }
RSAthensMorph >> canvas: aRoassalCanvas [
	roassalCanvas := aRoassalCanvas.
	eventProcessor roassalCanvas: roassalCanvas
]

{ #category : 'session management' }
RSAthensMorph >> checkSession [
	"The mechanism of session is useful in case you have a visualization open, save-and-quit the image, and open the image again.
	Naturally, you wish to see the visualization again. The session mechanism makes sure that low-level resources that belongs to Cairo are properly recreated"
	session == Smalltalk session ifTrue: [ ^ self ].
	surface := nil.
	self createSurface.
	self sessionChanged
]

{ #category : 'surface management' }
RSAthensMorph >> createSurface [
	surface := AthensCairoSurface extent: self extent asIntegerPoint.
	session := Smalltalk session
]

{ #category : 'drawing' }
RSAthensMorph >> drawOn: aCanvas [
	"Draw the whole visualization"
	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[
		self checkSession.
		self recreateSurfaceIfNecessary.
		aCanvas
			fillRectangle: self bounds
			fillStyle: roassalCanvas color
			borderStyle: self borderStyle.
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
		do: [ :ex | ex traceCr ]
	] ensure: [ isDrawing := false ]
]

{ #category : 'drawing' }
RSAthensMorph >> drawOnAthensCanvas: aCanvas [
	self fullDrawOnAthensCanvas: aCanvas
]

{ #category : 'drawing' }
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

{ #category : 'drawing' }
RSAthensMorph >> drawShapes [
	"The drawing has to be done when a change in the shapes occured or when there is an animation."
	surface drawDuring: [ :athensCanvas |
		renderer
			surface: surface;
			canvas: athensCanvas.
		roassalCanvas accept: renderer.
	]
]

{ #category : 'accessing' }
RSAthensMorph >> eventProcessor: aRSEventProcessor [
	eventProcessor := aRSEventProcessor.
	eventProcessor 
		morph: self;
		roassalCanvas: roassalCanvas
]

{ #category : 'drawing' }
RSAthensMorph >> fullDrawOnAthensCanvas: aCanvas [

	isDrawing ifTrue: [ ^ self ].
	isDrawing := true.
	[
		self checkSession.
		self recreateSurfaceIfNecessary.

		aCanvas setPaint: roassalCanvas color.
		aCanvas drawShape: (bounds translateBy: bounds origin negated).
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

{ #category : 'events - processing' }
RSAthensMorph >> handleKeyDown: anEvent [
	super handleKeyDown: anEvent.
	eventProcessor eventKeyDown: anEvent
]

{ #category : 'events - processing' }
RSAthensMorph >> handleKeyUp: anEvent [
	super handleKeyUp: anEvent.
	eventProcessor eventKeyUp: anEvent
]

{ #category : 'events - processing' }
RSAthensMorph >> handleMouseMove: anEvent [
	super handleMouseMove: anEvent.
	anEvent anyButtonPressed ifFalse: [ eventProcessor eventMouseMove: anEvent ]
]

{ #category : 'events - processing' }
RSAthensMorph >> handleMouseOver: aMorphicEvent [
	aMorphicEvent wasHandled
		ifTrue: [ ^ self ]. "Do nothing if it was already handled"
	eventProcessor isDragging
		ifTrue: [ ^ self ]. "Do nothing if we are dragging"
	self window = SystemWindow topWindow
		ifFalse: [ ^ self ].
	eventProcessor lastMousePosition = aMorphicEvent position
		ifTrue: [ ^ self]. "Do nothing if it is in the same position"
	eventProcessor lastMousePosition: aMorphicEvent position.
	eventProcessor eventMouseOver: aMorphicEvent.
]

{ #category : 'testing' }
RSAthensMorph >> handlesKeyboard: evt [
	^true
]

{ #category : 'event handling' }
RSAthensMorph >> handlesMouseDown: anEvent [
	^ anEvent wasHandled not
]

{ #category : 'event handling' }
RSAthensMorph >> handlesMouseOver: evt [
	^ true
]

{ #category : 'events - processing' }
RSAthensMorph >> handlesMouseWheel: evt [
	^true
]

{ #category : 'event handling' }
RSAthensMorph >> hasFocus [
	^ true
]

{ #category : 'initialization' }
RSAthensMorph >> initialize [
	super initialize.
	self eventProcessor: RSEventProcessor new.
	self createSurface.
	session := Smalltalk session.
	isDrawing := false
]

{ #category : 'testing' }
RSAthensMorph >> isDrawing [
	^ isDrawing
]

{ #category : 'accessing' }
RSAthensMorph >> lastMousePosition [
	^ eventProcessor lastMousePosition
]

{ #category : 'recategorized' }
RSAthensMorph >> layoutChanged [
	"react on morph resize"

	super layoutChanged.
	self checkSession
]

{ #category : 'event handling' }
RSAthensMorph >> mouseDown: evt [
	self takeKeyboardFocus.
	eventProcessor hasEvents ifFalse: [
		evt hand
			waitForClicksOrDrag: eventProcessor
			event: evt
			selectors: {
				#eventMouseClick:.
				#eventMouseDoubleClick:.
				nil.
				#eventMouseDragStart:. }
			threshold: 5.
		^ self ].
	evt anyButtonPressed
		ifTrue: [ eventProcessor eventMouseDragging: evt ].
	evt wasHandled: true.
]

{ #category : 'event handling' }
RSAthensMorph >> mouseEnter: evt [
	evt anyButtonPressed
		ifFalse: [ eventProcessor eventMouseEnter: evt ].
	evt wasHandled: true
]

{ #category : 'event handling' }
RSAthensMorph >> mouseLeave: evt [
	evt anyButtonPressed
		ifFalse: [ eventProcessor eventMouseLeave: evt ].
	evt wasHandled: true
]

{ #category : 'event handling' }
RSAthensMorph >> mouseMove: evt [
	evt anyButtonPressed ifTrue: [ eventProcessor eventMouseDragging: evt ]
]

{ #category : 'event handling' }
RSAthensMorph >> mouseUp: evt [
	eventProcessor isDragging
		ifTrue: [ eventProcessor eventMouseDragEnd: evt ]
		ifFalse: [ eventProcessor eventMouseUp: evt ].
	evt wasHandled: true
]

{ #category : 'event handling' }
RSAthensMorph >> mouseWheel: evt [
	eventProcessor eventMouseWheel: evt.
	evt wasHandled: true
]

{ #category : 'session management' }
RSAthensMorph >> recreateSurfaceIfNecessary [
	surface
		ifNotNil: [ self extent asIntegerPoint ~= surface extent
				ifTrue: [ self createSurface.
					roassalCanvas extent: self extent ] ]
]

{ #category : 'dependencies' }
RSAthensMorph >> release [
	"This method is useful in case some references of TRMorph cannot be garbage collected, as it may happen with GT."
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : 'accessing' }
RSAthensMorph >> renderer [
	^ renderer
]

{ #category : 'accessing' }
RSAthensMorph >> renderer: aRenderer [
	renderer := aRenderer
]

{ #category : 'accessing' }
RSAthensMorph >> roassalCanvas [
	"Return the Roassal canvas that I have to render"
	^ self canvas
]

{ #category : 'session management' }
RSAthensMorph >> sessionChanged [

	roassalCanvas shapes do: [ :s | s sessionChanged ].
	roassalCanvas fixedShapes do: [ :s | s sessionChanged ].
	roassalCanvas extent: self extent
]

{ #category : 'signaling' }
RSAthensMorph >> signalUpdate [
	self changed
]

{ #category : 'signaling' }
RSAthensMorph >> step [
	self wantsSteps ifFalse: [ ^ self ].
	self changed
]

{ #category : 'signaling' }
RSAthensMorph >> stepTime [
	"Answer the desired time between steps in milliseconds. This default implementation requests that the 'step' method be called once every second."

	^ 10
]

{ #category : 'accessing' }
RSAthensMorph >> surface [
	^ surface
]

{ #category : 'accessing' }
RSAthensMorph >> surface: anAthensCairoSurface [
	surface := anAthensCairoSurface
]

{ #category : 'events - processing' }
RSAthensMorph >> takesKeyboardFocus [
	^ true
]

{ #category : 'theme' }
RSAthensMorph >> themeChanged [
	roassalCanvas announce: RSThemeChangedEvent new
]

{ #category : 'testing' }
RSAthensMorph >> wantsSteps [
	^ roassalCanvas hasAnimation
]

{ #category : 'event handling' }
RSAthensMorph >> wouldAcceptKeyboardFocusUponTab [
	"Answer whether the receiver might accept keyboard focus if
	tab were hit in some container playfield"
	^ true
]
