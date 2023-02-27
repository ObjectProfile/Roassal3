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
		'oldPositions'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #layout }
RSLayoutStudio class >> defaultLayout [
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
RSLayoutStudio class >> open [
	<script>
	self new open
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

{ #category : #public }
RSLayoutStudio >> currentLayout [
	^ currentLayout
]

{ #category : #public }
RSLayoutStudio >> currentLayout: aRSLayout [
	currentLayout := aRSLayout
]

{ #category : #public }
RSLayoutStudio >> edit: anAssociation [
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
RSLayoutStudio >> editLayout: aRSLayoutClass [
	self edit: aRSLayoutClass -> aRSLayoutClass layoutDefinition
]

{ #category : #initialization }
RSLayoutStudio >> initializePresenters [
	menu := self mainMenu.
	menu addKeybindingsTo: self.
	controls := self newButton.
	roassalCanvas := self newRoassal.
	self editLayout: RSCircleLayout.
	roassalCanvas script: [ :canvas | self renderIn: canvas ]
]

{ #category : #initialization }
RSLayoutStudio >> initializeWindow: aWindow [
	| title |
	title := 'Layout Studio'.
	currentLayout ifNotNil: [ title := title, ' on:  ', currentLayout class name ].
	aWindow
		title: title;
		initialExtent: 800@500;
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
					name: 'New Layout';
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
RSLayoutStudio >> renderIn: anRSCanvas [
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
