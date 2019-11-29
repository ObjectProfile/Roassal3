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
	^ RSMouseMove
]

{ #category : #accessing }
RSAbstractPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { RSMouseClick. RSMouseEnter. RSMouseLeave. RSMouseDragging } ]
]

{ #category : #'instance creation' }
RSAbstractPopup class >> reset [
	<script: 'self reset'>
	super reset.
	removeEvents := nil.
]

{ #category : #hooks }
RSAbstractPopup >> createOrGetPopupOn: aShape event: event [
	| att popupShape key |
	att := event canvas attributes.
	key := self popupKey.
	att at: key ifPresent: [ :popup | ^ popup ].
	popupShape := self createPopupFor: aShape event: event.
	att at: key put: popupShape.
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
			popup := self createOrGetPopupOn: aShape event: evt.
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
			do: [:evt | self removePopupOn: evt  ] ]
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
	att := evt canvas attributes.
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
