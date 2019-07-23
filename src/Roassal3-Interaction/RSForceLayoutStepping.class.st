"
Hi!, I can control the RSForceBaseLayout step method, in order to use it only when it needs
"
Class {
	#name : #RSForceLayoutStepping,
	#superclass : #RSInteraction,
	#instVars : [
		'layout',
		'animation'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSForceLayoutStepping >> addEventsTo: el [
	| mock |
	el 
		when: TSMouseDragStart do: [ :evt | 
			mock := layout mockElementAt: el.
			mock isFixed: true.
			self startForceAnimation: el view ];
		when: TSMouseDragging do: [ :evt |
			mock fixPosition: el position ];
		when: TSMouseDragEnd do:[:evt | 
			mock isFixed: false.
			mock := nil.
			self startSimpleAnimation: el view ].
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
RSForceLayoutStepping >> onElement: aView [
	aView elements do: [ :e | self addEventsTo: e ].
	self startSimpleAnimation: aView.
	aView newAnimation onStepDo: [:t| aView zoomToFit ].
]

{ #category : #animation }
RSForceLayoutStepping >> startForceAnimation: aView [
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
RSForceLayoutStepping >> startSimpleAnimation: aView [
	animation ifNotNil: #stop.
	animation := aView newAnimation 
		easing: TSEasing cubicInOut;
		range: self alphaRange reversed;
		duration: 2 seconds;
		onStepDo: [ :t | layout alpha: t; step  ];
		yourself
]
