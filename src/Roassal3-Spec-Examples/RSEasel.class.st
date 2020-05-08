"
I am a basic spec example. You can edit a script with roassal then this will be updated on the view
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
	#category : #'Roassal3-Spec-Examples'
}

{ #category : #specs }
RSEasel class >> defaultSpec [ 
	<spec: #default>
	^ SpPanedLayout newHorizontal 
		position: 35 percent;
		add: (SpBoxLayout newVertical
			add: #label withConstraints: [ :c | c height: self toolbarHeight ];
			add: #text;
			add: #button withConstraints: [ :c | c height: self toolbarHeight ]
			);
		add: #diagram ;
		yourself
]

{ #category : #specs }
RSEasel class >> open [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
RSEasel >> configure: canvas [
	canvas @ RSCanvasController.
	canvas color: self theme backgroundColor.
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
'"[:canvas | ]"
box := RSBox new
	size: 100;
	draggable;
	yourself.
canvas add: box.
'
]

{ #category : #initialization }
RSEasel >> initializePresenters [
	label := self newLabel.
	text := self newCode.
	button := self newButton.
	diagram := self instantiate: SpRoassalPresenter
]

{ #category : #initialization }
RSEasel >> initializeWindow: w [
	w 
		title: 'Roassal3 Spec';
		initialExtent: 800@500.
]

{ #category : #dependencies }
RSEasel >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #running }
RSEasel >> run [
	<script: 'self new openWithSpec'>
]

{ #category : #accessing }
RSEasel >> textAsBlockClosure [
	"This could be made more clever with regard to compilation and runtime errors. But for this simple example it should suffice."

	^ self class compiler
		source: '[:canvas | ' , text text asString , ']';
		logged: false;
		evaluate
]
