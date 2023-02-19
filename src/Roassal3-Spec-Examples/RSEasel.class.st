"
I am a basic spec example of how to build a roassal visualization with spec.
Use the text editor with some roassal code, then click on draw! This will be updated on the canvas view.

Please check my methods:
- `RSEasel class >> #defaultLayout`, where the skeleton of the ui is defined.
- `RSEasel >> #initializePresenters`, where where the text editor, and the roassal diagram is defined
- `RSEasel >> #connectPresenters`, the main logic of the program, and how to draw and redraw things in roassal

"
Class {
	#name : #RSEasel,
	#superclass : #SpPresenter,
	#instVars : [
		'diagram',
		'label',
		'text',
		'button'
	],
	#category : #'Roassal3-Spec-Examples-Basic'
}

{ #category : #layout }
RSEasel class >> defaultLayout [

	<spec: #default>
	^ SpPanedLayout newHorizontal
		  positionOfSlider: 45 percent;
		  add: (SpBoxLayout newVertical
				   add: #label
				   withConstraints: [ :c | c height: self toolbarHeight ];
				   add: #text;
				   add: #button
				   withConstraints: [ :c | c height: self toolbarHeight ]);
		  add: #diagram;
		  yourself
]

{ #category : #specs }
RSEasel class >> open [
	<script>
	self new open
]

{ #category : #initialization }
RSEasel >> configure: canvas [
	canvas @ RSCanvasController.
	canvas color: self theme backgroundColor
]

{ #category : #initialization }
RSEasel >> connectPresenters [

	label
		label: 'Enter code below. Both view and canvas are accessible'.

	text
		text: self initialCode;
		autoAccept: true.

	button
		label: 'Draw this!';
		"this will update the canvas view with the current value of the text editor"
		action: [ diagram refresh ].

	"This is the code for the Roassal view.
	The block takes both a view and a canvas."
	diagram script: [ :canvas |
		self configure: canvas.
		self textAsBlockClosure value: canvas ]
]

{ #category : #initialization }
RSEasel >> initialCode [
	^
'"[:canvas | ...your code... ]"
| box icon label |
box := RSBox new
	size: 100;
	draggable;
	yourself.
icon := RSBitmap new
	form: (self iconNamed: #pharo);
	yourself.
label := RSLabel new
	color: ''black'';
	text: ''Kaguya'';
	yourself.
canvas addAll: {icon. box. label}.
RSVerticalLineLayout new
	alignCenter;
	on: canvas shapes.
'
]

{ #category : #initialization }
RSEasel >> initializePresenters [
	label := self newLabel.
	text := self newCode.
	button := self newButton.
	diagram := self newRoassal
]

{ #category : #initialization }
RSEasel >> initializeWindow: w [
	w
		title: 'Roassal3 Spec';
		initialExtent: 800@500
]

{ #category : #dependencies }
RSEasel >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #running }
RSEasel >> run [
	<script: 'self new asWindow open'>
]

{ #category : #accessing }
RSEasel >> textAsBlockClosure [
	"This could be made more clever with regard to compilation and runtime errors. But for this simple example it should suffice."

	^ self class compiler
		source: '[:canvas | ' , text text asString , ']';
		logged: false;
		evaluate
]
