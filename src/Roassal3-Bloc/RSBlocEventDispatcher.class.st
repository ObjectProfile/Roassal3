Class {
	#name : #RSBlocEventDispatcher,
	#superclass : #Object,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal3-Bloc'
}

{ #category : #'event-processed' }
RSBlocEventDispatcher >> eventOfClass: aRSEventClass actionClass: anActionClass from: anEvent [
	| relativePosition aRSEvent shape |
	relativePosition := self relativePositionFor: anEvent.
	shape := self shapeWithAction: anActionClass forPositionInPixels: relativePosition. 
	
	aRSEvent := aRSEventClass new.
	anEvent roassalFill: aRSEvent.

	aRSEvent
"		morph: self;"
		canvas: roassalCanvas;
		shape: shape;
		position: relativePosition.
	^ aRSEvent
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> eventOfClass: anEventClass from: aMorphicEvent [

	^ self
		  eventOfClass: anEventClass
		  actionClass: anEventClass
		  from: aMorphicEvent
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> relativePositionFor: evt [

	^ evt position
]

{ #category : #accessing }
RSBlocEventDispatcher >> roassalCanvas [

	^ roassalCanvas
]

{ #category : #accessing }
RSBlocEventDispatcher >> roassalCanvas: anObject [

	roassalCanvas := anObject
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> shapeWithAction: eventClass forPositionInPixels: position [
	"Return the shape with event handler located that contains point"

	^ roassalCanvas
		  shapeWithAction: eventClass
		  forPositionInPixels: position
]
