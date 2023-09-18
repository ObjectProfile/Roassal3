"
I set the drag event for canvas view.

Use example:
```st
c := RSCanvas new.
c add: (RSBox new size: 30).
c @ RSDraggableCanvasInteraction
```
I work with `RSControlConfiguration` to obtain the padding/margin size.
I am part of the default set of interactions in `RSCanvasController >> #defaultInteractions`.

Users can drag and drop when they click over the canvas. Even the can drag out of the visible area(`visibleRectangle`), then an animation will start to put the canvas camera in the correct position.

If you want to disable the animation interaction use `RSControlConfiguration >> #hasDraggableAnimation:`.

Also you can configure the action event to activate the drag and drop: `left`, `right`, `middle` or `all`
"
Class {
	#name : #RSDraggableCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'mouseEvent',
		'isMoving',
		'lastStep',
		'hasDraggableAnimation',
		'hasLimits'
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
	self mouseEvent: RSMouseDragStart.
]

{ #category : #computing }
RSDraggableCanvasInteraction >> checkCamera: aCanvas [
	| camera p correct anime |
	self hasDraggableAnimation
		ifFalse: [ ^ self ].
	camera := aCanvas camera.
	p := camera position.
	correct := self correctCamera: camera.
	correct = p ifTrue: [ ^ self ].
	self removeRectanglesFor: aCanvas.
	aCanvas propertyAt: self key ifPresent: [ :a | a stop ].
	anime := self newAnimation.
	aCanvas addAnimation: anime.
	aCanvas propertyAt: self key put: anime.
	anime
		from: p;
		to: correct;
		onStepDo: [ :t | camera translateTo: t. aCanvas signalUpdate ]
]

{ #category : #configuration }
RSDraggableCanvasInteraction >> hasDraggableAnimation [
	^ hasDraggableAnimation
]

{ #category : #configuration }
RSDraggableCanvasInteraction >> hasDraggableAnimation: aBoolean [
	hasDraggableAnimation := aBoolean
]

{ #category : #testing }
RSDraggableCanvasInteraction >> hasLimits [
	^ hasLimits
]

{ #category : #testing }
RSDraggableCanvasInteraction >> hasLimits: aBoolean [
	hasLimits := aBoolean
]

{ #category : #initialization }
RSDraggableCanvasInteraction >> initialize [
	super initialize.
	self
		all;
		hasDraggableAnimation: true;
		withLimits.
	isMoving := false
]

{ #category : #accessing }
RSDraggableCanvasInteraction >> key [
	^ #draggableAnimation
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> left [
	self mouseEvent: RSMouseLeftDragStart
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> middle [
	self mouseEvent: RSMouseMiddleDragStart
]

{ #category : #events }
RSDraggableCanvasInteraction >> mouseDragging: evt [
	| camera p correct |
	isMoving ifFalse: [ ^ self ].
	camera := evt camera.
	lastStep := evt step.
	self hasLimits ifFalse: [
		camera translateBy: lastStep.
		^ evt signalUpdate.
		].
	self hasDraggableAnimation ifTrue: [
		correct := self correctCamera: camera.

		p := (correct - camera position) abs max: 1@1.
		p := p x sqrt @ p y sqrt.
		camera translateBy: lastStep/ p
	] ifFalse: [
		correct := self
			correctCamera: camera
			matrixDo: [:mat | 	mat translation: (camera position + lastStep) ].
		camera translateTo: correct.
	].
	evt signalUpdate
]

{ #category : #events }
RSDraggableCanvasInteraction >> mouseEnd: evt [
	| threshold aCanvas camera delta p correct anime |
	isMoving := false.
	self hasDraggableAnimation
		ifFalse: [ ^ self ].
	lastStep ifNil: [ ^ self ].
	self hasLimits ifFalse: [ ^ self ].
	aCanvas := evt canvas.
	camera := evt camera.
	threshold := 4.
	(lastStep distanceTo: 0@0) < threshold
		ifTrue: [ ^ self checkCamera: aCanvas ].

	delta := lastStep * 1.5.
	lastStep := nil.
	camera translateBy: delta.
	correct := self correctCamera: camera.
	camera translateBy: delta negated.

	p := (correct - camera position) abs max: 1@1.
	p := p x sqrt @ p y sqrt.

	aCanvas propertyAt: self key ifPresent: [ :a | a stop ].
	anime := aCanvas newAnimation.
	aCanvas propertyAt: self key put: anime.
	anime
		easing: RSEasingInterpolator cubicOut;
		duration: 200 milliSeconds;
		from: camera position;
		to: camera position + (delta / p);
		onStepDo: [ :t | camera translateTo: t. aCanvas signalUpdate ];
		when: RSAnimationEndEvent do: [
			aCanvas removeKey: self key.
			self checkCamera: aCanvas ]
		for: self
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
RSDraggableCanvasInteraction >> mouseStart: evt [
	self removeRectanglesFor: evt canvas.
	isMoving := evt shiftKeyPressed not.
	lastStep := nil
]

{ #category : #computing }
RSDraggableCanvasInteraction >> newAnimation [
	^ RSTransitionAnimation new
		easing: RSEasingInterpolator cubicIn;
		duration: 200 milliSeconds;
		when: RSAnimationEndEvent do: [:evt | evt canvas removeKey: self key ] for: self;
		yourself
]

{ #category : #configuration }
RSDraggableCanvasInteraction >> noLimits [
	self hasLimits: false
]

{ #category : #hooks }
RSDraggableCanvasInteraction >> onShape: aCanvas [
	aCanvas 
		when: self mouseEvent send: #mouseStart: to: self;
		when: RSMouseDragging send: #mouseDragging: to: self;
		when: RSMouseDragEnd send: #mouseEnd: to: self.
]

{ #category : #rendering }
RSDraggableCanvasInteraction >> renderLegendOn: lb [
	lb text: 'Mouse click' description: 'To move the view''s camera'
]

{ #category : #mouse }
RSDraggableCanvasInteraction >> right [
	self mouseEvent: RSMouseRightDragStart
]

{ #category : #configuration }
RSDraggableCanvasInteraction >> withLimits [
	self hasLimits: true
]
