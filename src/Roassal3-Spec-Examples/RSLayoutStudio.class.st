"
Basic layout studio to interact with layout and all subclasses
"
Class {
	#name : #RSLayoutStudio,
	#superclass : #SpPresenter,
	#instVars : [
		'menu',
		'controls',
		'roassalCanvas',
		'currentLayout',
		'layoutDefinition',
		'nodes',
		'oldPositions',
		'graphTextEditor'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #layout }
RSLayoutStudio class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #menu expand: false;
		add: (SpPanedLayout newLeftToRight
			positionOfSlider: 250;
			add: #controls;
			add: #roassalCanvas;
			yourself);
		yourself
]

{ #category : #'instance creation' }
RSLayoutStudio class >> open [
	<script>
	self new open
]

{ #category : #rendering }
RSLayoutStudio class >> renderGraphIn: anRSCanvas [
	RSLayout canvasExampleIn: anRSCanvas
]

{ #category : #initialization }
RSLayoutStudio >> addAnimation: anRSCanvas [
	| newPositions |
	newPositions := nodes collect: [ :each | each position ].
	anRSCanvas newAnimation
		duration: 1 second;
		easing: RSEasingInterpolator backOut;
		onStepDo: [ :t |
			nodes doWithIndex: [ :each :index | | old new |
				old := oldPositions at: index.
				new := newPositions at: index.
				each translateTo: (old interpolateTo: new at: t) ].
			anRSCanvas zoomToFit.
			anRSCanvas signalUpdate.
			 ]
]

{ #category : #public }
RSLayoutStudio >> apply: aRSLayoutField with: anObject [
	oldPositions := nodes collect: [ :each | each position ].
	currentLayout perform: aRSLayoutField selector asMutator with: anObject.
	roassalCanvas refresh
]

{ #category : #initialization }
RSLayoutStudio >> canvasController [
	^ RSCanvasController new
]

{ #category : #initialization }
RSLayoutStudio >> connectPresenters [
	graphTextEditor text: self defaultGraphText.
	self editLayout: RSCircleLayout.
	roassalCanvas script: [ :canvas | self renderIn: canvas ]
]

{ #category : #public }
RSLayoutStudio >> currentLayout [
	^ currentLayout
]

{ #category : #public }
RSLayoutStudio >> currentLayout: aRSLayout [
	currentLayout := aRSLayout
]

{ #category : #initialization }
RSLayoutStudio >> defaultGraphText [
	^ '"canvas is an instance of RSCanvas use it to render a graph"
RSLayoutStudio renderGraphIn: canvas'
]

{ #category : #public }
RSLayoutStudio >> edit: anAssociation [
	| class definition |
	class := anAssociation key.
	definition := anAssociation value.

	self
		currentLayout: class new;
		layoutDefinition: anAssociation value.
	self updateToolPanel.

	self withWindowDo: [ :window | self initializeWindow: window ].
	self update
]

{ #category : #public }
RSLayoutStudio >> editLayout: aRSLayoutClass [
	self edit: aRSLayoutClass -> aRSLayoutClass layoutDefinition
]

{ #category : #initialization }
RSLayoutStudio >> initializePresenters [
	menu := self mainMenu.
	menu addKeybindingsTo: self.
	controls := self newButton.
	graphTextEditor := self newCode.
	roassalCanvas := self newRoassal
]

{ #category : #initialization }
RSLayoutStudio >> initializeWindow: aWindow [
	| title |
	title := 'Layout Studio'.
	currentLayout ifNotNil: [ title := title, ' on:  ', currentLayout class name ].
	aWindow
		title: title;
		initialExtent: 900@600;
		centered
]

{ #category : #accessing }
RSLayoutStudio >> layoutDefinition [
	^ layoutDefinition
]

{ #category : #accessing }
RSLayoutStudio >> layoutDefinition: aRSLayoutDefinition [
	layoutDefinition := aRSLayoutDefinition
]

{ #category : #initialization }
RSLayoutStudio >> mainMenu [
	^ self newMenuBar
		addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Change Layout';
					icon: (self iconNamed: #open);
					action: [ self openLayout ] ] ];
		yourself
]

{ #category : #events }
RSLayoutStudio >> openLayout [
	| selection |
	selection := SpSelectDialog new
		title: 'Select a layout';
		label: 'Select a class';
		items: RSLayout classesWithDefinitionsToEdit;
		display: [ :each | each key name ];
		displayIcon: [ :each | self iconNamed: each key systemIconName ];
		openModal.
	selection ifNotNil: [ self edit: selection ]
]

{ #category : #initialization }
RSLayoutStudio >> renderGraphIn: anRSCanvas [
	"this method will render a graph in a canvas using the source text code editor"
	self textAsBlockClosure value: anRSCanvas
]

{ #category : #initialization }
RSLayoutStudio >> renderIn: anRSCanvas [
	self renderGraphIn: anRSCanvas.
	nodes := anRSCanvas nodes.
	currentLayout on: nodes.
	anRSCanvas @ self canvasController.
	oldPositions ifNil: [ ^ self ].
	self addAnimation: anRSCanvas
]

{ #category : #initialization }
RSLayoutStudio >> textAsBlockClosure [
	^ self class compiler
		source: '[:canvas | ' , graphTextEditor text asString , ']';
		logged: false;
		evaluate
]

{ #category : #public }
RSLayoutStudio >> updateToolPanel [
	| attributes |
	attributes := self instantiate: RSLayoutControls.
	attributes layoutStudio: self.
	controls := self newPresenter.
	controls layout: (SpBoxLayout newVertical
		add: (SpBoxLayout newVertical
			add: 'Graph editor' expand: false;
			add: graphTextEditor withConstraints: [ :c |
				c expand: false; height: 200];
			yourself
			) expand: false;
		spacing: 10;
		add: attributes;
		yourself
		)
]
