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
		'selectedClass',
		'classesList'
	],
	#category : #'Roassal3-Spec-Examples'
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
			add: (SpBoxLayout newTopToBottom
				add: #classesList withConstraints: [:c | c expand: false; height: 25];
				add: #codeEditor;
				yourself);
			add: #roassalCanvas;
			yourself);
		add: #rightButton withConstraints: const;
		yourself
		
]

{ #category : #updated }
RSExamplesBrowser >> classChanged: cls [
	selectedClass := cls.
	index := 1.
	examples := self computeExamples.
	self updateCanvas.
	
]

{ #category : #private }
RSExamplesBrowser >> classes [
	^ RSAbstractExamples withAllSubclasses select: [ :cls | 
		cls methods anySatisfy: [ :met | 
			met selector beginsWith: 'example' ] ].
]

{ #category : #private }
RSExamplesBrowser >> computeExamples [
	selectedClass := self defaultClass.
	^ (selectedClass methods
		select: [ :met | met selector beginsWith: 'example' ]
		) asSortedCollection: [ :a :b |
		a protocol = b protocol 
			ifTrue: [ a selector < b selector ]
			ifFalse: [ a protocol < b protocol ]
		 ].
]

{ #category : #private }
RSExamplesBrowser >> defaultClass [
	^ selectedClass ifNil: [ self classes first ].
	
]

{ #category : #'initialization - deprecated' }
RSExamplesBrowser >> initializePresenter [

	classesList := self newDropList.
	classesList
		help: 'Select the example to view';
		items: self classes;
		display: [ :cls | cls name ];
		displayIcon: [ :cls | cls systemIcon ];
		whenSelectedItemChangedDo: [ :cls | self classChanged: cls  ].

	examples := self computeExamples.
	index := 1.
	leftButton := self newButton.
	leftButton label: '<'.
	leftButton action: [ self shiftLeft ].
	roassalCanvas := self instantiate: SpRoassalPresenter.
	codeEditor := self newCode
		              withSyntaxHighlight;
		              withScrollBars;
		              yourself.
	rightButton := self newButton.
	rightButton label: '>'.
	rightButton action: [ self shiftRight ].
	self updateCanvas
]

{ #category : #initialization }
RSExamplesBrowser >> initializeWindow: window [
	window title: (examples at: index) selector.
]

{ #category : #running }
RSExamplesBrowser >> run [
	<script: 'self new open'>
]

{ #category : #updated }
RSExamplesBrowser >> shiftLeft [
	index = 1 ifTrue: [ ^ self ].
	index := index - 1.
	self updateCanvas.
]

{ #category : #updated }
RSExamplesBrowser >> shiftRight [
	index = examples size ifTrue: [ ^ self ].
	index := index + 1.
	self updateCanvas.
]

{ #category : #updated }
RSExamplesBrowser >> updateCanvas [
	| current canvas |
	current := examples at: index.
	self withWindowDo: [ :window | self initializeWindow: window ].
	codeEditor text: current sourceCode.
	codeEditor behavior: selectedClass.
	[
		canvas :=  current selector value: selectedClass new.
		canvas class = RSCanvas ifFalse: [ 
			canvas := canvas build; canvas
			 ].
		roassalCanvas currentCanvas 
			ifNil: [ roassalCanvas canvas: canvas ]
			ifNotNil: [ :aCanvas | 
				| widget |
				widget := aCanvas morph.
				widget canvas: canvas.
				canvas morph: widget.
				canvas extent: widget extent.
				canvas signalUpdate.
				].
	] onErrorDo: [ :ex | ex traceCr ]	
		
]
