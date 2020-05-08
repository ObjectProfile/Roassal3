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

{ #category : #accessing }
RSEasel >> button [
	^ button
]

{ #category : #accessing }
RSEasel >> button: anObject [
	button := anObject
]

{ #category : #initialization }
RSEasel >> configure: canvas [
	canvas @ RSCanvasController.
	canvas color: (Smalltalk ui theme backgroundColor).
]

{ #category : #accessing }
RSEasel >> diagram [
	^ diagram
]

{ #category : #accessing }
RSEasel >> diagram: anObject [
	diagram := anObject
]

{ #category : #initialization }
RSEasel >> initializePresenter [

	"This causes the diagram's script to be executed again."
	button action: [ diagram refresh ]
]

{ #category : #initialization }
RSEasel >> initializeWidgets [

	label := self newLabel.
	label label: 'Enter code below. Both view and canvas are accessible'.
	text := self newCode.
	text text: self startText.
	text autoAccept: true.
	
	button := self newButton.
	button label: 'Draw this!'.

	diagram := self instantiate: SpRoassalPresenter.	
	"This is the code for the Roassal view.
	The block takes both a view and a canvas."
	diagram script: [ :canvas | | t |
		self configure: canvas.
		t := self textAsCode ]
]

{ #category : #initialization }
RSEasel >> initializeWindow: w [
	w 
		title: 'Roassal3 Spec';
		initialExtent: 800@500.
]

{ #category : #accessing }
RSEasel >> label [
	^ label
]

{ #category : #accessing }
RSEasel >> label: anObject [
	label := anObject
]

{ #category : #dependencies }
RSEasel >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #running }
RSEasel >> run [
	<script: 'self new openWithSpec'>
]

{ #category : #initialization }
RSEasel >> startText [
	^
'"[:canvas | ]"
box := RSBox new
	size: 100;
	draggable;
	yourself.
canvas add: box.
canvas.
'  asText
]

{ #category : #accessing }
RSEasel >> text [
	^ text
]

{ #category : #accessing }
RSEasel >> text: anObject [
	text := anObject
]

{ #category : #accessing }
RSEasel >> textAsCode [
	"This could be made more clever with regard to compilation and runtime errors. But for this simple example it should suffice."

	^ OpalCompiler new
		source: '[:canvas | ' , self text text asString , ']';
		logged: false;
		evaluate
]
