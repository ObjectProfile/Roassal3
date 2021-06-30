Class {
	#name : #RSBlocEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'dispatcher',
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

{ #category : #'mouse handlers' }
RSBlocEventListener >> clickEvent: aBlEvent [

	| aRSEvent |
	aBlEvent consumed: true.
	aRSEvent := dispatcher 
		mouseEventOfClass: RSMouseClick
		ifLeftButton: RSMouseLeftClick
		ifRightButton: RSMouseRightClick
		from: aBlEvent.

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

	aRSEvent shape announce: aRSEvent.

]

{ #category : #'mouse handlers' }
RSBlocEventListener >> dragStartEvent: anEvent [
"	anEvent consumed: true."
"	#dragStartEvent: traceCr."
]

{ #category : #initialization }
RSBlocEventListener >> initializeForCanvas: aRSCanvas [ 
	
	self initialize.
	roassalCanvas := aRSCanvas.
	dispatcher := RSBlocEventDispatcher new
		roassalCanvas: aRSCanvas;
		yourself.
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseEnterEvent: aBlEvent [

	| shape aRSEvent |
	shape := aBlEvent target roassalShape.
"	#mouseEnterEvent: trace.
	(shape handlesEventClass: RSMouseEnter)
		ifFalse: [
			#No traceCr.
			^ self ]
		ifTrue: [
			#Yes traceCr ].	
"
	aBlEvent consumed: true.
	aRSEvent := dispatcher eventOfClass: RSMouseEnter from: aBlEvent.

	shape announce: aRSEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseLeaveEvent: aBlEvent [

	| shape aRSEvent |
	shape := aBlEvent target roassalShape.
"	#mouseLeaveEvent: trace.
	(shape handlesEventClass: RSMouseLeave)
		ifFalse: [
			#No traceCr.		
			^ self ]
		ifTrue: [
			#Yes traceCr ].	
"	
	aBlEvent consumed: true.
	aRSEvent := dispatcher eventOfClass: RSMouseLeave from: aBlEvent.
	
	shape announce: aRSEvent
]

{ #category : #'mouse handlers' }
RSBlocEventListener >> mouseMoveEvent: aBlEvent [

	| shape aRSEvent |
	shape := aBlEvent target roassalShape.
"	#mouseMoveEvent: trace.
	(shape handlesEventClass: RSMouseMove)
		ifFalse: [
			#No traceCr.		
			^ self ]
		ifTrue: [
			#Yes traceCr ].
"
	aBlEvent consumed: true.
	aRSEvent := dispatcher eventOfClass: RSMouseMove from: aBlEvent.
	
	shape announce: aRSEvent
]
