"
Elastic box interaction creates an selection box for a group o elements

this interaction works with an announcer. with this events `RSSelectionChangedEvent`, `RSSelectionEndEvent` and `RSSelectionEndEvent`.

"
Class {
	#name : #RSElasticBox,
	#superclass : #RSAbstractCanvasInteraction,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'events',
		'draggingCanvas',
		'announcer',
		'baseBox',
		'selectedShapes',
		'startPosition',
		'shouldUseNegativeBox',
		'targetShapes'
	],
	#category : #'Roassal3-Interaction-ElasticBox'
}

{ #category : #announcer }
RSElasticBox >> announcementClasses [
	^ RSSelectionEvent subclasses
]

{ #category : #announcer }
RSElasticBox >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #public }
RSElasticBox >> box [
	^ baseBox
]

{ #category : #'event processing' }
RSElasticBox >> boxEnded: event [
	| boxEvent |
	boxEvent := self createEvent: RSSelectionEndEvent with: event.
	boxEvent shape remove.
	event canvas removeKey: self className.
	boxEvent selectedShapes: selectedShapes.
	self announce: boxEvent.
	event signalUpdate.
]

{ #category : #accessing }
RSElasticBox >> boxStartEvent [
	"return the activation box start event"
	^ self events second
]

{ #category : #'event processing' }
RSElasticBox >> boxStarted: event [
	| boxEvent |
	boxEvent := self createEvent: RSSelectionStartEvent with: event.
	boxEvent selectedShapes: (selectedShapes := RSGroup new).
	startPosition := event camera fromPixelToSpace: event position.
	self announce: boxEvent.
]

{ #category : #'event processing' }
RSElasticBox >> boxUpdated: event [
	| boxEvent newSelectedShapes |
	boxEvent := self createEvent: RSSelectionChangedEvent with: event.
	self updateBoxRectangle: boxEvent shape with: event.
	newSelectedShapes := self selectedShapesWith: boxEvent shape.
	selectedShapes = newSelectedShapes ifFalse: [ 
		boxEvent
			oldSelectedShapes: selectedShapes;
			selectedShapes: newSelectedShapes.
		selectedShapes := newSelectedShapes.
		self announce: boxEvent.
	].
	
	event signalUpdate.
	
]

{ #category : #helper }
RSElasticBox >> createElasticBox: event [
	| canvas elasticBox |
	canvas := event canvas.
	elasticBox := self box copy.
	canvas addShape: elasticBox.
	^ elasticBox
]

{ #category : #helper }
RSElasticBox >> createEvent: clazzEvent with: originalEvent [
	^ clazzEvent new
		canvas: originalEvent canvas;
		shape: (self getOrCreateElasticBox: originalEvent);
		yourself
]

{ #category : #initialization }
RSElasticBox >> defaultBox [
	| color |
	color := Color colorFrom: '3399FF'.
	^ RSBox new 
		border: (RSBorder new color: color);
		color: (color alpha: 0.2)
		yourself
]

{ #category : #'event processing' }
RSElasticBox >> disableDrag: event [
	draggingCanvas := false.
	self boxStarted: event.
]

{ #category : #accessing }
RSElasticBox >> dragStartEvent [
	"return the drag activation event for RSDraggableCanvas"
	^ self events first
]

{ #category : #'event processing' }
RSElasticBox >> enableDrag: event [
	draggingCanvas := true.
]

{ #category : #accessing }
RSElasticBox >> events [
	"return an array with 2 elements the `boxStartEvent` and `dragStartEvent` "
	^ events
]

{ #category : #helper }
RSElasticBox >> getOrCreateElasticBox: event [
	^ event canvas 
		propertyAt: self className
		ifAbsentPut: [ self createElasticBox: event ]
]

{ #category : #initialization }
RSElasticBox >> initialize [
	super initialize.
	self leftRight.
	baseBox := self defaultBox.
	self useNegativeBox.
	self targetShapes: #nodes.
	draggingCanvas := false.
	
]

{ #category : #public }
RSElasticBox >> leftRight [
	events := { RSMouseLeftDragStart. RSMouseRightDragStart }.
]

{ #category : #public }
RSElasticBox >> noNegativeBox [
	shouldUseNegativeBox := false.
]

{ #category : #hooks }
RSElasticBox >> onShape: aCanvas [
	aCanvas removeInteractionIfPresent: RSDraggableCanvas.
	aCanvas addInteraction: (RSDraggableCanvas new 
		mouseEvent: self dragStartEvent).
	aCanvas
		when: self dragStartEvent send: #enableDrag: to: self;
		when: self boxStartEvent send: #disableDrag: to: self;
		when: RSMouseDragging send: #processDrag: to: self;
		when: RSMouseDragEnd send: #processDragEnd: to: self
]

{ #category : #announcer }
RSElasticBox >> privateAnnouncer [
	^ announcer
]

{ #category : #'event processing' }
RSElasticBox >> processDrag: event [
	draggingCanvas ifTrue: [ ^ self ].
	self boxUpdated: event
]

{ #category : #'event processing' }
RSElasticBox >> processDragEnd: event [
	draggingCanvas
		ifTrue: [ draggingCanvas := false ]
		ifFalse: [ self boxEnded: event ]
	
]

{ #category : #public }
RSElasticBox >> rightLeft [
	events := { RSMouseRightDragStart. RSMouseLeftDragStart }.
]

{ #category : #accessing }
RSElasticBox >> selectedShapes [
	"return the current selected shapes"
	^ selectedShapes
]

{ #category : #helper }
RSElasticBox >> selectedShapesWith: shape [
	| rect |
	rect := shape encompassingRectangle.
	
	^ (targetShapes rsValue: shape canvas)
		select: [ :node | (node = shape) not and: [ node encompassingRectangle intersects: rect] ]
]

{ #category : #testing }
RSElasticBox >> shouldUseNegativeBox [
	^ shouldUseNegativeBox
]

{ #category : #accessing }
RSElasticBox >> targetShapes [
	"Return the targetShapes, usually a collection where the elasticbox with intersets its encompassing rectangle"
	^ targetShapes
]

{ #category : #accessing }
RSElasticBox >> targetShapes: anObject [
	"
	Expermode related to read documentation of `rsValue:`
	targetShapes is used to intersect it with the `elastic box`.
	targetShapes can be a collection, selector or block. If this is a selector or block, its argument will be the current Canvas.
	By default targetShapes is `#nodes`.
	Example
	```
	shapes := (1 to: 10) collect: [ :i | RSBox new size: 5 ].
	elastic := RSElasticBox new.
	elastic targetShapes: shapes.
	canvas @ elastic
	```
	"
	targetShapes := anObject
]

{ #category : #helper }
RSElasticBox >> updateBoxRectangle: shape with: event [
	| corner |
	corner := event position.
	((corner x < startPosition x or: [ corner y < startPosition y ])
		 and: [ self shouldUseNegativeBox not ] )
			ifTrue: [ corner := startPosition ].
	shape fromRectangle: 	(startPosition corner: corner)
]

{ #category : #public }
RSElasticBox >> useNegativeBox [
	shouldUseNegativeBox := true.
]
