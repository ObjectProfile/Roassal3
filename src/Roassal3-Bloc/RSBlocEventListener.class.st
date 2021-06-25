Class {
	#name : #RSBlocEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'host',
		'dispatcher'
	],
	#category : #'Roassal3-Bloc-Events'
}

{ #category : #'instance creation' }
RSBlocEventListener class >> newForHost: aRSHost [ 
	
	^ self basicNew
		initializeForHost: aRSHost;
		yourself
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> clickEvent: anEvent [

	| aRSEvent |
	anEvent consumed: true.
	aRSEvent := dispatcher 
		mouseEventOfClass: RSMouseClick
		ifLeftButton: RSMouseLeftClick
		ifRightButton: RSMouseRightClick
		from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent.

]

{ #category : #'mouse handlers' }
RSBlocEventListener >> doubleClickEvent: anEvent [

	| aRSEvent |
	anEvent consumed: true.
	aRSEvent := dispatcher
		mouseEventOfClass: RSMouseDoubleClick
		ifLeftButton: RSMouseDoubleLeftClick
		ifRightButton: RSMouseDoubleRightClick
		from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent.

]

{ #category : #'mouse handlers' }
RSBlocEventListener >> dragStartEvent: anEvent [
"	anEvent consumed: true."
"	#dragStartEvent: traceCr."
]

{ #category : #initialization }
RSBlocEventListener >> initializeForHost: aRSHost [ 
	
	self initialize.
	host := aRSHost.
	dispatcher := RSBlocEventDispatcher new
		roassalCanvas: aRSHost canvas;
		yourself.
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseEnterEvent: anEvent [

	"| aRSEvent |
	anEvent consumed: true.
	
	aRSEvent := dispatcher eventOfClass: RSMouseEnter from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent."
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseLeaveEvent: anEvent [

	| aRSEvent |
"	anEvent consumed: true.
"
	aRSEvent := dispatcher eventOfClass: RSMouseLeave from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent.
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseMoveEvent: anEvent [

	| aRSEvent |
	anEvent consumed: true.

	aRSEvent := dispatcher eventOfClass: RSMouseMove from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent.
]
