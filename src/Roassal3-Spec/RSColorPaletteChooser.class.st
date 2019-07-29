"
I am a basic color chooser for the color palettes
"
Class {
	#name : #RSColorPaletteChooser,
	#superclass : #SpPresenter,
	#instVars : [
		'buttons',
		'colors',
		'shape',
		'currentPalette',
		'selectedHighlight',
		'buttonElements',
		'overHighlight'
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
	selector := currentPalette class name.
	selector := selector copyFrom: 5 to: selector size.
	^ 'TSColorPalette ',  selector asLowercase, ' ', m selector 
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
	selectedHighlight := RSHighlightable new.
	selectedHighlight highlightElements: [ :e | {e children first} ].
	selectedHighlight highlightShape 
		paint: ((TSGradientPalette linearGradient: 
			{0->'white'.
			0.25->'blue'.
			1 ->'lightGray'})
			start: 0@ -15;
			stop: 0@ 15).
	selectedHighlight 
		attributeKey: #buttons;
		copyKey: #qwer.
	overHighlight := RSHighlightable new.
	overHighlight 
		highlightElements: [ :e | {e children first} ]
		butKeep: selectedHighlight.
	overHighlight highlightShape 
		paint: ((TSGradientPalette linearGradient: 
			{0->'white'.
			0.25->'black'.
			1 ->'lightGray'})
			start: 0@ -15;
			stop: 0@ 15).
	
]

{ #category : #initialization }
RSColorPaletteChooser >> initializeShape [
	| lshape bshape bcolor slabel high |
	lshape := RSShapeBuilder label bold.
	slabel := RSShapeBuilder label
		noPaint;
		text: #asHexString.
	bshape := RSShapeBuilder box
		extent: 150@30;
		color: #yourself.
	high := RSHighlightable new.
	high highlightElements: [ :e | {e children second} ].
	high highlightShape color: Color black.
	bcolor := RSShapeBuilder composite
		addInteraction: high; 
		when: TSMouseClick do: [ :c | [ self copyToClipboard: c ] ];
		shapes: [ :c | 
			TSGroup
				with: (bshape elementOn: c)
				with: (slabel elementOn: c) ].
	shape := RSShapeBuilder composite
		shapes: [ :m | | shapes scale |
			scale := (currentPalette perform: m selector). 
			shapes := bcolor elementsOn: scale range.
			shapes add: (lshape elementOn: m selector).
			RSVerticalLineLayout new
				alignCenter;
				gapSize: 0; 
				on: shapes.
			shapes ];
		padding: 10 asMargin;
		border: TSBorder new;
		when: TSMouseClick do: [:m | [:evt| self copyToClipboard: m] ].
]

{ #category : #initialization }
RSColorPaletteChooser >> initializeWidgets [
	buttons := self instantiate: RoassalPresenter.
	colors := self instantiate: RoassalPresenter.
	buttons script: [ :view | 
		self renderButtonsOn: view.
		self renderColorPalettesFor: buttonElements first.].
	self initializeShape.
	self initializeInteractions.
	
]

{ #category : #initialization }
RSColorPaletteChooser >> initializeWindow: w [
	w 
		title: 'Color Palettes';
		initialExtent: 800@500;
		centered
]

{ #category : #dependencies }
RSColorPaletteChooser >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #rendering }
RSColorPaletteChooser >> renderButtonsOn: view [
	| data bshape lshape menuButton |
	view color: '2d5c7f'.
	data := { 
		'Diverging' -> { 0@0. 150@0. 130@30. 0@30}.
		'Qualitative' -> { 20@0. 150@0. 130@30. 0@30 }.
		'Sequential' -> { 20@0. 150@0. 150@ 30. 0@30 } }.
	
	bshape := RSShapeBuilder polygon
		border: TSBorder new;
		cornerRadii: 5;
		paint: ((TSGradientPalette linearGradient: 
			{0->'lightGray'.
			0.25->'black'.
			1 ->'gray'})
			start: 0@ -15;
			stop: 0@ 15); 
		points: #value.
	lshape := RSShapeBuilder label 
		bold; 
		text: #key;
		color: Color white.
	menuButton := RSShapeBuilder composite
		addInteraction: overHighlight;
		shapes: [ :m | | box label |
			box := bshape elementOn: m.
			box position: 0@0.
			label := lshape elementOn: m.
			TSGroup with: box with: label ];
		onElement;
		when: TSMouseClick do: [:e | [ self renderColorPalettesFor: e ] ].
	buttonElements := menuButton elementsOn: data.
	RSHorizontalLineLayout new gapSize: -9; on: buttonElements.
	view addAll: buttonElements.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
]

{ #category : #rendering }
RSColorPaletteChooser >> renderColorPaletteOn: view [
	| elements controls |
	view color: 'f8f9fc'.
	elements := shape elementsOn: (currentPalette class methods 
		sorted: [:a :b | a selector <  b selector]).
	view addAll: elements.
	
	controls := RSControlsView new.
	controls noLegend.
	controls configuration 
		noZoomToFitOnStart;
		noZoomToFitOnExtendChanged;
		maxScale: 1;
		minScale: 1.
	view when: TSExtentChangedEvent do: [ 
		RSFlowLayout new
			maxWidth: view extent;
			on: elements.
		view camera translateTo: view extent / 2. ].
	view @ controls.
	
	
]

{ #category : #rendering }
RSColorPaletteChooser >> renderColorPalettesFor: aElement [
	| symbol |
	symbol := aElement model key.
	currentPalette := TSColorPalette perform: symbol asLowercase asSymbol.
	overHighlight doUnhighlight: aElement.
	selectedHighlight doHighlight: aElement.
	aElement signalUpdate.
	colors script: [ :view | self renderColorPaletteOn: view ].
]

{ #category : #initialization }
RSColorPaletteChooser >> run [
	<script: 'self new openWithSpec'>
]
