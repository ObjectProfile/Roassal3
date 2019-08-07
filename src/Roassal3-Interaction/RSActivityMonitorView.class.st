"
I am an interaction for RSView, I can add to the a fixed shape that contains basic information about

Frames per second, this number show the quantity of frames rendered. useful to debug animations
"
Class {
	#name : #RSActivityMonitorView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'shape',
		'lastFrameEndTime'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
RSActivityMonitorView >> currentTime [
	 ^ Time microsecondClockValue
]

{ #category : #initialization }
RSActivityMonitorView >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
RSActivityMonitorView >> initializeGraphShape [
	| frames polyScale |
	frames := OrderedCollection new.
	polyScale := TSScale linear
		domain: {1@0. 100 @ 65 };
		range: { -50@ 25. 50@ -25}.
	shape := RSShapeBuilder composite
		noPaint;
		shapes: [ | g |
			g := TSGroup new.
			g add: (TSBox new
				extent: 100@50;
				color: Color lightGray trans;
				cornerRadius: 5).
			g add: (TSPolyline new 
				controlPoints: #();
				border: (TSBorder new paint: ((TSGradientPalette 
					linearGradient:
						{0 -> 'red'.
						0.5 -> 'orange'.
						1 -> 'green'})
					start: 0@ 25;
					stop: 0 @ -20))).
			g add: (TSLabel new
				bold;
				position: 25@15;
				color: Color blue).
			g ];
		padding: 5;
		onMyselfDo: [[:e | 
			frames add: self lastFramePerSecond.
			
			frames size > e shapes first extent x 
				ifTrue: [ frames removeFirst. ].
			e shapes last text: frames last asString, 'fps'.
			frames first = 1000 ifTrue: [ frames removeFirst ].
			e shapes second controlPoints: (frames collectWithIndex: [ :frame :i | polyScale scale: i@ frame ] ).
	] ].
		
]

{ #category : #initialization }
RSActivityMonitorView >> initializeShape [
	shape := RSShapeBuilder label
		color: Color green;
		onMyselfDo: [[:e | e text: self lastFramePerSecond asString, 'fps' ] ].
		
]

{ #category : #accessing }
RSActivityMonitorView >> lastFrameCPUConsumption [
	| res current |
	current := self currentTime.
	lastFrameEndTime ifNil: [ 
		lastFrameEndTime := current ].
	res := (current - lastFrameEndTime) * 1e-6.
	lastFrameEndTime := current.
	^ res
]

{ #category : #accessing }
RSActivityMonitorView >> lastFramePerSecond [
	| delta |
	delta := self lastFrameCPUConsumption.
	^ (1.0 / (delta max: 0.001) ) asInteger
]

{ #category : #hooks }
RSActivityMonitorView >> onElement: aView [
	| monitor location |
	monitor := shape element.
	monitor isFixed: true.
	aView addShape: monitor shape. 
	location := RSLocation new inner; bottom; left; offset: 10@0.
	aView newAnimation
		repeat;
		onStepDo: [ :t | 
			shape updateElement: monitor withCommand: #onMyselfDo:.
			location move: monitor on: aView basicRectangle ].
]

{ #category : #accessing }
RSActivityMonitorView >> shape [
	^ shape
]

{ #category : #accessing }
RSActivityMonitorView >> shape: aShapeBuilder [
	shape := aShapeBuilder
]
