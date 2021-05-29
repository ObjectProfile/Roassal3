"
I am a basic color chooser for the color palettes
"
Class {
	#name : #RSColorPaletteChooser,
	#superclass : #SpPresenter,
	#instVars : [
		'buttons',
		'colors',
		'currentPalette',
		'selectedHighlight',
		'buttonElements',
		'overHighlight',
		'boxOver'
	],
	#category : #'Roassal3-Spec-Examples'
}

{ #category : #specs }
RSColorPaletteChooser class >> defaultSpec [ 
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #buttons withConstraints: [ :c | c height: self toolbarHeight ];
		add: #colors;
		yourself
		
]

{ #category : #rendering }
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
	^ RSComposite new
		  @ boxOver;
		  model: color;
		  when: RSMouseClick do: [ :evt | self copyToClipboard: evt shape model ];
		  shapes: { box. label};
		  yourself
]

{ #category : #rendering }
RSColorPaletteChooser >> boxesFor: anArray [
	^ anArray collect: [ :color | self boxColorFor: color ] as: RSGroup
]

{ #category : #rendering }
RSColorPaletteChooser >> buttonFor: m [
	| label box |
	label := RSLabel new
		bold;
		text: m key;
		color: Color white;
		yourself.
	box := RSPolygon new
		withBorder;
		cornerRadii: 5;
		paint: ((LinearGradientPaint fromArray: { 
				(0 -> 'lightGray').
				(0.25 -> 'black').
				(1 -> 'gray') })
			start: 0 @ -15;
			stop: 0 @ 15);
		points: m value;
		position: 0@0;
		yourself.
	^ RSComposite new
		  model: m;
		  shapes: { box. label };
		  @ overHighlight;
		  when: RSMouseClick
		  do: [ :evt | self renderColorPalettesFor: evt shape ];
		  yourself
]

{ #category : #accessing }
RSColorPaletteChooser >> buttons [
	^ buttons
]

{ #category : #accessing }
RSColorPaletteChooser >> buttons: anObject [
	buttons := anObject
]

{ #category : #'clipboard handling' }
RSColorPaletteChooser >> clipTextFor: m [
	| selector |
	m isColor 
		ifTrue: [ ^ m asHexString ].
	selector := currentPalette class paletteName.
	^ RSColorPalette name, ' ',  selector asLowercase, ' ', m selector 
]

{ #category : #accessing }
RSColorPaletteChooser >> colors [
	^ colors
]

{ #category : #accessing }
RSColorPaletteChooser >> colors: anObject [
	colors := anObject
]

{ #category : #'clipboard handling' }
RSColorPaletteChooser >> copyToClipboard: object [
	| name |
	Clipboard clipboardText: (self clipTextFor: object). 
	name := 'Palette'.
	object isColor ifTrue: [ name := 'Color' ].
	self inform: name,' copied to clipboard !!!'
]

{ #category : #initialization }
RSColorPaletteChooser >> initializeInteractions [
	selectedHighlight := RSHighlightableInteraction new.
	selectedHighlight highlightShapes: [ :e | {e shapes first} ].
	selectedHighlight highlightColor: (
		(LinearGradientPaint fromArray:
			{0->'white'.
			0.25->'blue'.
			1 ->'lightGray'})
			start: 0@ -15;
			stop: 0@ 15).
	selectedHighlight 
		propertyKey: #buttons;
		copyKey: #qwer.
	overHighlight := RSHighlightableInteraction new.
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
	"for boxes "
	boxOver := RSHighlightableInteraction new.
	boxOver highlightShapes: [ :s | { s shapes second } ].
	boxOver highlightColor: Color black.
]

{ #category : #initialization }
RSColorPaletteChooser >> initializePresenters [
	buttons := self instantiate: SpRoassalPresenter.
	colors := self instantiate: SpRoassalPresenter.
	buttons script: [ :canvas | 
		self renderButtonsOn: canvas.
		self renderColorPalettesFor: buttonElements first.].
	self initializeInteractions.
	
]

{ #category : #initialization }
RSColorPaletteChooser >> initializeWindow: w [
	w 
		title: 'Color Palettes';
		initialExtent: 800@500;
		centered
]

{ #category : #rendering }
RSColorPaletteChooser >> paletteFor: method [
	| shapes scale |
	scale := currentPalette perform: method selector.
	
	shapes := self boxesFor: scale range.
	shapes add: (RSLabel new 
		bold;
		text: method selector;
		yourself).
	RSVerticalLineLayout new
		alignCenter;
		gapSize: 0;
		on: shapes.
	^ RSComposite new
		model: method;
		shapes: shapes;
		padding: 10;
		withBorder;
		when: RSMouseClick 
			do: [ :evt | self copyToClipboard: evt shape model].
		
]

{ #category : #rendering }
RSColorPaletteChooser >> palettes [
	^ (currentPalette class methods sorted: CompiledMethod sortBlock)
		collect: [ :met | self paletteFor: met ].
]

{ #category : #dependencies }
RSColorPaletteChooser >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #rendering }
RSColorPaletteChooser >> renderButtonsOn: canvas [
	| data |
	canvas color: '2d5c7f'.
	data := { 
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
			(0 @ 30) }) }.
	buttonElements := data collect: [ :m | self buttonFor: m ].
	RSHorizontalLineLayout new
		gapSize: -9;
		on: buttonElements.
	canvas addAll: buttonElements.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ]
]

{ #category : #rendering }
RSColorPaletteChooser >> renderColorPaletteOn: canvas [
	| shapes controls |
	canvas color: 'f8f9fc'.
	shapes := self palettes.
	canvas addAll: shapes.
	
	controls := RSCanvasController new.
	controls noLegend.
	controls interactions removeKey: RSDraggableCanvasInteraction.
	controls interactions at: RSScrollWheelCanvas put: RSScrollWheelCanvas new.
	controls configuration 
		noZoomToFitOnStart;
		padding: 0@ 10;
		noZoomToFitOnExtendChanged;
		maxScale: 1;
		minScale: 1;
		hasHorizontalScrolling: false.
	
	canvas when: RSExtentChangedEvent do: [ 
		RSFlowLayout new
			maxWidth: canvas extent;
			on: shapes.
		canvas camera translateTo: canvas extent / 2 + (-20@0). ].
	canvas @ controls.
	
	
]

{ #category : #rendering }
RSColorPaletteChooser >> renderColorPalettesFor: aShape [
	| symbol |
	symbol := aShape model key.
	currentPalette := RSColorPalette perform: symbol asLowercase asSymbol.
	overHighlight doUnhighlight: aShape.
	selectedHighlight doHighlight: aShape.
	aShape signalUpdate.
	colors script: [ :canvas | self renderColorPaletteOn: canvas ].
]

{ #category : #initialization }
RSColorPaletteChooser >> run [
	<script: 'self new openWithSpec'>
]
