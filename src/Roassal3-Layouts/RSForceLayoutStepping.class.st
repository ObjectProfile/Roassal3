"
Hi!, I can control the RSForceBaseLayout step method, in order to use it only when it needs
"
Class {
	#name : #RSForceLayoutStepping,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'layout',
		'animation',
		'hasDraggable'
	],
	#category : #'Roassal3-Layouts-Interactions'
}

{ #category : #hooks }
RSForceLayoutStepping >> addEventsTo: shape [
	| mock |
	shape 
		when: RSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: evt shape.
			mock isFixed: true.
			self startForceAnimation: evt canvas ];
		when: RSMouseDragging do: [ :evt |
			mock fixPosition: evt shape position ];
		when: RSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil.
			self startSimpleAnimation: evt canvas ].
]

{ #category : #accessing }
RSForceLayoutStepping >> alphaRange [
	^ #(0 0.1)
]

{ #category : #hooks }
RSForceLayoutStepping >> configureLayoutOn: aCanvas [
	self hasDraggable ifTrue: [
		aCanvas nodes @ (RSDraggableForce new layout: self layout)].
	self layout
		nodes: aCanvas nodes;
		edges: aCanvas edges;
		start.
]

{ #category : #configuration }
RSForceLayoutStepping >> draggable [
	hasDraggable := true
]

{ #category : #testing }
RSForceLayoutStepping >> hasDraggable [
	^ hasDraggable
]

{ #category : #initialization }
RSForceLayoutStepping >> initialize [
	super initialize.
	self draggable.
]

{ #category : #accessing }
RSForceLayoutStepping >> layout [
	^ layout ifNil: [ layout := RSForceBasedLayout new ]
]

{ #category : #accessing }
RSForceLayoutStepping >> layout: aRSForceBasedLayout [
	layout := aRSForceBasedLayout
]

{ #category : #configuration }
RSForceLayoutStepping >> noDraggable [
	hasDraggable := false.
]

{ #category : #hooks }
RSForceLayoutStepping >> onShape: aCanvas [
	self configureLayoutOn: aCanvas.
	aCanvas nodes do: [ :s | self addEventsTo: s ].
	self startFirstAnimation: aCanvas.
	aCanvas newAnimation onStepDo: [:t| aCanvas zoomToFit ].
]

{ #category : #animation }
RSForceLayoutStepping >> startFirstAnimation: aCanvas [
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
RSForceLayoutStepping >> startForceAnimation: aCanvas [
	animation ifNotNil: #stop.
	animation := aCanvas animationFrom: {
		"Start smoothly"
		aCanvas transitionAnimation
			easing: RSEasing cubicOut;
			duration: 500 milliSeconds;
			range: self alphaRange;
			onStepDo: [ :t | layout alpha: t; step ].

		"Continue on max alpha undefinitely"
		aCanvas transitionAnimation
			repeat;
			onStepDo: [ :t | layout step ] }.

]

{ #category : #animation }
RSForceLayoutStepping >> startSimpleAnimation: aCanvas [
	animation ifNotNil: #stop.
	animation := aCanvas newAnimation 
		easing: RSEasing cubicInOut;
		range: self alphaRange reversed;
		duration: 2 seconds;
		onStepDo: [ :t | layout alpha: t; step  ];
		yourself
]
