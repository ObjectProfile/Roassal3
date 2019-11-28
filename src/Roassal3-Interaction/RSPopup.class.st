"
I can add a popup on an element when a move over event occurs.

Here is an example:
-=-=-=-=
c := RSCanvas new.

classes := RSObject withAllSubclasses.

scale := TSScale linear
	domain: { (classes collect: #numberOfMethods) min . (classes collect: #numberOfMethods) max};
	range: { 'red'. 'blue' }.

classes do: [ :cls |
	| b |
	b := RSEllipse new.
	b size: cls numberOfMethods.
	b color: (scale scale: cls numberOfMethods).
	b model: cls.
	b @ RSPopup.
	c add: b ].

RSFlowLayout on: c shapes.

c @ RSControlsCanvas
-=-=-=-=
"
Class {
	#name : #RSPopup,
	#superclass : #RSInteraction,
	#instVars : [
		'shapeBuilder'
	],
	#classInstVars : [
		'removeEvents'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSPopup class >> activationEvent [
	^ RSMouseMove
]

{ #category : #accessing }
RSPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { RSMouseClick. RSMouseEnter. RSMouseLeave. RSMouseDragging } ]
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
	inst shapeBuilder textBlock: anObject.
	^ inst
]

{ #category : #hooks }
RSPopup >> createOrGetPopupOn: aShape event: event [
	| att popupShape canvas |
	att := event canvas attributes.
	att at: #popup ifPresent: [ :popup | ^ popup ].
	popupShape := shapeBuilder shapeFor: aShape model.
	att at: #popup put: popupShape.
	popupShape isFixed: true.
	canvas := aShape canvas.
	canvas addShape: popupShape.
	^ popupShape
	
]

{ #category : #initialization }
RSPopup >> initialize [
	super initialize.
	shapeBuilder := RSSimplePopupBuilder new.
]

{ #category : #hooks }
RSPopup >> onShape: aShape [
	self registerRemoveEventsOn: aShape.
	aShape
		when: self class activationEvent do: [ :evt | | popup |
			popup := self createOrGetPopupOn: aShape event: evt.
			self translatePopup: popup event: evt.
			evt signalUpdate. ]

]

{ #category : #private }
RSPopup >> registerRemoveEventsOn: aShape [
	| remove |
	remove := [:evt | self removePopupOn: evt  ].
	self class removeEvents do: [ :cls | 
		aShape when: cls do: remove ]
]

{ #category : #hooks }
RSPopup >> removePopupOn: evt [ 
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
RSPopup >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #accessing }
RSPopup >> shapeBuilder: aShapeBuilder [
	shapeBuilder := aShapeBuilder
]

{ #category : #hooks }
RSPopup >> translatePopup: popup event: evt [ 
	| p e extent |
	p := evt position.
	evt shape isFixed 
		ifFalse: [ p := evt camera fromSpaceToPixel: p. ].
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
