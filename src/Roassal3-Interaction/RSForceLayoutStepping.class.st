"
Hi!, I can control the RSForceBaseLayout step method, in order to use it only when it needs
"
Class {
	#name : #RSForceLayoutStepping,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'layout',
		'animation'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSForceLayoutStepping >> addEventsTo: shape [
	| mock |
	shape 
		when: RSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: shape.
			mock isFixed: true.
			self startForceAnimation: shape canvas ];
		when: RSMouseDragging do: [ :evt |
			mock fixPosition: shape position ];
		when: RSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil.
			self startSimpleAnimation: shape canvas ].
]

{ #category : #accessing }
RSForceLayoutStepping >> alphaRange [
	^ #(0 0.1)
]

{ #category : #accessing }
RSForceLayoutStepping >> layout [
	^ layout
]

{ #category : #accessing }
RSForceLayoutStepping >> layout: aRSForceBasedLayout [
	layout := aRSForceBasedLayout
]

{ #category : #hooks }
RSForceLayoutStepping >> onShape: aCanvas [
	aCanvas nodes do: [ :s | self addEventsTo: s ].
	self startSimpleAnimation: aCanvas.
	aCanvas newAnimation onStepDo: [:t| aCanvas zoomToFit ].
]

{ #category : #animation }
RSForceLayoutStepping >> startForceAnimation: aView [
	animation ifNotNil: #stop.
	animation := aView animationFrom: {
		"Start smoothly"
		aView transitionAnimation
			easing: RSEasing cubicOut;
			duration: 500 milliSeconds;
			range: self alphaRange;
			onStepDo: [ :t | layout alpha: t; step ].

		"Continue on max alpha undefinitely"
		aView transitionAnimation
			repeat;
			onStepDo: [ :t | layout step ] }.

]

{ #category : #animation }
RSForceLayoutStepping >> startSimpleAnimation: aView [
	animation ifNotNil: #stop.
	animation := aView newAnimation 
		easing: RSEasing cubicInOut;
		range: self alphaRange reversed;
		duration: 2 seconds;
		onStepDo: [ :t | layout alpha: t; step  ];
		yourself
]
