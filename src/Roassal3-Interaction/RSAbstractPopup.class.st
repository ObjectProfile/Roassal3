"
I defined basic behaviors about popups in general, my subclasses needs to override:
*
*
"
Class {
	#name : #RSAbstractPopup,
	#superclass : #RSInteraction,
	#classVars : [
		'removeEvents'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSAbstractPopup class >> activationEvent [
	^ RSMouseMoveEvent
]

{ #category : #accessing }
RSAbstractPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { RSMouseClickEvent. RSMouseEnterEvent. RSMouseLeaveEvent. RSMouseDraggingEvent } ]
]

{ #category : #'instance creation' }
RSAbstractPopup class >> reset [
	<script: 'self reset'>
	super reset.
	removeEvents := nil.
]

{ #category : #hooks }
RSAbstractPopup >> createOrGetPopupOn: aShape event: event [
	"Create a popup and register it"
	| prop popupShape key |
	prop := event canvas properties.
	key := self popupKey.

	"We checked if the very same shape has emitted the popup.
	If this is the case, then we use the popup previously created, 
	else, we remove it"
	((prop includesKey: key) and: [ (prop includesKey: #shapeWithPopup) ])
		ifTrue: [ | popup |
			popup := prop at: key.
			(prop at: #shapeWithPopup) == aShape
				ifTrue: [ ^ popup ]
				ifFalse: [ self releasePopup: popup ] ].

	popupShape := self createPopupFor: aShape event: event.
	prop at: key put: popupShape.
	prop at: #shapeWithPopup put: aShape.
	^ popupShape
	
]

{ #category : #hooks }
RSAbstractPopup >> createPopupFor: aShape event: event [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractPopup >> onShape: aShape [
	aShape removeInteractionIfPresent: self class.
	
	self registerRemoveEventsOn: aShape.
	aShape
		when: self class activationEvent do: [ :evt | | popup |
			popup := self createOrGetPopupOn: evt shape event: evt.
			self translatePopup: popup event: evt.
			evt signalUpdate. ]

]

{ #category : #accessing }
RSAbstractPopup >> popupKey [
	^ #popup
]

{ #category : #hooks }
RSAbstractPopup >> registerRemoveEventsOn: aShape [
	self class removeEvents do: [ :clsEvent | 
		aShape 
			when: clsEvent
			do: [ :evt | self removePopupOn: evt  ] ]
]

{ #category : #hooks }
RSAbstractPopup >> releasePopup: popup [
	self subclassResponsibility
]

{ #category : #hooks }
RSAbstractPopup >> removePopupOn: evt [
	| att popup key |
	"It may happen that the canvas is not set. This is the case when an element is not added to a view.
	If the element is not part of a view, then there is nothing to remove, so we exit early."
	evt canvas ifNil: [ ^ self ].
	att := evt canvas properties.
	key := self popupKey.
	(att includesKey: key) ifFalse: [ ^ self ].
	popup := att at: key.
	self releasePopup: popup.
	att removeKey: key.
	evt signalUpdate.
]

{ #category : #hooks }
RSAbstractPopup >> translatePopup: popup event: evt [
	self subclassResponsibility
]
