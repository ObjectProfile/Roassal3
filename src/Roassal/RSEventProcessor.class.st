"
Class `RSEventProcessor` is designed to be a bridge between Morphic events and Roassal shapes, allowing you to register event handlers for specific events and process them in Roassal context.
"
Class {
	#name : 'RSEventProcessor',
	#superclass : 'RSObject',
	#instVars : [
		'eventBeginingDragging',
		'roassalCanvas',
		'athensMorph',
		'lastMousePosition',
		'shapesBeingPointed'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'events - processed' }
RSEventProcessor >> eventKeyDown: aMorphicEvent [
	self process: aMorphicEvent rsEventClass: RSKeyDown
]

{ #category : 'events - processed' }
RSEventProcessor >> eventKeyUp: aMorphicEvent [
	self process: aMorphicEvent rsEventClass: RSKeyUp
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
	rsEvent shape: shapesBeingPointed.
	shapesBeingPointed announce: rsEvent.

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

	shapesBeingPointed := rsEvent shape.
	shapesBeingPointed announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseDragging: aMorphicEvent [
	| rsEvent step |
	eventBeginingDragging ifNil: [ ^ self ].
	step := aMorphicEvent position - eventBeginingDragging position.
	rsEvent := self eventOfClass: RSMouseDragging from: aMorphicEvent.
	rsEvent position: (roassalCanvas camera fromPixelToSpace: rsEvent position).
	rsEvent step: step.

	shapesBeingPointed ifNil: [ shapesBeingPointed := rsEvent shape ].
	"If the element was removed during the drag then cancel the event"
	shapesBeingPointed parent ifNil: [
		eventBeginingDragging := nil.
		shapesBeingPointed := nil.
		^ self ].

	rsEvent shape: shapesBeingPointed.
	shapesBeingPointed announce: rsEvent.
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
	shapesBeingPointed ifNotNil: [
		rsEvent shape: shapesBeingPointed].
	rsEvent shape announce: rsEvent
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseMove: aMorphicEvent [
	self process: aMorphicEvent rsEventClass: RSMouseMove.
]

{ #category : 'events - processed' }
RSEventProcessor >> eventMouseOver: aMorphicEvent [
	| currentShapes difference |
	currentShapes := self shapesForEvent: aMorphicEvent.
	shapesBeingPointed ifNil: [ shapesBeingPointed := currentShapes ].
	(currentShapes hasSameObjects: shapesBeingPointed)
		ifTrue: [ ^ self ].
	difference := shapesBeingPointed difference: currentShapes.
	self process: difference classEvent: RSMouseLeave event: aMorphicEvent.
	difference := currentShapes difference: shapesBeingPointed.
	self process: difference classEvent: RSMouseEnter event: aMorphicEvent.
	shapesBeingPointed := currentShapes
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

{ #category : 'accessing' }
RSEventProcessor >> lastMousePosition [
	^ lastMousePosition
]

{ #category : 'accessing' }
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

{ #category : 'events - processing' }
RSEventProcessor >> process: aListOfShapes classEvent: aRSEventClass event: aMorphicEvent [
	| listToPropagate rsEvent |
	aListOfShapes ifEmpty: [ ^ self ].
	listToPropagate := aListOfShapes.
	"TODO an idea to reverse or not the list of children"
	rsEvent := self newEventOfClass: aRSEventClass from: aMorphicEvent.
	rsEvent targetShape: aListOfShapes first.
	"aRSEventClass traceCr.
	listToPropagate traceCr.
	'' traceCr."
	self propagate: listToPropagate event: rsEvent. 
	
]

{ #category : 'events - processed' }
RSEventProcessor >> process: aMorphicEvent rsEventClass: aRSEventClass [
	| rsEvent list |
	shapesBeingPointed ifNil: [ ^ self ].
	list := shapesBeingPointed copy.
	list add: roassalCanvas.
	rsEvent := self newEventOfClass: aRSEventClass from: aMorphicEvent.
	rsEvent setPosition: aMorphicEvent.
	rsEvent targetShape: list first.
	self propagate: list event: rsEvent.
]

{ #category : 'events - processing' }
RSEventProcessor >> propagate: listToPropagate event: rsEvent [
	listToPropagate do: [ :each |
		rsEvent currentShape: each.
		each announce: rsEvent.
		rsEvent stopPropagation ifTrue: [ ^ self ]
	].
	
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

{ #category : 'accessing - shapes' }
RSEventProcessor >> shapesForEvent: anEvent [
	"Return the roassal shape for the event provided as argument"
	^ roassalCanvas shapesWithActionForPositionInPixels: (self relativePositionFor: anEvent)
]

{ #category : 'events - processing' }
RSEventProcessor >> transformedFrom: aMorph [
	"method used by MouseClickState"
	^ athensMorph transformedFrom: aMorph
]
