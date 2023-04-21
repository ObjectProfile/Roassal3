"
Custom basemap builder that supports theme with pharo
"
Class {
	#name : #RSThemedMapBuilder,
	#superclass : #RSMapBuilder,
	#category : #'Roassal3-BaselineMap-Customs'
}

{ #category : #events }
RSThemedMapBuilder >> browse: evt [
	evt shape model browse
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> defaultContainer [
	| theme |
	theme := self theme.
	^ RSCanvas new
		color: theme backgroundColor;
		when: RSThemeChangedEvent send: #themeChanged: to: self;
		addInteraction: (RSCanvasController new
			in: [:i | i configuration useBasicZoom ];
			yourself);
		yourself
]

{ #category : #highlighting }
RSThemedMapBuilder >> highlight: evt [
	| box lines boxes |
	box := evt shape.
	lines := box outgoingLines.
	self highlightLines: lines.
	boxes := (lines collect: #to) asOrderedCollection.
	boxes add: box.
	self highlightBoxes: boxes.
	evt canvas propertyAt: #highlightedLines put: lines
]

{ #category : #highlighting }
RSThemedMapBuilder >> highlightAnt: antBorder [
	| animation canvas |
	canvas := self container.
	antBorder dashArray: #(7 3).
	animation := canvas newAnimation
		repeat;
		from: 0;
		to: antBorder dashArray sum negated;
		duration: 1 second;
		onStepDo: [ :t |
			antBorder dashOffset: t.
			canvas signalUpdate ].

	canvas propertyAt: #ant put: animation
]

{ #category : #highlighting }
RSThemedMapBuilder >> highlightBoxes: boxes [
	| canvas color |
	canvas := self canvas.
	color := TestResult defaultColorBackGroundForPassingTest.
	boxes do: [ :box | | shadow |
		shadow := self shadowFor: box.
		shadow color: color.
		box when: RSPositionChangedEvent do: [ :evt | shadow position: evt newPosition ].
		box propertyAt: #shadow put: shadow.
		canvas addShape: shadow.
		shadow pushBack ].
	canvas propertyAt: #highlightedBoxes put: boxes
]

{ #category : #highlighting }
RSThemedMapBuilder >> highlightLines: lines [
	| canvas antBorder color |
	lines ifEmpty: [ ^ self ].
	canvas := self container.
	antBorder := RSBorder new
		width: 2;
		yourself.
	color := self theme dangerTextColor.
	lines do: [ :line | | border |
		border := line border.
		line propertyAt: #oldBorder put: border.
		line border: antBorder.
		line color: color.
		 ].
	self highlightAnt: antBorder
]

{ #category : #highlighting }
RSThemedMapBuilder >> highlightable [
	^ RSHighlightable new
		when: RSHighlightEvent send: #highlight: to: self;
		when: RSUnHighlightEvent send: #unhighlight: to: self;
		yourself
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> marker [
	| theme marker |
	theme := self theme.
	marker := RSShapeFactory arrow.
	marker color: theme textColor.
	marker size: 10.
	marker := marker asMarker.
	marker offset: 0.
	^ marker
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newBorderFor: aModel [
	aModel baselineClass ifNotNil: [ ^ nil ].
	^ RSBorder new
		color: self theme textColor;
		width: 2;
		dashArray: #(4);
		yourself
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newBox [
	^ super newBox
		color: self theme selectionColor;
		yourself
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newLabelFor: model [
	| label |
	label := super newLabelFor: model.
	model name = baseline name
		ifTrue: [ label fontSize: label fontSize * 1.5; bold ].

	^ label
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newLineBuilder [
	| marker |
	marker := self marker.
	^ RSLineBuilder bezier
		markerEnd: marker;
		attachPoint: (RSHorizontalAttachPoint new
			endOffset: marker shape height / -2;
			yourself);
		controlPointsController: RSHorizontalLeftRightController new;
		color: self theme textColor;
		yourself
]

{ #category : #'instance creation' }
RSThemedMapBuilder >> newShapeFor: model [
	^ (super newShapeFor: model)
		when: RSMouseDoubleClick send: #browse: to: self;
		when: RSMouseRightClick send: #showMenu: to: self;
		yourself
]

{ #category : #hooks }
RSThemedMapBuilder >> renderIn: aCanvas [
	super renderIn: aCanvas.
	aCanvas nodes @ self highlightable
]

{ #category : #highlighting }
RSThemedMapBuilder >> shadowFor: box [
	^ RSBox new
		position: box position;
		extent: box extent + 3;
		cornerRadius: 10;
		yourself
]

{ #category : #events }
RSThemedMapBuilder >> showMenu: evt [
	| menu newContext tool class |

	context ifNil: [ ^ self ].
	class := evt shape model baselineClass.
	class ifNil: [ ^ self] .
	newContext := context copy.
	tool := ClyFullBrowserMorph on: ClyNavigationEnvironment currentImage.
	tool prepareInitialStateBy: [ :b | b selectClass: class ].

	newContext tool: tool.
		menu := CmdContextMenuActivation
			buildContextMenuFor: evt canvas morph
			inContext: newContext.
	menu popUpInWorld: self currentWorld
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> theme [
	^ Smalltalk ui theme
]

{ #category : #'accessing - defaults' }
RSThemedMapBuilder >> themeChanged: evt [
	evt canvas shapes copy do: #remove.
	evt canvas color: self theme backgroundColor.
	self renderIn: evt canvas
]

{ #category : #highlighting }
RSThemedMapBuilder >> unhighlight: evt [
	evt canvas
		propertyAt: #ant ifPresent: [ :anime | anime stop ];
		propertyAt: #highlightedLines ifPresent: [ :lines | self unhighlightLines: lines ];
		propertyAt: #highlightedBoxes ifPresent: [ :boxes | self unhighlightBoxes: boxes ]
]

{ #category : #highlighting }
RSThemedMapBuilder >> unhighlightBoxes: boxes [
	boxes do: [ :box |
		box propertyAt: #shadow ifPresent: [ :shadow | shadow remove ] ]
]

{ #category : #highlighting }
RSThemedMapBuilder >> unhighlightLines: lines [
	lines do: [ :line |
		line border: (line propertyAt: #oldBorder).
		line color: line border color.
		line removeKey: #oldBorder ]
]
