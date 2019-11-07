"
Hi!, I can control the RSForceBaseLayout step method, in order to use it only when it needs
"
Class {
	#name : #TSForceLayoutStepping,
	#superclass : #TSAbstractCanvasInteraction,
	#instVars : [
		'layout',
		'animation'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
TSForceLayoutStepping >> addEventsTo: el [
	| mock |
	el 
		when: RSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: el.
			mock isFixed: true.
			self startForceAnimation: el view ];
		when: RSMouseDragging do: [ :evt |
			mock fixPosition: el position ];
		when: RSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil.
			self startSimpleAnimation: el view ].
]

{ #category : #accessing }
TSForceLayoutStepping >> alphaRange [
	^ #(0 0.1)
]

{ #category : #accessing }
TSForceLayoutStepping >> layout [
	^ layout
]

{ #category : #accessing }
TSForceLayoutStepping >> layout: aRSForceBasedLayout [
	layout := aRSForceBasedLayout
]

{ #category : #hooks }
TSForceLayoutStepping >> onShape: aCanvas [
	aCanvas view elements do: [ :e | self addEventsTo: e ].
	self startSimpleAnimation: aCanvas.
	aCanvas newAnimation onStepDo: [:t| aCanvas zoomToFit ].
]

{ #category : #animation }
TSForceLayoutStepping >> startForceAnimation: aView [
	animation ifNotNil: #stop.
	animation := aView animationFrom: {
		"Start smoothly"
		aView tAnimation
			easing: TSEasing cubicOut;
			duration: 500 milliSeconds;
			range: self alphaRange;
			onStepDo: [ :t | layout alpha: t; step ].

		"Continue on max alpha undefinitely"
		aView tAnimation
			repeat;
			onStepDo: [ :t | layout step ] }.

]

{ #category : #animation }
TSForceLayoutStepping >> startSimpleAnimation: aView [
	animation ifNotNil: #stop.
	animation := aView newAnimation 
		easing: TSEasing cubicInOut;
		range: self alphaRange reversed;
		duration: 2 seconds;
		onStepDo: [ :t | layout alpha: t; step  ];
		yourself
]
