"
Hi!, I can control the RSForceBaseLayout step method, in order to use it only when it needs
"
Class {
	#name : #RSForceLayoutSteppingInteraction,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'layout',
		'animation',
		'hasDraggable'
	],
	#category : #'Roassal-Layouts-Interactions'
}

{ #category : #hooks }
RSForceLayoutSteppingInteraction >> addEventsTo: shape [
	| mock |
	shape
		when: RSMouseDragStart do: [ :evt |
			mock := layout mockElementAt: evt shape.
			mock isFixed: true.
			self startForceAnimation: evt canvas ]
		for: self;
		when: RSMouseDragging do: [ :evt |
			mock fixPosition: evt shape position ]
		for: self;
		when: RSMouseDragEnd do:[:evt |
			mock isFixed: false.
			mock := nil.
			self startSimpleAnimation: evt canvas ]
		for: self
]

{ #category : #accessing }
RSForceLayoutSteppingInteraction >> alphaRange [
	^ #(0 0.1)
]

{ #category : #hooks }
RSForceLayoutSteppingInteraction >> configureLayoutOn: aCanvas [
	self hasDraggable ifTrue: [
		aCanvas nodes @ (RSDraggableForceInteraction new layout: self layout)].
	self layout
		nodes: aCanvas nodes;
		edges: aCanvas edges;
		start
]

{ #category : #configuration }
RSForceLayoutSteppingInteraction >> draggable [
	hasDraggable := true
]

{ #category : #testing }
RSForceLayoutSteppingInteraction >> hasDraggable [
	^ hasDraggable
]

{ #category : #initialization }
RSForceLayoutSteppingInteraction >> initialize [
	super initialize.
	self draggable
]

{ #category : #accessing }
RSForceLayoutSteppingInteraction >> layout [
	^ layout ifNil: [ layout := RSForceBasedLayout new ]
]

{ #category : #accessing }
RSForceLayoutSteppingInteraction >> layout: aRSForceBasedLayout [
	layout := aRSForceBasedLayout
]

{ #category : #configuration }
RSForceLayoutSteppingInteraction >> noDraggable [
	hasDraggable := false
]

{ #category : #hooks }
RSForceLayoutSteppingInteraction >> onShape: aCanvas [
	self configureLayoutOn: aCanvas.
	aCanvas nodes do: [ :s | self addEventsTo: s ].
	self startFirstAnimation: aCanvas.
	aCanvas newAnimation onStepDo: [:t| aCanvas zoomToFit ]
]

{ #category : #animation }
RSForceLayoutSteppingInteraction >> startFirstAnimation: aCanvas [
	| alpha |
	animation ifNotNil: #stop.
	alpha := 1.
	animation := aCanvas newAnimation
		repeat;
		onStepDo: [ :t | layout alpha: alpha; step.
			alpha := alpha * 0.99.
			alpha < 0.005 ifTrue: [ animation stop ] ];
		yourself
]

{ #category : #animation }
RSForceLayoutSteppingInteraction >> startForceAnimation: aCanvas [
	animation ifNotNil: #stop.
	animation := aCanvas animationFrom: {
		"Start smoothly"
		aCanvas transitionAnimation
			easing: RSEasingInterpolator cubicOut;
			duration: 500 milliSeconds;
			range: self alphaRange;
			onStepDo: [ :t | layout alpha: t; step ].

		"Continue on max alpha undefinitely"
		aCanvas transitionAnimation
			repeat;
			onStepDo: [ :t | layout step ] }
]

{ #category : #animation }
RSForceLayoutSteppingInteraction >> startSimpleAnimation: aCanvas [
	animation ifNotNil: #stop.
	animation := aCanvas newAnimation
		easing: RSEasingInterpolator cubicInOut;
		range: self alphaRange reversed;
		duration: 2 seconds;
		onStepDo: [ :t | layout alpha: t; step  ];
		yourself
]
