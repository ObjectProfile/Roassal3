"
I put a scrool shapes to the view when the view moves
"
Class {
	#name : #RSScrollsView,
	#superclass : #RSAbstractControlView,
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
RSScrollsView >> addScrollBars: aView [
	vertical := barShape element trachelShape.
	horizontal := barShape element trachelShape.
	aView addShape: vertical; addShape: horizontal.
	
]

{ #category : #private }
RSScrollsView >> color: color1 border: color2 [
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
		borderColor: c2.
]

{ #category : #initialization }
RSScrollsView >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
RSScrollsView >> initializeHideAnimation [
	| sc1 sc2 |
	sc1 := TSScale linear range: { self scrollColor. Color transparent }.
	sc2 := TSScale linear range: { self scrollBorderColor. Color transparent }.
	hideAnimation := vertical parent tAnimation
		duration: 1 second;
		onStepDo: [ :t | 
			self 
				color: (sc1 scale: t) 
				border: (sc2 scale: t) ] 
]

{ #category : #initialization }
RSScrollsView >> initializeShape [
	barShape := RSShapeBuilder box
		cornerRadius: (TSCornerRadius new radius: 5);
		border: [TSBorder new color: self scrollBorderColor; width: 0.5];
		size: 10;
		noPaint;
		isFixed: true;
		when: TSMouseDragging do: [ :e | [:evt| self moveScroll: evt ] ];
		when: TSMouseEnter do: [ :e | [ :evt| | shape |
			self updateScrollbars.
			shape := evt shape.
			shape color isTransparent 
				ifFalse: [ shape color: (self scrollColor alpha: 1) ].
			animation stop.
			hideAnimation stop. ] ];
		when: TSMouseLeave do: [ :e | [ :evt| | shape |
			shape := evt shape.
			shape color isTransparent 
				ifFalse: [ shape color: self scrollColor ].
			self removeRectanglesFor: evt view.
			vertical parent addAnimation: animation ] ]
]

{ #category : #hooks }
RSScrollsView >> moveScroll: evt [
	| shape delta position camera viewExtent shapesRect correct |
	shape := evt shape.
	delta := evt step.
	delta := shape = vertical trachelShape
		ifTrue: [ 0@delta y ]
		ifFalse: [ delta x@0 ].
	shape translateBy: delta.
	viewExtent := evt canvas extent.
	shapesRect := self encompassingRectangleFor: evt view.
	position := horizontal position x @ vertical position y.
	position := position * shapesRect extent / viewExtent.
	
	camera := evt camera.
	camera position: position + shapesRect origin.
	correct := self correctCameraPosition: evt view.
	correct = camera position ifFalse: [ 
		camera position: correct.
		self updateBasicScrollbars. ].
	evt signalUpdate. 
]

{ #category : #hooks }
RSScrollsView >> onElement: aView [
	self addScrollBars: aView.
	
	aView when: TSPositionChangedEvent do: [ self updateScrollbars ].
	aView when: TSScaleChangedEvent do: [ self updateScrollbars ].
]

{ #category : #accessing }
RSScrollsView >> scrollBorderColor [
	^ Smalltalk ui theme textColor trans
]

{ #category : #accessing }
RSScrollsView >> scrollColor [
	^ Color blue trans
]

{ #category : #accessing }
RSScrollsView >> shape [
	^ barShape
]

{ #category : #hooks }
RSScrollsView >> updateAnimation [
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
		when: TSAnimationLoopEvent do: [ 
			canvas addAnimation: hideAnimation ].
]

{ #category : #hooks }
RSScrollsView >> updateBasicScrollbars [
	| canvas viewRect camera shapesRect p pd ext scrollExtent |
	canvas := vertical parent.
	camera := canvas camera. 
	viewRect := Rectangle
		rsCenter: camera position
		extent: canvas extent / camera scale.
	shapesRect := self encompassingRectangleFor: canvas view.
	
	scrollExtent := vertical width @ horizontal height.
	p := canvas extent - 1 - (scrollExtent / 2).
	
	pd := canvas extent * (viewRect rsCenter - shapesRect origin) / shapesRect extent.
	ext := viewRect extent * canvas extent / shapesRect extent.
	vertical position: p x @ pd y ; height: ext y.
	horizontal position: pd x @ p y; width: ext x.
]

{ #category : #hooks }
RSScrollsView >> updateScrollbars [
	self updateBasicScrollbars.
	self color: self scrollColor border: self scrollBorderColor.
	self updateAnimation.
	vertical signalUpdate
]
