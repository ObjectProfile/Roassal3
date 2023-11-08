"
Class `RSEventProcessor` is designed to be a bridge between Morphic events and Roassal shapes, allowing you to register event handlers for specific events and process them in Roassal context.
"
Class {
	#name : 'RSEventProcessor',
	#superclass : 'RSObject',
	#instVars : [
		'eventBeginingDragging',
		'shapeBeingPointed',
		'roassalCanvas',
		'athensMorph',
		'lastMousePosition'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'events - processed' }
RSEventProcessor >> eventKeyDown: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSKeyDown from: aMorphicEvent.
	rsEvent
		position: (roassalCanvas camera fromPixelToSpace: rsEvent position);
		keyValue: aMorphicEvent keyValue;
		keyName: aMorphicEvent key name. "(self class keyNameFor: aMorphicEvent keyValue)".
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventKeyUp: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSKeyUp from: aMorphicEvent.
	rsEvent
		position: (roassalCanvas camera fromPixelToSpace: rsEvent position);
		keyValue: aMorphicEvent keyValue;
		keyName: aMorphicEvent key name.
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseClick: aMorphicEvent [
	| rsEvent |
	rsEvent := self
		mouseEventOfClass: RSMouseClick
		ifLeftButton: RSMouseLeftClick
		ifRightButton: RSMouseRightClick
		from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseDoubleClick: aMorphicEvent [
	| rsEvent |
	rsEvent := self
		mouseEventOfClass: RSMouseDoubleClick
		ifLeftButton: RSMouseDoubleLeftClick
		ifRightButton: RSMouseDoubleRightClick
		from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseDragEnd: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSMouseDragEnd from: aMorphicEvent.
	rsEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: rsEvent.

	eventBeginingDragging := nil
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseDragStart: aMorphicEvent [
	| rsEvent rsEventClass |
	eventBeginingDragging := aMorphicEvent copy.

	rsEventClass := RSMouseDragStart.
	aMorphicEvent redButtonChanged
		ifTrue: [ rsEventClass := RSMouseLeftDragStart ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ rsEventClass := RSMouseRightDragStart ].
	aMorphicEvent blueButtonChanged
		ifTrue: [ rsEventClass := RSMouseMiddleDragStart ].
	rsEvent := self eventOfClass: rsEventClass actionClass: RSMouseDragging from: aMorphicEvent.

	shapeBeingPointed := rsEvent shape.
	shapeBeingPointed announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseDragging: aMorphicEvent [
	| rsEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.
	rsEvent := self eventOfClass: RSMouseDragging from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent step: step.

	shapeBeingPointed ifNil: [ shapeBeingPointed := rsEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapeBeingPointed parent ifNil: [
		eventBeginingDragging := nil.
		shapeBeingPointed := nil.
		^ self ].

	rsEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: rsEvent.
	eventBeginingDragging := aMorphicEvent copy
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseEnter: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSMouseEnter from: aMorphicEvent.
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseLeave: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSMouseLeave from: aMorphicEvent.
	shapeBeingPointed ifNotNil: [
		rsEvent shape: shapeBeingPointed].
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseMove: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSMouseMove from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseOver: aMorphicEvent [
	| currentShape rsEvent |
	shapeBeingPointed ifNil: [
		shapeBeingPointed := self shapeForEvent: aMorphicEvent ].
	currentShape := self shapeForEvent: aMorphicEvent.
	currentShape == shapeBeingPointed
		ifTrue: [ ^ self ].
	
	rsEvent := self newEventOfClass: RSMouseLeave from: aMorphicEvent.
	rsEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: rsEvent.
	
	shapeBeingPointed := currentShape.
	rsEvent := self newEventOfClass: RSMouseEnter from: aMorphicEvent.
	rsEvent shape: shapeBeingPointed.
	shapeBeingPointed announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseUp: aMorphicEvent [
	| rsEvent |
	rsEvent := self
		mouseEventOfClass: RSMouseUp
		ifLeftButton: RSMouseUpLeft
		ifRightButton: RSMouseUpRight
		from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseWheel: aMorphicEvent [
	| rsEvent |
	rsEvent := self eventOfClass: RSMouseWheelEvent from: aMorphicEvent.
	rsEvent
		direction: aMorphicEvent direction;
		position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent shape announce: rsEvent
]

{ #category : 'event type' }
RSEventProcessor >> eventOfClass: anEventClass actionClass: anActionClass from: aMorphicEvent [
	| relativePosition rsEvent shape |
	"this method search for a shape in the canvas"
	relativePosition := self relativePositionFor: aMorphicEvent.
	shape := roassalCanvas shapeWithAction: anActionClass forPositionInPixels: relativePosition.
	rsEvent := self newEventOfClass: anEventClass from: aMorphicEvent.
	rsEvent shape: shape.
	^ rsEvent
	
]

{ #category : 'event type' }
RSEventProcessor >> eventOfClass: anEventClass from: aMorphicEvent [
	^ self eventOfClass: anEventClass actionClass: anEventClass from: aMorphicEvent
]

{ #category : 'testing' }
RSEventProcessor >> hasEvents [
	^ eventBeginingDragging isNotNil
]

{ #category : 'testing' }
RSEventProcessor >> isDragging [
	^ eventBeginingDragging isNotNil
]

{ #category : 'lastMousePosition' }
RSEventProcessor >> lastMousePosition [
	^ lastMousePosition
]

{ #category : 'lastMousePosition' }
RSEventProcessor >> lastMousePosition: aPoint [
	lastMousePosition := aPoint
]

{ #category : 'accessing' }
RSEventProcessor >> morph [
	^ athensMorph
]

{ #category : 'accessing' }
RSEventProcessor >> morph: aRSAthensMorph [
	athensMorph := aRSAthensMorph
]

{ #category : 'event type' }
RSEventProcessor >> mouseEventOfClass: defaultClass ifLeftButton: leftButtonClass ifRightButton: rightButtonClass from: aMorphicEvent [
	| rsEventClass |
	rsEventClass := defaultClass.
	aMorphicEvent redButtonChanged
		ifTrue: [ rsEventClass := leftButtonClass ].
	aMorphicEvent yellowButtonChanged
		ifTrue: [ rsEventClass := rightButtonClass ].
	^ self eventOfClass: rsEventClass actionClass: defaultClass from: aMorphicEvent
]

{ #category : 'event type' }
RSEventProcessor >> newEventOfClass: anEventClass from: aMorphicEvent [
	| relativePosition rsEvent |
	"this method does not search for a shape in the canvas"
	relativePosition := self relativePositionFor: aMorphicEvent.
	rsEvent := anEventClass fromEvent: aMorphicEvent.
	rsEvent
		morph: athensMorph;
		canvas: roassalCanvas;
		position: relativePosition.
	^ rsEvent
]

{ #category : 'accessing - shapes' }
RSEventProcessor >> relativePositionFor: evt [
	^ evt position - athensMorph bounds origin
]

{ #category : 'accessing' }
RSEventProcessor >> roassalCanvas [
	^ roassalCanvas
]

{ #category : 'accessing' }
RSEventProcessor >> roassalCanvas: aRSCanvas [
	roassalCanvas := aRSCanvas
]

{ #category : 'accessing - shapes' }
RSEventProcessor >> shapeForEvent: anEvent [
	"Return the roassal shape for the event provided as argument"
	^ roassalCanvas shapeWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : 'events - processing' }
RSEventProcessor >> transformedFrom: aMorph [
	"method used by MouseClickState"
	^ athensMorph transformedFrom: aMorph
]
