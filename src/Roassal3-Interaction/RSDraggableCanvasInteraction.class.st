"
I set the drag event for view, I use a basic bars to do that.

Use example:
```Smalltalk
c := RSCanvas new.
c add: (RSBox new size: 30).
c @ RSDraggableCanvas
```
"
Class {
	#name : #RSDraggableCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'mouseEvent',
		'isMoving',
		'lastStep'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSDraggableCanvasInteraction class >> left [
	^ self new left
]

{ #category : #accessing }
RSDraggableCanvasInteraction class >> middle [
	^ self new middle
]

{ #category : #accessing }
RSDraggableCanvasInteraction class >> right [
	^ self new right
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> all [
	"Any mouse button can be used to drag and drop the view"
	mouseEvent := RSMouseDragStart
]

{ #category : #computing }
RSDraggableCanvasInteraction >> checkCamera: aCanvas [
	| camera p correct anime |
	self configuration hasDraggableAnimation
		ifFalse: [ ^ self ].
	camera := aCanvas camera.
	p := camera position.
	correct := self correctCameraPosition: aCanvas.
	correct = p ifTrue: [ ^ self ].
	self removeRectanglesFor: aCanvas.
	aCanvas propertyAt: self key ifPresent: [ :a | a stop ].
	anime := aCanvas newAnimation.
	aCanvas propertyAt: self key put: anime.
	anime
		easing: RSEasingInterpolator cubicIn;
		duration: 200 milliSeconds;
		from: p;
		to: correct;
		onStepDo: [ :t | camera translateTo: t. aCanvas signalUpdate ];
		when: RSAnimationEndEvent do: [:evt |
			aCanvas removeKey: self key.
			]
]

{ #category : #initialization }
RSDraggableCanvasInteraction >> initialize [
	super initialize.
	self all.
	isMoving := false
]

{ #category : #accessing }
RSDraggableCanvasInteraction >> key [
	^ #draggableAnimation
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> left [
	mouseEvent := RSMouseLeftDragStart
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> middle [
	mouseEvent := RSMouseMiddleDragStart
]

{ #category : #events }
RSDraggableCanvasInteraction >> mouseEnd: evt [
	| threshold aCanvas camera delta p correct anime |
	isMoving := false.
	self configuration hasDraggableAnimation
		ifFalse: [ ^ self ].
	lastStep ifNil: [ ^ self ].
	aCanvas := evt canvas.
	camera := evt camera.
	threshold := 4.
	(lastStep distanceTo: 0@0) < threshold
		ifTrue: [ ^ self checkCamera: aCanvas ].

	delta := lastStep * 1.5.
	lastStep := nil.
	camera translateBy: delta.
	correct := self correctCameraPosition: aCanvas.
	camera translateBy: delta negated.

	p := (correct - camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.

	aCanvas propertyAt: self key ifPresent: [ :a | a stop ].
	anime := aCanvas newAnimation.
	aCanvas propertyAt: self key put: anime.
	anime
		easing: RSEasingInterpolator cubicOut;
		duration: 200 milliSeconds;
		from: camera position; to: camera position + (delta / p);
		onStepDo: [ :t | camera translateTo: t. aCanvas signalUpdate ];
		when: RSAnimationEndEvent do: [
			aCanvas removeKey: self key.
			self checkCamera: aCanvas ]
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> mouseEvent [
	^ mouseEvent
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> mouseEvent: aRSMouseDragEvent [
	mouseEvent := aRSMouseDragEvent
]

{ #category : #events }
RSDraggableCanvasInteraction >> mouseMove: evt [
	| camera p correct |
	isMoving ifFalse: [ ^ self ].
	camera := evt camera.
	lastStep := evt step negated / camera scale.
	self configuration hasDraggableAnimation
		ifTrue: [
			correct  := self correctCameraPosition: evt canvas.
			p := (correct - camera position) abs max: 1@1.
			p := p x sqrt @ p y sqrt.
			camera translateBy: lastStep/ p
		] ifFalse: [
		camera translateBy: lastStep.
		correct  := self correctCameraPosition: evt canvas.
		camera translateTo: correct ].
	evt signalUpdate
]

{ #category : #events }
RSDraggableCanvasInteraction >> mouseStart: evt [
	self removeRectanglesFor: evt canvas.
	isMoving := true.
	lastStep := nil
]

{ #category : #hooks }
RSDraggableCanvasInteraction >> onShape: aCanvas [
	aCanvas
		when: self mouseEvent send: #mouseStart: to: self;
		when: RSMouseDragging send: #mouseMove: to: self;
		when: RSMouseDragEnd send: #mouseEnd: to: self
]

{ #category : #rendering }
RSDraggableCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Mouse click' description: 'To move the view''s camera'
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> right [
	mouseEvent := RSMouseRightDragStart
]
