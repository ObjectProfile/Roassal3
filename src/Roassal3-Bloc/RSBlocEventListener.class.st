Class {
	#name : #RSBlocEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal3-Bloc-Events'
}

{ #category : #'instance creation' }
RSBlocEventListener class >> newForCanvas: aRSHost [ 
	
	^ self basicNew
		initializeForCanvas: aRSHost;
		yourself
]

{ #category : #private }
RSBlocEventListener >> announceEventOfClass: aRSEventClass actionClass: anActionClass from: aBlEvent [

	| targetShape aRSEvent |
	targetShape := aBlEvent target roassalShape.

	((targetShape handleAnnouncementClass: anActionClass) or: [
		(targetShape handleAnnouncementClass: aRSEventClass)]) ifFalse:[ 
		targetShape := roassalCanvas.
		 ].

	aBlEvent consumed: true.
	aRSEvent := aRSEventClass newFromBlEvent: aBlEvent canvas: roassalCanvas.
	aRSEvent shape: targetShape.
	targetShape announce: aRSEvent
]

{ #category : #private }
RSBlocEventListener >> announceEventOfClass: aRSEventClass from: aBlEvent [

	self
		announceEventOfClass: aRSEventClass
		actionClass: aRSEventClass
		from: aBlEvent
]

{ #category : #private }
RSBlocEventListener >> announceMouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aBlClickEvent [
	"Translate a Bloc click event to a Roassal click event."

	| roassalEventClass |
	roassalEventClass := defaultClass.
	aBlClickEvent primaryButtonPressed ifTrue: [ 
		roassalEventClass := leftButtonClass ].
	aBlClickEvent secondaryButtonPressed ifTrue: [ 
		roassalEventClass := rightButtonClass ].

	self
		announceEventOfClass: roassalEventClass
		actionClass: defaultClass
		from: aBlClickEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> clickEvent: aBlEvent [

	self 
		announceMouseEventOfClass: RSMouseClick
		ifLeftButton: RSMouseLeftClick
		ifRightButton: RSMouseRightClick
		from: aBlEvent

]

{ #category : #'mouse handlers' }
RSBlocEventListener >> doubleClickEvent: aBlEvent [

	self
		announceMouseEventOfClass: RSMouseDoubleClick
		ifLeftButton: RSMouseDoubleLeftClick
		ifRightButton: RSMouseDoubleRightClick
		from: aBlEvent
]

{ #category : #'dnd handlers' }
RSBlocEventListener >> dragEndEvent: aBlEvent [
	self announceEventOfClass: RSMouseDragEnd from: aBlEvent
]

{ #category : #'dnd handlers' }
RSBlocEventListener >> dragEvent: aBlEvent [
	self announceEventOfClass: RSMouseDragging from: aBlEvent
]

{ #category : #'dnd handlers' }
RSBlocEventListener >> dragStartEvent: aBlEvent [
	self
		announceMouseEventOfClass: RSMouseDragStart 
		ifLeftButton: RSMouseLeftDragStart 
		ifRightButton: RSMouseRightDragStart
		from: aBlEvent
]

{ #category : #initialization }
RSBlocEventListener >> initializeForCanvas: aRSCanvas [ 
	
	self initialize.
	roassalCanvas := aRSCanvas.

]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseEnterEvent: aBlEvent [

	self announceEventOfClass: RSMouseEnter from: aBlEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseLeaveEvent: aBlEvent [

	self announceEventOfClass: RSMouseLeave from: aBlEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseMoveEvent: aBlEvent [
	roassalCanvas host lastMousePosition: aBlEvent position.
	
	self announceEventOfClass: RSMouseMove from: aBlEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseWheelEvent: aBlEvent [
	aBlEvent vector y isZero ifTrue: [ ^ self ].
	self announceEventOfClass: RSMouseWheelEvent from: aBlEvent
]
