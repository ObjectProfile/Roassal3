"
I put a scrool bars shapes to the canvas when the view moves.

I interact with `RSCanvasController`.

When the user changes the camera position or the camera scale, it will trigger
`RSPositionChangedEvent` or `RSScaleChangedEvent`.

No customization for the moment for bar shapes

Instance variables
- barShape, is a base shape, it defines the appereance and events for the bars.
- horizontal, vertical are the bar shapes, they are copies of barShape.
- animation, is a waiting animation, when finish will call hideAnimation
- hideAnimation, will fade out the bars
Use this class with `RSDraggableCanvasInteraction` and `RSKeyNavigationCanvasInteraction`
"
Class {
	#name : 'RSScrollBarsCanvasInteraction',
	#superclass : 'RSAbstractControlCanvasInteraction',
	#instVars : [
		'barShape',
		'vertical',
		'horizontal',
		'animation',
		'hideAnimation'
	],
	#category : 'Roassal-Interaction-Controls',
	#package : 'Roassal-Interaction',
	#tag : 'Controls'
}

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> addScrollBars: aCanvas [
	vertical := self barShapeCopy.
	horizontal := self barShapeCopy.

	aCanvas addShape: vertical; addShape: horizontal
]

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> barShapeCopy [
	^ barShape copy
		announcer: barShape announcer;
		border: (RSBorder new
			color: Color transparent;
			width: 0.5;
			yourself);
		yourself
]

{ #category : 'private' }
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

{ #category : 'initialization' }
RSScrollBarsCanvasInteraction >> initialize [
	super initialize.
	self initializeShape
]

{ #category : 'initialization' }
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

{ #category : 'initialization' }
RSScrollBarsCanvasInteraction >> initializeShape [
	barShape := RSBox new
		cornerRadius: (RSCornerRadius new radius: 5);
		size: 10;
		noPaint;
		isFixed: true;
		when: RSMouseDragging send: #moveScroll: to: self;
		when: RSMouseEnter send: #mouseEnter: to: self;
		when: RSMouseLeave send: #mouseLeave: to: self;
		yourself
]

{ #category : 'accessing' }
RSScrollBarsCanvasInteraction >> minBarSize [
	^ 5
]

{ #category : 'events' }
RSScrollBarsCanvasInteraction >> mouseEnter: evt [
	"used when the mouse enter in one scroll bar"
	| shape |
	self removeRectanglesFor: evt canvas.
	self updateScrollbars.
	shape := evt shape.
	shape color isTransparent
		ifFalse: [ shape color: (self scrollColor alpha: 1) ].
	animation stop.
	hideAnimation stop
]

{ #category : 'events' }
RSScrollBarsCanvasInteraction >> mouseLeave: evt [
	"used when the mouse leave the on bar shape"
	| shape |
	shape := evt shape.
	shape color isTransparent
		ifFalse: [ shape color: self scrollColor ].
	self removeRectanglesFor: evt canvas.
	vertical parent addAnimation: animation
]

{ #category : 'events' }
RSScrollBarsCanvasInteraction >> moveScroll: evt [
	| shape delta position camera canvasExtent shapesRect correct target |
	shape := evt shape.
	delta := evt step.
	camera := evt camera.
	canvasExtent := evt canvas extent.
	shapesRect := self encompassingRectangleFor: evt canvas.
	delta := shape = vertical
		ifTrue: [ 0 @ delta y ]
		ifFalse: [ delta x @ 0 ].

	shape translateBy: delta.

	position := horizontal position x @ vertical position y.
	position := position * shapesRect extent / canvasExtent.
	target := (position + shapesRect origin) * camera scale negated + (camera originMode gapToCenter: camera).
	correct := self
		correctCamera: camera
		matrixDo: [ :mat | mat translation: target ].

	camera translateTo: correct.
	correct = target ifFalse: [ self updateBasicScrollbars ].
	evt signalUpdate
]

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> onShape: aCanvas [
	self addScrollBars: aCanvas.
	aCanvas
		when: RSPositionChangedEvent send: #updateScrollbars to: self;
		when: RSScaleChangedEvent send: #updateScrollbars to: self;
		when: RSExtentChangedEvent send: #updateScrollbars to: self
]

{ #category : 'rendering' }
RSScrollBarsCanvasInteraction >> renderLegendOn: lb [
	lb text: '' description: 'Use scroll bars to navigate'
]

{ #category : 'accessing' }
RSScrollBarsCanvasInteraction >> scrollBorderColor [
	^ Color lightGray translucent
]

{ #category : 'accessing' }
RSScrollBarsCanvasInteraction >> scrollColor [
	^ Color lightGray translucent
]

{ #category : 'accessing' }
RSScrollBarsCanvasInteraction >> shape [
	^ barShape
]

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> updateAnimation [
	| canvas |
	canvas := vertical canvas.
	hideAnimation
		ifNil: [ self initializeHideAnimation ].
	animation ifNotNil: [
		animation stop.
		hideAnimation stop.
		^ canvas addAnimation: animation ].
	animation := canvas newAnimation
		duration: 700 milliSeconds;
		onStepDo: [ :t | canvas signalUpdate ];
		when: RSAnimationLoopEvent do: [
			canvas addAnimation: hideAnimation ]
		for: self
]

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> updateBasicScrollbars [
	| canvas canvasRect shapesRect p pd ext scrollExtent size |
	canvas := vertical canvas.
	canvasRect := canvas visibleRectangle.
	shapesRect := self encompassingRectangleFor: canvas.

	scrollExtent := vertical width @ horizontal height.
	p := canvas extent - (scrollExtent / 2).
	size := 10.

	pd := canvas extent * (canvasRect floatCenter - shapesRect origin) / shapesRect extent.
	ext := canvasRect extent * canvas extent / shapesRect extent.

	vertical position: p x @ pd y ; extent: size @ (ext y max: self minBarSize).
	horizontal position: pd x @ p y; extent: (ext x max: self minBarSize) @ size
]

{ #category : 'hooks' }
RSScrollBarsCanvasInteraction >> updateScrollbars [
	self updateBasicScrollbars.
	self color: self scrollColor border: self scrollBorderColor.
	self updateAnimation.
	vertical signalUpdate
]
