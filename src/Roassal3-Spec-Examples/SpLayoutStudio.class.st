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
		'currentLayout'
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

{ #category : #public }
SpLayoutStudio >> currentLayout [
	^ currentLayout
]

{ #category : #public }
SpLayoutStudio >> currentLayout: aRSLayout [
	currentLayout := aRSLayout
]

{ #category : #public }
SpLayoutStudio >> editLayout: aRSLayout [
	self currentLayout: aRSLayout.
	controls := self instantiate: RSLayoutControls.
	controls layoutStudio: self.
	self update
]

{ #category : #initialization }
SpLayoutStudio >> initializePresenters [
	menu := self mainMenu.
	menu addKeybindingsTo: self.
	controls := self newButton.
	roassalCanvas := self newRoassal
]

{ #category : #initialization }
SpLayoutStudio >> initializeWindow: aWindow [
	aWindow
		title: 'Layout Studio';
		initialExtent: 800@500;
		centered
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
		items: RSLayout withAllSubclasses;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		openModal.
	selection ifNotNil: [ self editLayout: selection new ]
]
