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
		(targetShape handleAnnouncementClass: aRSEventClass)]) ifFalse:[ ^ self ].

	aBlEvent consumed: true.

	aRSEvent := aRSEventClass new
		canvas: roassalCanvas;
		shape: targetShape;
		position: (self roassalPositionFor: aBlEvent);
		yourself.
		
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

	self announceEventOfClass: RSMouseMove from: aBlEvent
]

{ #category : #private }
RSBlocEventListener >> roassalPositionFor: aBlEvent [
	"Answer the position of the event translated to a RSCanvas space position as callbacks expect it (where '0@0' is the center of the canvas)."

	| positionOfCanvasInSpace positionOfEventInCanvas |
	positionOfCanvasInSpace := roassalCanvas host canvasElement positionInSpace.
	positionOfEventInCanvas := aBlEvent position - positionOfCanvasInSpace.
	^ roassalCanvas camera fromPixelToSpace: positionOfEventInCanvas

]
