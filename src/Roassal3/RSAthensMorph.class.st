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
	#classVars : [
		'KeyTable'
	],
	#category : #'Roassal3-Morph'
}

{ #category : #initialization }
RSAthensMorph class >> initializeKeyTable [
	KeyTable := Dictionary new.
	#(
		16r08f6 Function "XK_function"
		16rff08 BackSpace "XK_BackSpace"
		9 Tab "XK_Tab"
		16rff0a Linefeed "XK_Linefeed"
		16rff0b Clear "XK_Clear"
		13 Return "XK_Return"
		16rff13 Pause "XK_Pause"
		16rff14 Scroll_Lock "XK_Scroll_Lock"
		16rff15 Sys_Req "XK_Sys_Req"
		16rff1b Escape "XK_Escape"
		8 Delete "XK_Delete"
		16rff50 Home "XK_Home"
		16rff51 Left "XK_Left"
		16rff52 Up "XK_Up"
		16rff53 Right "XK_Right"
		16rff54 Down "XK_Down"
		16rfe03 Level3Shift "XK_ISO_Level3_Shift"
		16r00a1 ExclamationDown "XK_exclamdown"
		16r00bf QuestionDown "XK_questiondown"
		16r00f1 NTilde "XK_ntilde"
		16r00d1 CapitalNTilde "XK_ntilde"
		16r00ba Masculine "XK_masculine"
		16r00e7 CCedilla "XK_ccedilla"
		16r00c7 CapitalCCedilla "XK_ccedilla"
		16r00aa FeminineOrdinal "XK_ordfeminine"
		16r00b7 MiddlePoint "XK_periodcentered"
		"16rff55 Prior ""XK_Prior"
		16rff55 Page_Up "XK_Page_Up"
		"16rff56 Next" "XK_Next"
		16rff56 Page_Down "XK_Page_Down"
		16rff57 End "XK_End"
		16rff58 Begin "XK_Begin"
		32 KP_Space "XK_KP_Space"
		16rff89 KP_Tab "XK_KP_Tab"
		16rff8d KP_Enter "XK_KP_Enter"
		16rff91 KP_F1 "XK_KP_F1"
		16rff92 KP_F2 "XK_KP_F2"
		16rff93 KP_F3 "XK_KP_F3"
		16rff94 KP_F4 "XK_KP_F4"
		16rff95 KP_Home "XK_KP_Home"
		28 KP_Left "XK_KP_Left"
		30 KP_Up "XK_KP_Up"
		29 KP_Right "XK_KP_Right"
		31 KP_Down "XK_KP_Down"
		16rff9a KP_Prior "XK_KP_Prior"
		16rff9a KP_Page_Up "XK_KP_Page_Up"
		16rff9b KP_Next "XK_KP_Next"
		16rff9b KP_Page_Down "XK_KP_Page_Down"
		16rff9c KP_End "XK_KP_End"
		16rff9d KP_Begin "XK_KP_Begin"
		16rff9e KP_Insert "XK_KP_Insert"
		16rff9f KP_Delete "XK_KP_Delete"
		24 KP_Equal "XK_KP_Equal"
		16rffaa KP_Multiply "XK_KP_Multiply"
		16rffab KP_Add "XK_KP_Add"
		16rffac KP_Separator "XK_KP_Separator"
		16rffad KP_Subtract "XK_KP_Subtract"
		16rffae KP_Decimal "XK_KP_Decimal"
		16rffaf KP_Divide "XK_KP_Divide"
		16rffb0 KP_0 "XK_KP_0"
		16rffb1 KP_1 "XK_KP_1"
		16rffb2 KP_2 "XK_KP_2"
		16rffb3 KP_3 "XK_KP_3"
		16rffb4 KP_4 "XK_KP_4"
		16rffb5 KP_5 "XK_KP_5"
		16rffb6 KP_6 "XK_KP_6"
		16rffb7 KP_7 "XK_KP_7"
		16rffb8 KP_8 "XK_KP_8"
		16rffb9 KP_9 "XK_KP_9"
		16rffbe F1 "XK_F1"
		16rffbf F2 "XK_F2"
		16rffc0 F3 "XK_F3"
		16rffc1 F4 "XK_F4"
		16rffc2 F5 "XK_F5"
		16rffc3 F6 "XK_F6"
		16rffc4 F7 "XK_F7"
		16rffc5 F8 "XK_F8"
		16rffc6 F9 "XK_F9"
		16rffc7 F10 "XK_F10"
		16rffc8 F11 "XK_F11"
		16rffc9 F12 "XK_F12"
		16rffe1 Shift_L "XK_Shift_L"
		16rffe2 Shift_R "XK_Shift_R"
		16rffe3 Control_L "XK_Control_L"
		16rffe4 Control_R "XK_Control_R"
		16rffe5 Caps_Lock "XK_Caps_Lock"
		16rffe6 Shift_Lock "XK_Shift_Lock"
		16rffe7 Meta_L "XK_Meta_L"
		16rffe8 Meta_R "XK_Meta_R"
		16rffe9 Alt_L "XK_Alt_L"
		16rffea Alt_R "XK_Alt_R"
		16rffeb Super_L "XK_Super_L"
		16rffec Super_R "XK_Super_R"
		16rffed Hyper_L "XK_Hyper_L"
		16rffee Hyper_R "XK_Hyper_R"
		16rfe50 dead_grave "XK_dead_grave"
		16rfe51 dead_acute "XK_dead_acute"
		16rfe52 dead_circumflex "XK_dead_circumflex"
		16rfe53 dead_tilde "XK_dead_tilde"
		16rfe53 dead_perispomeni "XK_dead_perispomeni"
		16rfe54 dead_macron "XK_dead_macron"
		16rfe55 dead_breve "XK_dead_breve"
		16rfe56 dead_abovedot "XK_dead_abovedot"
		16rfe57 dead_diaeresis "XK_dead_diaeresis"
		16rfe58 dead_abovering "XK_dead_abovering"
		16rfe59 dead_doubleacute "XK_dead_doubleacute"
		16rfe5a dead_caron "XK_dead_caron"
		16rfe5b dead_cedilla "XK_dead_cedilla"
		16rfe5c dead_ogonek "XK_dead_ogonek"
		16rfe5d dead_iota "XK_dead_iota"
		16rfe5e dead_voiced_sound "XK_dead_voiced_sound"
		16rfe5f dead_semivoiced_sound "XK_dead_semivoiced_sound"
		16rfe60 dead_belowdot "XK_dead_belowdot"
		16rfe61 dead_hook "XK_dead_hook"
		16rfe62 dead_horn "XK_dead_horn"
		16rfe63 dead_stroke "XK_dead_stroke"
		16rfe64 dead_abovecomma "XK_dead_abovecomma"
		16rfe64 dead_psili "XK_dead_psili"
		16rfe65 dead_abovereversedcomma "XK_dead_abovereversedcomma"
		16rfe65 dead_dasia "XK_dead_dasia"
		16rfe66 dead_doublegrave "XK_dead_doublegrave"
		16rfe67 dead_belowring "XK_dead_belowring"
		16rfe68 dead_belowmacron "XK_dead_belowmacron"
		16rfe69 dead_belowcircumflex "XK_dead_belowcircumflex"
		16rfe6a dead_belowtilde "XK_dead_belowtilde"
		16rfe6b dead_belowbreve "XK_dead_belowbreve"
		16rfe6c dead_belowdiaeresis "XK_dead_belowdiaeresis"
		16rfe6d dead_invertedbreve "XK_dead_invertedbreve"
		16rfe6e dead_belowcomma "XK_dead_belowcomma"
		16rfe6f dead_currency "XK_dead_currency"
		16r0020 space "XK_space"
		16r0021 exclam "XK_exclam"
		16r0022 quotedbl "XK_quotedbl"
		16r0023 numbersign "XK_numbersign"
		16r0024 dollar "XK_dollar"
		16r0025 percent "XK_percent"
		16r0026 ampersand "XK_ampersand"
		16r0027 apostrophe "XK_apostrophe"
		"16r0027 quoteright" "XK_quoteright"
		16r0028 parenleft "XK_parenleft"
		16r0029 parenright "XK_parenright"
		16r002a asterisk "XK_asterisk"
		16r002b plus "XK_plus"
		16r002c comma "XK_comma"
		39 minus "XK_minus"
		16r002e period "XK_period"
		45 slash "XK_slash"
		16r0030 zero "XK_0"
		16r0031 one "XK_1"
		16r0032 two "XK_2"
		16r0033 three "XK_3"
		16r0034 four "XK_4"
		16r0035 five "XK_5"
		16r0036 six "XK_6"
		16r0037 seven "XK_7"
		16r0038 eight "XK_8"
		16r0039 nine "XK_9"
		16r003a colon "XK_colon"
		16r003b semicolon "XK_semicolon"
		16r003c less "XK_less"
		193 equal "XK_equal"
		16r003e greater "XK_greater"
		16r003f question "XK_question"
		16r0040 at "XK_at"
		97 A "XK_A"
		98 B "XK_B"
		99 C "XK_C"
		100 D "XK_D"
		101 E "XK_E"
		102 F "XK_F"
		103 G "XK_G"
		104 H "XK_H"
		105 I "XK_I"
		106 J "XK_J"
		107 K "XK_K"
		108 L "XK_L"
		109 M "XK_M"
		110 N "XK_N"
		111 O "XK_O"
		112 P "XK_P"
		113 Q "XK_Q"
		114 R "XK_R"
		115 S "XK_S"
		116 T "XK_T"
		117 U "XK_U"
		118 V "XK_V"
		119 W "XK_W"
		120 X "XK_X"
		121 Y "XK_Y"
		122 Z "XK_Z"
		16r005b bracketleft "XK_bracketleft"
		16r005c backslash "XK_backslash"
		16r005d bracketright "XK_bracketright"
		16r005e asciicircum "XK_asciicircum"
		16r005f underscore "XK_underscore"
		16r0060 grave "XK_grave"
		"16r0060 quoteleft" "XK_quoteleft"
		16r007b braceleft "XK_braceleft"
		16r007c bar "XK_bar"
		16r007d braceright "XK_braceright"
		16r007e asciitilde "XK_asciitilde")
			pairsDo: [ :keyCode :keyname | KeyTable at: keyCode put: keyname asUppercase].
]

{ #category : #public }
RSAthensMorph class >> keyNameFor: code [
	"
	self keyNameFor: Character space charCode
	"
	
	KeyTable ifNil: [ self initializeKeyTable ].
	^ KeyTable at: code ifAbsent: [ code asString ].
]

{ #category : #initialization }
RSAthensMorph class >> reset [
	<script: 'self reset'>
	KeyTable := nil.
]

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
			(roassalShape encompassingRectangle intersects: canvasRect)
				ifTrue: [ 
					roassalShape accept: renderer ] ].
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
	| trEvent keyCharacter |
	keyCharacter := aMorphicEvent keyCharacter.
	(aMorphicEvent commandKeyPressed and: [ keyCharacter = $w ])
		ifTrue: [ ^ self root delete ].
	trEvent := self eventOfClass: RSKeyDown from: aMorphicEvent.
	trEvent
		position: (roassalCanvas camera fromPixelToSpace: trEvent position);
		keyValue: aMorphicEvent keyValue;
		keyName: (self class keyNameFor: aMorphicEvent keyValue).
	trEvent shape announce: trEvent
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

{ #category : #'events-processing' }
RSAthensMorph >> handleKeyUp: anEvent [
	super handleKeyUp: anEvent.
	self eventKeyUp: anEvent
]

{ #category : #'event handling' }
RSAthensMorph >> handleKeystroke: anEvent [
	self eventKeyDown: anEvent.
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
