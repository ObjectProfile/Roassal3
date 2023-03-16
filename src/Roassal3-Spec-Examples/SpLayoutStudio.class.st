"
Basic layout studio to interact with layout and all subclasses
"
Class {
	#name : #SpLayoutStudio,
	#superclass : #SpPresenter,
	#instVars : [
		'menu',
		'controls',
		'roassalCanvas',
		'currentLayout',
		'layoutDefinition',
		'nodes',
		'oldPositions'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #layout }
SpLayoutStudio class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #menu expand: false;
		add: (SpPanedLayout newLeftToRight
			positionOfSlider: 200;
			add: #controls;
			add: #roassalCanvas;
			yourself);
		yourself
]

{ #category : #'instance creation' }
SpLayoutStudio class >> open [
	<script>
	self new open
]

{ #category : #initialization }
SpLayoutStudio >> addAnimation: anRSCanvas [
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
SpLayoutStudio >> apply: aRSLayoutField with: anObject [
	oldPositions := nodes collect: [ :each | each position ].
	currentLayout perform: aRSLayoutField selector asMutator with: anObject.
	roassalCanvas refresh
]

{ #category : #public }
SpLayoutStudio >> currentLayout [
	^ currentLayout
]

{ #category : #public }
SpLayoutStudio >> currentLayout: aRSLayout [
	currentLayout := aRSLayout
]

{ #category : #public }
SpLayoutStudio >> edit: anAssociation [
	| class definition |
	class := anAssociation key.
	definition := anAssociation value.

	self
		currentLayout: class new;
		layoutDefinition: anAssociation value.
	controls := self instantiate: RSLayoutControls.
	controls layoutStudio: self.

	self withWindowDo: [ :window | self initializeWindow: window ].
	self update
]

{ #category : #public }
SpLayoutStudio >> editLayout: aRSLayoutClass [
	self edit: aRSLayoutClass -> aRSLayoutClass layoutDefinition
]

{ #category : #initialization }
SpLayoutStudio >> initializePresenters [
	menu := self mainMenu.
	menu addKeybindingsTo: self.
	controls := self newButton.
	roassalCanvas := self newRoassal.
	self editLayout: RSCircleLayout.
	roassalCanvas script: [ :canvas | self renderIn: canvas ]
]

{ #category : #initialization }
SpLayoutStudio >> initializeWindow: aWindow [
	| title |
	title := 'Layout Studio'.
	currentLayout ifNotNil: [ title := title, ' on:  ', currentLayout class name ].
	aWindow
		title: title;
		initialExtent: 800@500;
		centered
]

{ #category : #accessing }
SpLayoutStudio >> layoutDefinition [
	^ layoutDefinition
]

{ #category : #accessing }
SpLayoutStudio >> layoutDefinition: aRSLayoutDefinition [
	layoutDefinition := aRSLayoutDefinition
]

{ #category : #initialization }
SpLayoutStudio >> mainMenu [
	^ self newMenuBar
		addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'New Layout';
					icon: (self iconNamed: #open);
					action: [ self openLayout ] ] ];
		yourself
]

{ #category : #events }
SpLayoutStudio >> openLayout [
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
SpLayoutStudio >> renderIn: anRSCanvas [
	| canvas |
	canvas := currentLayout class canvasExample.
	canvas shapes inspect.
	anRSCanvas addAll: canvas shapes.

	nodes := anRSCanvas nodes.
	currentLayout on: nodes.
	anRSCanvas @ RSCanvasController.
	oldPositions ifNil: [ ^ self ].
	self addAnimation: anRSCanvas
]
