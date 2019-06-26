"
I can add a popup on an element when a move over event occurs 
"
Class {
	#name : #RSPopup,
	#superclass : #RSInteraction,
	#instVars : [
		'shape',
		'label',
		'box'
	],
	#classInstVars : [
		'removeEvents'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #accessing }
RSPopup class >> activationEvent [
	^ TSMouseMove
]

{ #category : #accessing }
RSPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { TSMouseClick. TSMouseEnter. TSMouseLeave. TSMouseDragging } ]
]

{ #category : #'instance creation' }
RSPopup class >> reset [
	<script: 'self reset'>
	super reset.
	removeEvents := nil.
]

{ #category : #accessing }
RSPopup class >> text: anObject [
	| inst |
	inst := self new.
	inst label text: anObject.
	^ inst
]

{ #category : #accessing }
RSPopup >> box [
	^ box
]

{ #category : #hooks }
RSPopup >> createOrGetPopupOn: anElement event: event [
	| att popupElement view |
	att := anElement topParent view attributes.
	att at: #popup ifPresent: [ :popup | ^ popup ].
	popupElement := shape elementOn: anElement model.
	att at: #popup put: popupElement.
	popupElement isFixed: true.
	view := anElement topParent view.
	view add: popupElement.
	^ popupElement
	
]

{ #category : #initialization }
RSPopup >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
RSPopup >> initializeShape [
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		border: (TSBorder new color: Color gray);
		extent: [ :m | m extent + 5 ].
	shape := RSShapeBuilder composite shapes: [ :model | 
		| l b |
		l := label elementOn: model.
		l translateTo: 0@0.
		b := box elementOn: l.
		TSGroup with: b with: l ].
	
		
	
	
]

{ #category : #accessing }
RSPopup >> label [
	^ label
]

{ #category : #accessing }
RSPopup >> label: aShape [
	label := aShape
]

{ #category : #public }
RSPopup >> multiline [
	self label: RSShapeBuilder multiline
]

{ #category : #hooks }
RSPopup >> onElement: anElement [
	self registerRemoveEventsOn: anElement.
	anElement
		when: self class activationEvent do: [ :evt | | popup |
			popup := self createOrGetPopupOn: anElement event: evt.
			self translatePopup: popup event: evt.
			popup signalUpdate. ]

]

{ #category : #private }
RSPopup >> registerRemoveEventsOn: anElement [
	| remove |
	remove := [:evt | self removePopupOn: evt  ].
	self class removeEvents do: [ :cls | 
		anElement when: cls do: remove ]
]

{ #category : #hooks }
RSPopup >> removePopupOn: evt [ 
	| att popup view |
	"It may happen that the canvas is not set. This is the case when an element is not added to a view.
	If the element is not part of a view, then there is nothing to remove, so we exit early."
	evt canvas ifNil: [ ^ self ].
	
	view := evt canvas view.
	view ifNil: [ ^ self ].
	att := view attributes.
	(att includesKey: #popup) ifFalse: [ ^ self ].
	popup := att at: #popup.
	
	popup remove.
	att removeKey: #popup.
	evt signalUpdate.
]

{ #category : #accessing }
RSPopup >> shape [
	^ shape
]

{ #category : #accessing }
RSPopup >> shape: aShape [
	shape := aShape
]

{ #category : #hooks }
RSPopup >> translatePopup: popup event: evt [ 
	| p e |
	p := evt position.
	evt shape isFixed 
		ifFalse: [ p := evt canvas camera fromSpaceToPixel: p. ].
	
	e := (popup extent /2) + 5.
	p x +  popup extent x > popup view extent x ifTrue: [ 
		e := e x negated @ e y.
		p x - popup extent x < 0
		ifTrue: [ e := p x negated + (popup extent x /2) @ e y ].
		].
	popup translateTo: p + e.
]
