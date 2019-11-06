"
I can add a popup on an element when a move over event occurs 
"
Class {
	#name : #TSPopup,
	#superclass : #TSInteraction,
	#instVars : [
		'shapeBuilder'
	],
	#classInstVars : [
		'removeEvents'
	],
	#category : #'Roassal3-Interaction-Popup'
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
	inst shapeBuilder textBlock: anObject.
	^ inst
]

{ #category : #hooks }
TSPopup >> createOrGetPopupOn: aShape event: event [
	| att popupShape canvas |
	att := event canvas attributes.
	att at: #popup ifPresent: [ :popup | ^ popup ].
	popupShape := shapeBuilder shapeOn: aShape model.
	"popupShape :=(shape elementOn: aShape model) shape."
	att at: #popup put: popupShape.
	popupShape isFixed: true.
	canvas := aShape canvas.
	canvas addShape: popupShape.
	^ popupShape
	
]

{ #category : #initialization }
TSPopup >> initialize [
	super initialize.
	shapeBuilder := TSSimplePopup new.
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
TSPopup >> registerRemoveEventsOn: aShape [
	| remove |
	remove := [:evt | self removePopupOn: evt  ].
	self class removeEvents do: [ :cls | 
		aShape when: cls do: remove ]
]

{ #category : #hooks }
TSPopup >> removePopupOn: evt [ 
	| att popup |
	"It may happen that the canvas is not set. This is the case when an element is not added to a view.
	If the element is not part of a view, then there is nothing to remove, so we exit early."
	evt canvas ifNil: [ ^ self ].
	att := evt canvas attributes.
	(att includesKey: #popup) ifFalse: [ ^ self ].
	popup := att at: #popup.
	popup remove.
	att removeKey: #popup.
	evt signalUpdate.
]

{ #category : #accessing }
TSPopup >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #accessing }
TSPopup >> shapeBuilder: aShapeBuilder [
	shapeBuilder := aShapeBuilder
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
