"
I put a scrool shapes to the view when the view moves
"
Class {
	#name : #RSScrollBarsCanvasInteraction,
	#superclass : #RSAbstractControlCanvasInteraction,
	#instVars : [
		'barShape',
		'vertical',
		'horizontal',
		'animation',
		'hideAnimation'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> addScrollBars: aCanvas [
	vertical := self barShapeCopy.
	horizontal := self barShapeCopy.

	aCanvas addShape: vertical; addShape: horizontal
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> barShapeCopy [
	^ barShape copy
		announcer: barShape announcer;
		border: (RSBorder new
			color: Color transparent;
			width: 0.5;
			yourself);
		yourself
]

{ #category : #private }
RSScrollBarsCanvasInteraction >> color: color1 border: color2 [
	| c1 c2 extent |
	c1 := color1.
	c2 := color2.
	extent := vertical parent extent.
	vertical height >= extent y
		ifTrue: [ c1 := c2 := Color transparent ].
	vertical
		color: c1;
		borderColor: c2.
	c1 := color1.
	c2 := color2.
	horizontal width >= extent x
		ifTrue: [ c1 := c2 := Color transparent ].
	horizontal
	 	color: c1;
		borderColor: c2
]

{ #category : #initialization }
RSScrollBarsCanvasInteraction >> initialize [
	super initialize.
	self initializeShape
]

{ #category : #initialization }
RSScrollBarsCanvasInteraction >> initializeHideAnimation [
	| sc1 sc2 |
	sc1 := NSScale linear range: { self scrollColor. Color transparent }.
	sc2 := NSScale linear range: { self scrollBorderColor. Color transparent }.
	hideAnimation := vertical parent transitionAnimation
		duration: 1 second;
		onStepDo: [ :t |
			self
				color: (sc1 scale: t)
				border: (sc2 scale: t).
			vertical signalUpdate. ]
]

{ #category : #initialization }
RSScrollBarsCanvasInteraction >> initializeShape [
	barShape := RSBox new
		cornerRadius: (RSCornerRadius new radius: 5);
		size: 10;
		noPaint;
		isFixed: true;
		when: RSMouseDragging do: [:evt| self moveScroll: evt ];
		when: RSMouseEnter do: [ :evt| | shape |
			self updateScrollbars.
			shape := evt shape.
			shape color isTransparent
				ifFalse: [ shape color: (self scrollColor alpha: 1) ].
			animation stop.
			hideAnimation stop ];
		when: RSMouseLeave do: [ :evt| | shape |
			shape := evt shape.
			shape color isTransparent
				ifFalse: [ shape color: self scrollColor ].
			self removeRectanglesFor: evt canvas.
			vertical parent addAnimation: animation ];
		yourself
]

{ #category : #accessing }
RSScrollBarsCanvasInteraction >> minBarSize [
	^ 5
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> moveScroll: evt [
	| shape delta position camera canvasExtent shapesRect correct oldPosition |
	shape := evt shape.
	delta := evt step.
	delta := shape = vertical shape
		ifTrue: [ 0@delta y ]
		ifFalse: [ delta x@0 ].
	shape translateBy: delta.
	canvasExtent := evt canvas extent.
	shapesRect := self encompassingRectangleFor: evt canvas.
	position := horizontal position x @ vertical position y.
	position := position * shapesRect extent / canvasExtent.

	camera := evt camera.
	oldPosition := camera position.
	camera position: position + shapesRect origin.
	correct := self correctCameraPosition: evt canvas.
	correct = camera position ifTrue: [
		"to notify the change"
		camera position: oldPosition.
		camera translateTo: position + shapesRect origin.
	] ifFalse: [
		camera translateTo: correct.
		"camera position: correct."
		self updateBasicScrollbars. ].
	evt signalUpdate.
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> onShape: aCanvas [
	self addScrollBars: aCanvas.
	aCanvas
		when: RSPositionChangedEvent send: #updateScrollbars to: self;
		when: RSScaleChangedEvent send: #updateScrollbars to: self;
		when: RSExtentChangedEvent send: #updateScrollbars to: self
]

{ #category : #rendering }
RSScrollBarsCanvasInteraction >> renderLegendOn: lb [
	lb text: '' description: 'Use scroll bars to navigate'
]

{ #category : #accessing }
RSScrollBarsCanvasInteraction >> scrollBorderColor [
	^ Color lightGray translucent
]

{ #category : #accessing }
RSScrollBarsCanvasInteraction >> scrollColor [
	^ Color lightGray translucent
]

{ #category : #accessing }
RSScrollBarsCanvasInteraction >> shape [
	^ barShape
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> updateAnimation [
	| canvas |
	canvas := vertical parent.
	hideAnimation
		ifNil: [ self initializeHideAnimation ].
	animation ifNotNil: [
		animation stop.
		hideAnimation stop.
		^ canvas addAnimation: animation.
		].
	animation := canvas newAnimation
		duration: 700 milliSeconds;
		onStepDo: [ :t | canvas signalUpdate ];
		when: RSAnimationLoopEvent do: [
			canvas addAnimation: hideAnimation ]
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> updateBasicScrollbars [
	| canvas canvasRect shapesRect p pd ext scrollExtent |
	canvas := vertical parent.
	canvasRect := canvas visibleRectangle.
	shapesRect := self encompassingRectangleFor: canvas.

	scrollExtent := vertical width @ horizontal height.
	p := canvas extent - 1 - (scrollExtent / 2).

	pd := canvas extent * (canvasRect floatCenter - shapesRect origin) / shapesRect extent.
	ext := canvasRect extent * canvas extent / shapesRect extent.
	vertical position: p x @ pd y ; height: (ext y max: self minBarSize).
	horizontal position: pd x @ p y; width: (ext x max: self minBarSize)
]

{ #category : #hooks }
RSScrollBarsCanvasInteraction >> updateScrollbars [
	self updateBasicScrollbars.
	self color: self scrollColor border: self scrollBorderColor.
	self updateAnimation.
	vertical signalUpdate
]
