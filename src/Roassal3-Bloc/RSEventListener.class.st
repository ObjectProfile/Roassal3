Class {
	#name : #RSEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'dispatcher',
		'host'
	],
	#category : #'Roassal3-Bloc'
}

{ #category : #'instance creation' }
RSEventListener class >> newForHost: aRSHost [ 
	
	^ self basicNew
		initializeForHost: aRSHost;
		yourself
]

{ #category : #initialization }
RSEventListener >> initializeForHost: aRSHost [ 
	
	self initialize.
	host := aRSHost.
	dispatcher := RSBlocEventDispatcher new
		roassalCanvas: aRSHost canvas;
		yourself.
]

{ #category : #'mouse handlers' }
RSEventListener >> mouseMoveEvent: anEvent [

	| aRSEvent |
	aRSEvent := dispatcher eventOfClass: RSMouseMove from: anEvent.
	aRSEvent position: (host canvas camera fromPixelToSpace: aRSEvent position).
	aRSEvent shape announce: aRSEvent.
]
