"
I am a basic spec example. You can edit a script with roassal then this will be updated on the view
"
Class {
	#name : #RSEaselExample,
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
RSEaselExample class >> defaultSpec [ 
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
RSEaselExample class >> open [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
RSEaselExample >> button [
	^ button
]

{ #category : #accessing }
RSEaselExample >> button: anObject [
	button := anObject
]

{ #category : #accessing }
RSEaselExample >> diagram [
	^ diagram
]

{ #category : #accessing }
RSEaselExample >> diagram: anObject [
	diagram := anObject
]

{ #category : #initialization }
RSEaselExample >> initializePresenter [

	"This causes the diagram's script to be executed again."
	button action: [ diagram refresh ]
]

{ #category : #initialization }
RSEaselExample >> initializeWidgets [

	label := self newLabel.
	label label: 'Enter code below. Both view and canvas are accessible' .

	text := self newCode.
	text text: self startText.
	text autoAccept: true.
	
	button := self newButton.
	button label: 'Draw this!'.

	diagram := self instantiate: SpRoassalPresenter.	
	"This is the code for the Roassal view.
	The block takes both a view and a canvas."
	diagram script: [ :view | self textAsCode value: view ]
]

{ #category : #initialization }
RSEaselExample >> initializeWindow: w [
	w 
		title: 'Roassal3 Spec';
		initialExtent: 800@500.
]

{ #category : #accessing }
RSEaselExample >> label [
	^ label
]

{ #category : #accessing }
RSEaselExample >> label: anObject [
	label := anObject
]

{ #category : #dependencies }
RSEaselExample >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #running }
RSEaselExample >> run [
	<script: 'self new openWithSpec'>
]

{ #category : #initialization }
RSEaselExample >> startText [
	^
'box := RSShapeBuilder box
	size: 100;
	draggable.
element := box element.
view add: element.
view @ RSControlsView.
'  asText
]

{ #category : #accessing }
RSEaselExample >> text [
	^ text
]

{ #category : #accessing }
RSEaselExample >> text: anObject [
	text := anObject
]

{ #category : #accessing }
RSEaselExample >> textAsCode [
	"This could be made more clever with regard to compilation and runtime errors. But for this simple example it should suffice."

	^ OpalCompiler new
		source: '[:view | ' , self text text asString , ']';
		logged: false;
		evaluate
]
