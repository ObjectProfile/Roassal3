"
I defined basic behaviors about popups in general, my subclasses needs to override:
*
*
"
Class {
	#name : 'RSAbstractPopupInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'modelBlock',
		'offset'
	],
	#category : 'Roassal-Interaction-Popup',
	#package : 'Roassal-Interaction',
	#tag : 'Popup'
}

{ #category : 'accessing' }
RSAbstractPopupInteraction class >> activationEvent [
	^ RSMouseMove
]

{ #category : 'accessing' }
RSAbstractPopupInteraction class >> removeEvents [
	^ { RSMouseClick. RSMouseEnter. RSMouseLeave. RSMouseDragging }
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> activePopupWith: evt [
	| popup |
	popup := self createOrGetPopupOn: evt shape event: evt.
	self translatePopup: popup event: evt.
	"popup translateBy: (offset rsValue: popup)."
	popup position: popup position + (offset rsValue: popup).
	evt signalUpdate
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> createOrGetPopupOn: aShape event: event [
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

{ #category : 'hooks' }
RSAbstractPopupInteraction >> createPopupFor: aShape event: event [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
RSAbstractPopupInteraction >> initialize [
	super initialize.
	self model: #model.

	"Offset to locate the popup"
	offset := 0 @ 0
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> makeLocateAboveMouseCursor [
	"Make the popup located above the mouse cursor.
```
c := RSCanvas new.
shapes := RSCircle models: (1 to: 5).
RSNormalizer size
	shapes: shapes;
	normalize.
RSNormalizer color
	shapes: shapes;
	normalize.
c addAll: shapes.
shapes @ (RSPopup new makeLocateAboveMouseCursor).
RSHorizontalLineLayout on: shapes.
c @ RSCanvasController
```
	"
	self offset: [ :s | 0 @ (s height negated - 5) ]
]

{ #category : 'accessing' }
RSAbstractPopupInteraction >> model [
	^ modelBlock
]

{ #category : 'accessing' }
RSAbstractPopupInteraction >> model: anObject [
	"
	- can be a one arg BlockClosure
	- can be a ByteString
	"
	modelBlock := anObject
]

{ #category : 'accessing' }
RSAbstractPopupInteraction >> modelFor: aRSShape [
	^ modelBlock rsValue: aRSShape
]

{ #category : 'accessing' }
RSAbstractPopupInteraction >> offset: anOffsetAsPointOrBlock [
	"Set the offset of the popup. The default behavior, is to have the popup at the location of the
	mouse. Which could be cumbersome if the default mouse cursor from the OS is large
	For example:
```
c := RSCanvas new.
shapes := RSCircle models: (1 to: 5).
RSNormalizer size
	shapes: shapes;
	normalize.
RSNormalizer color
	shapes: shapes;
	normalize.
c addAll: shapes.
shapes @ (RSPopup new offset: [ :s | 0 @ (s height negated - 5) ]).
RSHorizontalLineLayout on: shapes.
c @ RSCanvasController
```

	"
	offset := anOffsetAsPointOrBlock
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> onShape: aShape [
	aShape removeInteractionIfPresent: self class.

	self registerRemoveEventsOn: aShape.
	aShape
		when: self class activationEvent send: #activePopupWith: to: self
]

{ #category : 'accessing' }
RSAbstractPopupInteraction >> popupKey [
	^ #popup
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> registerRemoveEventsOn: aShape [
	self class removeEvents do: [ :clsEvent |
		aShape
			when: clsEvent
			do: [ :evt |
				self removePopupOn: evt ]
			for: self ]
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> releasePopup: popup [
	self subclassResponsibility
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> removePopupOn: evt [
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
	evt signalUpdate
]

{ #category : 'hooks' }
RSAbstractPopupInteraction >> translatePopup: popup event: evt [
	self subclassResponsibility
]
