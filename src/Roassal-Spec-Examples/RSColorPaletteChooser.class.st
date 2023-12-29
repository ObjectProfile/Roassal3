"
Basic color chooser, just click on button next to method run.

I present color palettes from `RSColorPalette`. if you click over one palette. The code to use that color palette on your application will be selected.

Check this example `RSColorPaletteChooser class >> #example1`

"
Class {
	#name : 'RSColorPaletteChooser',
	#superclass : 'SpPresenter',
	#instVars : [
		'buttons',
		'colors',
		'currentPalette',
		'selectedHighlight',
		'overHighlight',
		'boxColorHighlight'
	],
	#category : 'Roassal-Spec-Examples-Menu',
	#package : 'Roassal-Spec-Examples',
	#tag : 'Menu'
}

{ #category : 'layout' }
RSColorPaletteChooser class >> defaultLayout [
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #buttons withConstraints: [ :c | c height: self toolbarHeight ];
		add: #colors;
		yourself
]

{ #category : 'examples' }
RSColorPaletteChooser class >> example1 [
	| canvas palette |
	canvas := RSCanvas new.
	"we create some shapes"
	canvas addAll: (RSBox models: Collection withAllSubclasses).

	"Palette copied from this window, just copy and paste from the palette chooser :D"
	palette := RSColorPalette diverging brbg11.

	"the palette is used based on each shape super class"
	canvas nodes do: [ :each |
		each color: (palette rsValue: each model superclass).
		 ].
	"normalize the class size base on each class lines of code"
	RSNormalizer size
		shapes: canvas nodes;
		normalize: #linesOfCode.
	"create some links based on super class"
	RSLineBuilder line
		withVerticalAttachPoint;
		shapes: canvas nodes;
		connectFrom: #superclass.
	"We use a layout once"
	RSTreeLayout on: canvas nodes.
	"finally some interactions"
	canvas @ RSCanvasController.
	canvas nodes @ RSPopup; @ RSDraggable.
	canvas open
]

{ #category : 'utilities' }
RSColorPaletteChooser >> boxColorFor: color [

	| label box |
	box := RSBox new
		       extent: 150 @ 30;
		       color: color;
		       yourself.
	label := RSLabel new
		         noPaint;
		         text: color asHexString;
		         yourself.
	^ {
		  box.
		  label } asShape
		  @ boxColorHighlight;
		  model: color;
		  when: RSMouseClick
		  do: [ :evt | self copyToClipboard: evt shape model ]
		  for: self;
		  yourself
]

{ #category : 'utilities' }
RSColorPaletteChooser >> boxesFor: anArray [
	^ anArray collect: [ :color | self boxColorFor: color ] as: RSGroup
]

{ #category : 'events' }
RSColorPaletteChooser >> buttonClick: evt [
	"first we unhighlight the mouse over highlight"
	overHighlight doUnhighlight: evt shape.
	"then with mark the selection hightlight"
	selectedHighlight doHighlight: evt shape.
	self currentPalette: evt shape model.
	evt signalUpdate
]

{ #category : 'utilities' }
RSColorPaletteChooser >> buttonFor: m [
	| label box |
	label := RSLabel new
		bold;
		text: m key;
		color: Color white;
		yourself.
	box := self polygonFor: m value.

	^ { box. label } asShape
		model: m key;
		when: RSMouseClick send: #buttonClick: to: self;
		yourself
]

{ #category : 'utilities' }
RSColorPaletteChooser >> buttonModels [
	^ {
		('Diverging' -> {
			(0 @ 0).
			(150 @ 0).
			(130 @ 30).
			(0 @ 30) }).
		('Qualitative' -> {
			(20 @ 0).
			(150 @ 0).
			(130 @ 30).
			(0 @ 30) }).
		('Sequential' -> {
			(20 @ 0).
			(150 @ 0).
			(150 @ 30).
			(0 @ 30) }) }
]

{ #category : 'clipboard handling' }
RSColorPaletteChooser >> clipTextFor: anObject [
	| method |
	anObject isColor
		ifTrue: [ ^ anObject asHexString ].
	method := anObject.
	^ RSColorPalette name, ' ',  currentPalette, ' ', method selector
]

{ #category : 'initialization' }
RSColorPaletteChooser >> connectPresenters [
	self currentPalette: #Diverging.
	buttons script: [ :canvas |
		self renderButtonsOn: canvas ].
	colors script: [ :canvas |
		self renderColorPaletteOn: canvas ]
]

{ #category : 'accessing' }
RSColorPaletteChooser >> controllerInteraction [
	| controls |
	controls := RSCanvasController new.
	controls noLegend.
	controls removeInteractionIfPresent: RSDraggableCanvasInteraction.
	controls addInteraction: RSScrollWheelCanvasInteraction new.
	controls zoomToFitInteraction
		noZoomToFitOnStart;
		noZoomToFitOnExtendChanged.
	controls keyNavigationInteraction hasHorizontalScrolling: false.
	controls configuration
		padding: 0@ 10;
		maxScale: 1;
		minScale: 1.
	^ controls
]

{ #category : 'clipboard handling' }
RSColorPaletteChooser >> copyToClipboard: object [
	| name |
	Clipboard clipboardText: (self clipTextFor: object).
	name := 'Palette'.
	object isColor ifTrue: [ name := 'Color' ].
	self inform: name,' copied to clipboard !!!'
]

{ #category : 'accessing' }
RSColorPaletteChooser >> currentPalette: newPaletteSelector [
	currentPalette := newPaletteSelector asLowercase asSymbol.
	colors refresh
]

{ #category : 'initialization' }
RSColorPaletteChooser >> initializeInteractions [
	selectedHighlight := RSHighlightable new.
	"because it is a composite and the first children is the background"
	"when the element is selected"
	selectedHighlight highlightShapes: [ :e | {e shapes first} ].
	selectedHighlight highlightColor: (
		(LinearGradientPaint fromArray:
			{0->'white'.
			0.25->'blue'.
			1 ->'lightGray'})
			start: 0@ -15;
			stop: 0@ 15).
	"when the mouse is over the button"
	overHighlight := RSHighlightable new.
	overHighlight
		highlightShapes: [ :e | {e shapes first} ]
		butKeep: selectedHighlight.
	overHighlight highlightColor: (
		(LinearGradientPaint fromArray:
			{0->'white'.
			0.25->'black'.
			1 ->'lightGray'})
			start: 0@ -15;
			stop: 0@ 15).

	"for color boxes"
	boxColorHighlight := RSHighlightable new.
	boxColorHighlight highlightShapes: [ :s | { s shapes second } ].
	boxColorHighlight highlightColor: Color black
]

{ #category : 'initialization' }
RSColorPaletteChooser >> initializePresenters [
	self initializeInteractions.
	buttons := self newRoassal.
	colors := self newRoassal
]

{ #category : 'initialization' }
RSColorPaletteChooser >> initializeWindow: aWindow [
	aWindow
		title: 'Color Palettes';
		initialExtent: 800@500;
		centered
]

{ #category : 'utilities' }
RSColorPaletteChooser >> paletteFor: method [
	| shapes scale |
	scale :=  method selector value: currentPalette.

	shapes := self boxesFor: scale range.
	shapes add: (RSLabel new
		bold;
		text: method selector;
		yourself).
	RSVerticalLineLayout new
		alignCenter;
		gapSize: 0;
		on: shapes.
	^ shapes asShape
		model: method;
		padding: 10;
		withBorder;
		when: RSMouseClick
			do: [ :evt | self copyToClipboard: evt shape model]
]

{ #category : 'utilities' }
RSColorPaletteChooser >> paletteFor: palette method: method [

	| shapes |
	shapes := self boxesFor: palette range.
	shapes add: (RSLabel new
			 bold;
			 text: method selector;
			 yourself).
	RSVerticalLineLayout new
		alignCenter;
		gapSize: 0;
		on: shapes.
	^ shapes asShape
		  model: method;
		  padding: 10;
		  withBorder;
		  when: RSMouseClick
		  do: [ :evt | self copyToClipboard: evt shape model ]
		  for: self;
		  yourself
]

{ #category : 'accessing' }
RSColorPaletteChooser >> palettes [
	| colorPalette |
	colorPalette := currentPalette value: RSColorPalette.

	^ (colorPalette class methods sorted: CompiledMethod sortBlock)
		collect: [ :met | self paletteFor: (met selector value: colorPalette) method: met ]
]

{ #category : 'utilities' }
RSColorPaletteChooser >> polygonFor: points [
	^ RSPolygon new
		withBorder;
		cornerRadii: 5;
		paint: ((LinearGradientPaint fromArray: {
				(0 -> 'lightGray').
				(0.25 -> 'black').
				(1 -> 'gray') })
			start: 0 @ -15;
			stop: 0 @ 15);
		points: points;
		position: 0@0;
		yourself
]

{ #category : 'updating' }
RSColorPaletteChooser >> relayout: evt [
	| canvas |
	canvas := evt canvas.

	RSFlowLayout new
		maxWidth: canvas extent;
		on: canvas shapes.
	canvas camera translateTo: canvas extent / -2 + (20@0)
]

{ #category : 'dependencies' }
RSColorPaletteChooser >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : 'rendering' }
RSColorPaletteChooser >> renderButtonsOn: canvas [
	| data buttonShapes |
	canvas color: '2d5c7f'.

	data := self buttonModels.
	buttonShapes := data collect: [ :m | self buttonFor: m ].

	RSHorizontalLineLayout new
		gapSize: -9;
		on: buttonShapes.
	canvas addAll: buttonShapes.
	selectedHighlight doHighlight: buttonShapes first.

	canvas nodes @ overHighlight.

	canvas when: RSExtentChangedEvent send: #zoomToFit to: canvas
]

{ #category : 'rendering' }
RSColorPaletteChooser >> renderColorPaletteOn: canvas [
	canvas color: 'f8f9fc'.
	canvas addAll: self palettes.
	canvas when: RSExtentChangedEvent send: #relayout: to: self.
	canvas @ self controllerInteraction
]

{ #category : 'running' }
RSColorPaletteChooser >> run [
	<script: 'self new asWindow open'>
]
