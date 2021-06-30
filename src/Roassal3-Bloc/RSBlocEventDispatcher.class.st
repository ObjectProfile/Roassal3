Class {
	#name : #RSBlocEventDispatcher,
	#superclass : #Object,
	#instVars : [
		'roassalCanvas'
	],
	#category : #'Roassal3-Bloc-Events'
}

{ #category : #'event-processed' }
RSBlocEventDispatcher >> eventOfClass: aRSEventClass actionClass: anActionClass from: aBlEvent [

	| targetShape |
	targetShape := aBlEvent target roassalShape.

	self flag: #todo. "anActionClass is ignored"

	^ aRSEventClass new
		canvas: roassalCanvas;
		shape: targetShape;
		position: (self roassalPositionFor: aBlEvent);
		yourself
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> eventOfClass: aRSEventClass from: aBlEvent [

	^ self
		  eventOfClass: aRSEventClass
		  actionClass: aRSEventClass
		  from: aBlEvent
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aBlClickEvent [
	"Translate a Bloc click event to a Roassal click event."

	| roassalEventClass |
	roassalEventClass := defaultClass.
	aBlClickEvent primaryButtonPressed
		ifTrue: [ roassalEventClass := leftButtonClass ].
	aBlClickEvent secondaryButtonPressed
		ifTrue: [ roassalEventClass := rightButtonClass ].

	^ self eventOfClass: roassalEventClass actionClass: defaultClass from: aBlClickEvent
]

{ #category : #accessing }
RSBlocEventDispatcher >> roassalCanvas [

	^ roassalCanvas
]

{ #category : #accessing }
RSBlocEventDispatcher >> roassalCanvas: aRSCanvas [

	roassalCanvas := aRSCanvas
]

{ #category : #'event-processed' }
RSBlocEventDispatcher >> roassalPositionFor: aBlEvent [
	"Answer the position of the event translated to a RSCanvas space position as callbacks expect it (where '0@0' is the center of the canvas)."

	| positionOfCanvasInSpace positionOfEventInCanvas |
	positionOfCanvasInSpace := roassalCanvas host canvasElement positionInSpace.
	positionOfEventInCanvas := aBlEvent position - positionOfCanvasInSpace.
	^ roassalCanvas camera fromPixelToSpace: positionOfEventInCanvas

]
