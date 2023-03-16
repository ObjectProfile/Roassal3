"
Utility class to review roassal3 examples
"
Class {
	#name : #RSExamplesBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'leftButton',
		'roassalCanvas',
		'rightButton',
		'index',
		'examples',
		'codeEditor',
		'classesList',
		'selectedClass',
		'searchButton'
	],
	#category : #'Roassal3-Spec-Examples-Basic'
}

{ #category : #layout }
RSExamplesBrowser class >> defaultLayout [
	| const |
	const := [ :constraints |
		constraints expand: false;
		width: 20 ].
	^ SpBoxLayout newHorizontal
		add: #leftButton withConstraints: const;
		add: (SpPanedLayout newHorizontal
			add: (SpBoxLayout newVertical
				add: (SpBoxLayout newHorizontal
					add: #classesList;
					add: #searchButton withConstraints: [:c | c expand: false; width: 25];
					yourself) withConstraints: [:c | c expand: false; height: 25];
				add: #codeEditor;
				yourself);
			add: #roassalCanvas;
			yourself);
		add: #rightButton withConstraints: const;
		yourself
]

{ #category : #events }
RSExamplesBrowser >> classChanged: cls [
	selectedClass := cls.
	examples := self computeExamples.
	index := index < 0 ifTrue: [ examples size ] ifFalse: [ 1 ].
	self updateCanvas
]

{ #category : #private }
RSExamplesBrowser >> classes [
	^ (RSAbstractExamples withAllSubclasses select: [ :cls |
		cls methods anySatisfy: [ :met | met selector beginsWith: 'example' ] ])
	sorted: [ :a :b |
		| x y |
		x := a new order.
		y := b new order.
		x = y
			ifTrue: [ a name < b name ]
			ifFalse: [ x < y  ] ]
]

{ #category : #initialization }
RSExamplesBrowser >> compile: text [
	[
		(examples at: index) methodClass compile: text.

		self updateCanvas.

		codeEditor text: text.
		"for some reason after the compile process the code editor does not have the current text
		the previous code fixes that"
	] onErrorDo: [ :ex | ex traceCr ]
]

{ #category : #private }
RSExamplesBrowser >> computeExamples [
	selectedClass := self defaultClass.
	^ (selectedClass methods
		select: [ :met | met selector beginsWith: 'example' ]
		) asSortedCollection: [ :a :b | a selector < b selector ]
]

{ #category : #initialization }
RSExamplesBrowser >> connectPresenters [

	classesList	whenSelectedItemChangedDo: [ :cls | self classChanged: cls ].
	codeEditor whenSubmitDo: [ :text | self compile: text.  ].
	leftButton action: [ self shiftLeft ].
	rightButton action: [ self shiftRight ].
	searchButton action: [ self openSpotter ]
]

{ #category : #private }
RSExamplesBrowser >> defaultClass [
	^ selectedClass ifNil: [ self classes first ]
]

{ #category : #initialization }
RSExamplesBrowser >> initializePresenters [

	classesList := self newDropList
		help: 'Select the example to view';
		items: self classes;
		display: [ :cls | cls name ];
		displayIcon: [ :cls | cls iconNamed: cls systemIconName ];
		yourself.
	searchButton := self newButton
		icon: (self iconNamed: #glamorousSearch);
		help: 'Open spotter';
		yourself.

	leftButton := self newButton
		label: '<';
		yourself.

	roassalCanvas := self instantiate: SpRoassal3InspectorPresenter.

	codeEditor := self newCode
		withSyntaxHighlight;
		withScrollBars;
		yourself.

	rightButton := self newButton
		label: '>';
		yourself
]

{ #category : #initialization }
RSExamplesBrowser >> initializeWindow: window [
	window
		initialExtent: 800@500;
		title: (examples at: index) fullDisplayString
]

{ #category : #'accessing - computed' }
RSExamplesBrowser >> nextClass [
	| classes i |
	classes := classesList items.
	i := classesList selectedIndex.
	i := i + 1.
	i > classes size ifTrue: [ i := 1 ].
	^ classes at: i
]

{ #category : #events }
RSExamplesBrowser >> openSpotter [
	"TODO custom search in spotter to look for examples"
	StSpotter openWithText: 'Examples'
]

{ #category : #'accessing - computed' }
RSExamplesBrowser >> previousClass [
	| classes i |
	classes := classesList items.
	i := classesList selectedIndex.
	i := i - 1.
	i < 1 ifTrue: [ i := classes size ].
	^ classes at: i
]

{ #category : #running }
RSExamplesBrowser >> run [
	<script: 'self new open'>
]

{ #category : #events }
RSExamplesBrowser >> shiftLeft [
	index = 1 ifTrue: [
		index := -1.
		^ classesList selectItem: self previousClass.
	] ifFalse: [ index := index - 1 ].
	self updateCanvas
]

{ #category : #events }
RSExamplesBrowser >> shiftRight [
	index = examples size ifTrue: [
		^ classesList selectItem: self nextClass.
	] ifFalse: [ index := index + 1].
	self updateCanvas
]

{ #category : #updated }
RSExamplesBrowser >> updateCanvas [
	| current canvas |
	current := examples at: index.
	self withWindowDo: [ :window | self initializeWindow: window ].
	codeEditor text: current sourceCode.
	codeEditor beForBehavior: selectedClass.
	[
		canvas :=  current selector value: selectedClass new.
		canvas class = RSCanvas
			ifFalse: [ canvas := canvas build; canvas ].
		roassalCanvas canvas: canvas.
	] onErrorDo: [ :ex | ex traceCr ]
]

{ #category : #initialization }
RSExamplesBrowser >> updatePresenter [
	index := 1.
	self classChanged: self defaultClass
]
