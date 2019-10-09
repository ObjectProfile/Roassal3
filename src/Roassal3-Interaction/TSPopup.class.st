"
I can add a popup on an element when a move over event occurs 
"
Class {
	#name : #TSPopup,
	#superclass : #TSInteraction,
	#instVars : [
		'shape',
		'label',
		'box'
	],
	#classInstVars : [
		'removeEvents'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
TSPopup class >> activationEvent [
	^ TSMouseMove
]

{ #category : #accessing }
TSPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { TSMouseClick. TSMouseEnter. TSMouseLeave. TSMouseDragging } ]
]

{ #category : #'instance creation' }
TSPopup class >> reset [
	<script: 'self reset'>
	super reset.
	removeEvents := nil.
]

{ #category : #accessing }
TSPopup class >> text: anObject [
	| inst |
	inst := self new.
	inst label text: anObject.
	^ inst
]

{ #category : #accessing }
TSPopup class >> wantsUniqueInstance [ 
	^ true
]

{ #category : #accessing }
TSPopup >> box [
	^ box
]

{ #category : #hooks }
TSPopup >> createOrGetPopupOn: aShape event: event [
	| att popupShape canvas |
	att := event canvas attributes.
	att at: #popup ifPresent: [ :popup | ^ popup ].
	popupShape := (shape elementOn: aShape model) shape.
	att at: #popup put: popupShape.
	popupShape isFixed: true.
	canvas := aShape canvas.
	canvas addShape: popupShape.
	^ popupShape
	
]

{ #category : #initialization }
TSPopup >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
TSPopup >> initializeShape [
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
TSPopup >> label [
	^ label
]

{ #category : #accessing }
TSPopup >> label: aShape [
	label := aShape
]

{ #category : #public }
TSPopup >> multiline [
	self label: RSShapeBuilder multiline
]

{ #category : #hooks }
TSPopup >> onShape: aShape [
	self registerRemoveEventsOn: aShape.
	aShape
		when: self class activationEvent do: [ :evt | | popup |
			popup := self createOrGetPopupOn: aShape event: evt.
			self translatePopup: popup event: evt.
			popup signalUpdate. ]

]

{ #category : #private }
TSPopup >> registerRemoveEventsOn: anElement [
	| remove |
	remove := [:evt | self removePopupOn: evt  ].
	self class removeEvents do: [ :cls | 
		anElement when: cls do: remove ]
]

{ #category : #hooks }
TSPopup >> removePopupOn: evt [ 
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
TSPopup >> shape [
	^ shape
]

{ #category : #accessing }
TSPopup >> shape: aShape [
	shape := aShape
]

{ #category : #hooks }
TSPopup >> translatePopup: popup event: evt [ 
	| p e extent |
	p := evt position.
	evt shape isFixed 
		ifFalse: [ p := evt canvas camera fromSpaceToPixel: p. ].
	extent := popup canvas extent.
	e := (popup extent /2) + 5.
	p x + popup width > extent x ifTrue: [ 
		e := e x negated @ e y.
		p x - popup width < 0
		ifTrue: [ e := p x negated + (popup width/2 + 4) @ e y ].
		].
	p y + popup height > extent y ifTrue: [ 
		e := e x @ e y negated.
		p y - popup height < 0
		ifTrue: [ e := e x @ ( p y negated + (popup height/2 + 4) ) ]
		]. 
	popup translateTo: p + e.
]
