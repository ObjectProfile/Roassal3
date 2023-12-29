"
Basic layout studio to interact with layout and all subclasses
"
Class {
	#name : 'RSLayoutStudio',
	#superclass : 'RSAbstractLayoutPresenter',
	#instVars : [
		'menu',
		'nodes',
		'oldPositions'
	],
	#category : 'Roassal-LayoutStudio-Core',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Core'
}

{ #category : 'layout' }
RSLayoutStudio class >> defaultLayout [
	^ SpPanedLayout newLeftToRight
		positionOfSlider: 280;
		add: (SpBoxLayout newVertical
			add: #menu expand: false;
			add: #controls;
			yourself);
		add: #roassalCanvas;
		yourself
]

{ #category : 'opening' }
RSLayoutStudio class >> open [
	<script>
	self new open
]

{ #category : 'rendering' }
RSLayoutStudio class >> renderGraphIn: anRSCanvas [
	RSLayout canvasExampleIn: anRSCanvas
]

{ #category : 'animation' }
RSLayoutStudio >> addAnimation: anRSCanvas [
	| newPositions |
	newPositions := nodes collect: [ :each | each position ].
	anRSCanvas newAnimation
		duration: 1 second;
		easing: RSEasingInterpolator backOut;
		when: RSAnimationEndEvent do: [ oldPositions := nil ] for: self;
		onStepDo: [ :t |
			nodes doWithIndex: [ :each :index | | old new |
				old := oldPositions at: index.
				new := newPositions at: index.
				each translateTo: (old interpolateTo: new at: t) ].
			anRSCanvas zoomToFit.
			anRSCanvas signalUpdate.
			 ]
]

{ #category : 'public' }
RSLayoutStudio >> apply: aRSLayoutField with: anObject [
	self saveNodesPosition.
	currentLayout perform: aRSLayoutField selector asMutator with: anObject.
	self refresh
]

{ #category : 'accessing - computed' }
RSLayoutStudio >> canvasController [
	^ RSCanvasController new
]

{ #category : 'initialization' }
RSLayoutStudio >> connectPresenters [
	| initialLayout |
	initialLayout := RSCircleLayout.
	graphTextEditor text: self defaultGraphText.
	self edit: initialLayout -> initialLayout layoutDefinition.
	roassalCanvas script: [ :canvas | self renderIn: canvas ]
]

{ #category : 'public' }
RSLayoutStudio >> createBoxLayout [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newVertical
			add: 'Graph editor' expand: false;
			add: graphTextEditor withConstraints: [ :c |
				c expand: false; height: 200];
			yourself
			) expand: false;
		spacing: 10;
		add: self attributes;
		yourself
]

{ #category : 'defaults' }
RSLayoutStudio >> defaultGraphText [
	^ '"canvas is an instance of RSCanvas use it to render a graph"
RSLayoutStudio renderGraphIn: canvas'
]

{ #category : 'public' }
RSLayoutStudio >> edit: anAssociation [
	self saveNodesPosition.
	super edit: anAssociation
]

{ #category : 'public' }
RSLayoutStudio >> generateCodeAndOpenIt [
	^ StPlayground openContents: self generateStringCode
]

{ #category : 'printing' }
RSLayoutStudio >> generateStringCode [
	^ layoutDefinition generateStringCode
]

{ #category : 'initialization' }
RSLayoutStudio >> initializePresenters [
	menu := self mainMenu.
	menu addKeybindingsTo: self.
	controls := self newButton.
	graphTextEditor := self newCode.
	roassalCanvas := self newRoassal
]

{ #category : 'initialization' }
RSLayoutStudio >> initializeWindow: aWindow [
	| title |
	title := 'Layout Studio'.
	currentLayout ifNotNil: [ title := title, ' on:  ', currentLayout class name ].
	aWindow
		title: title;
		initialExtent: 900@600;
		centered
]

{ #category : 'accessing - computed' }
RSLayoutStudio >> mainMenu [
	^ self newMenuBar
		addGroup: [ :group |
			group addItem: [ :item |
				item
					name: 'Change Layout';
					icon: (self iconNamed: #open);
					action: [ self changeLayout ] ].
			group addItem: [ :item |
				item
					icon: (self iconNamed: #smallSystemBrowser);
					action: [ currentLayout class browse ];
					name: 'Browse' ].
			group addItem: [ :item |
				item
					icon: (self iconNamed: #scriptManager);
					action: [ self generateCodeAndOpenIt ];
					help: 'Generates code with the current layout';
					name: 'Generate' ] ];
		yourself
]

{ #category : 'accessing' }
RSLayoutStudio >> menu [
	^ menu
]

{ #category : 'rendering' }
RSLayoutStudio >> renderGraphIn: anRSCanvas [
	"this method will render a graph in a canvas using the source text code editor"
	self textAsBlockClosure value: anRSCanvas
]

{ #category : 'rendering' }
RSLayoutStudio >> renderIn: anRSCanvas [
	self renderGraphIn: anRSCanvas.
	nodes := anRSCanvas nodes.
	currentLayout on: nodes.
	anRSCanvas @ self canvasController.
	oldPositions ifNil: [ ^ self ].
	self addAnimation: anRSCanvas
]

{ #category : 'public' }
RSLayoutStudio >> saveNodesPosition [
	nodes ifNil: [ ^self ].
	oldPositions := nodes collect: [ :each | each position ]
]

{ #category : 'accessing - computed' }
RSLayoutStudio >> textAsBlockClosure [
	^ self class compiler
		source: '[:canvas | ' , graphTextEditor text asString , ']';
		logged: false;
		evaluate
]

{ #category : 'public' }
RSLayoutStudio >> titlePrefix [
	^ 'Layout Studio on: '
]
