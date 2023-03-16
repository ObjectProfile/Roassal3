"
This example works with Spec1
"
Class {
	#name : #RSEaselExample,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'diagram',
		'label',
		'text',
		'button'
	],
	#category : #'Roassal3-Spec-Obsolete'
}

{ #category : #specs }
RSEaselExample class >> defaultSpec [ 
	<spec: #default>
	^ 	SpecLayout composed
		newColumn: [:tcol|
		tcol newRow: [:trow|
			trow newColumn: [:left |
				left
					add: #label height: self toolbarHeight;
					add: #text ;
					add: #button height: self toolbarHeight ] width: 400.
			trow add: #diagram]].
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
RSEaselExample >> initialExtent [

	^  800@500.
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

	diagram := self instantiate: Sp1RoassalPresenter.	
	"This is the code for the Roassal view.
	The block takes both a view and a canvas."
	diagram script: [ :canvas | self textAsCode value: canvas ]
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
'box := RSBox new
	size: 100;
	draggable;
	yourself.
canvas add: box.
canvas addInteraction: RSCanvasController.
canvas.
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
		source: '[:canvas | ' , self text text asString , ']';
		logged: false;
		evaluate
]

{ #category : #initialization }
RSEaselExample >> title [
	"Return the window's title"

	^ 'Roassal3 Spec'
]
