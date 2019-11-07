"
I am an interaction for RSView, I can add to the a fixed shape that contains basic information about

Frames per second, this number show the quantity of frames rendered. useful to debug animations
"
Class {
	#name : #TSActivityMonitorView,
	#superclass : #TSAbstractCanvasInteraction,
	#instVars : [
		'shape',
		'lastFrameEndTime'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #accessing }
TSActivityMonitorView >> currentTime [
	 ^ Time microsecondClockValue
]

{ #category : #initialization }
TSActivityMonitorView >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
TSActivityMonitorView >> initializeGraphShape [
	| frames polyScale |
	frames := OrderedCollection new.
	polyScale := TSScale linear
		domain: {1@0. 100 @ 65 };
		range: { -50@ 25. 50@ -25}.
	
	shape := RSShapeBuilder composite
		noPaint;
		shapes: [ | g |
			g := RSGroup new.
			g add: (TSBox new
				extent: 100@50;
				color: Color lightGray trans;
				cornerRadius: 5).
			g add: (TSPolygon new
				paint: ((TSGradientPalette 
					linearGradient:
						{0 -> Color red trans.
						0.5 -> Color orange trans.
						1 -> Color green trans})
					start: 0@ 25;
					stop: 0 @ -20);
				cornerRadii: 5).
			g add: (TSPolyline new 
				controlPoints: #();
				border: (RSBorder new paint: ((TSGradientPalette 
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
		onMyselfDo: [[:e | | cp corner1 corner2 | 
			frames add: self lastFramePerSecond.
			
			frames size > e shapes first extent x 
				ifTrue: [ frames removeFirst. ].
			e shapes last text: frames last asString, 'fps'.
			frames first = 1000 ifTrue: [ frames removeFirst ].
			e shapes third controlPoints: (cp := (frames 
				collectWithIndex: [ :frame :i | 
					polyScale scale: i@ frame ] )).
			
			corner1 := polyScale scale: 1@0.
			corner2 := polyScale scale: cp size @ 0.
			e shapes second points: (cp copy add: corner2; add: corner1; yourself)
	] ].
		
]

{ #category : #initialization }
TSActivityMonitorView >> initializeShape [
	shape := RSShapeBuilder label
		color: Color green;
		onMyselfDo: [[:e | e text: self lastFramePerSecond asString, 'fps' ] ].
		
]

{ #category : #accessing }
TSActivityMonitorView >> lastFrameCPUConsumption [
	| res current |
	current := self currentTime.
	lastFrameEndTime ifNil: [ 
		lastFrameEndTime := current ].
	res := (current - lastFrameEndTime) * 1e-6.
	lastFrameEndTime := current.
	^ res
]

{ #category : #accessing }
TSActivityMonitorView >> lastFramePerSecond [
	| delta |
	delta := self lastFrameCPUConsumption.
	^ (1.0 / (delta max: 0.001) ) asInteger
]

{ #category : #hooks }
TSActivityMonitorView >> onShape: aCanvas [
	| monitor location |
	monitor := shape element.
	monitor isFixed: true.
	aCanvas addShape: monitor shape. 
	location := RSLocation new inner; bottom; left; offset: 10@0.
	aCanvas newAnimation
		repeat;
		onStepDo: [ :t | 
			shape updateElement: monitor withCommand: #onMyselfDo:.
			location move: monitor on: aCanvas basicRectangle ].
]

{ #category : #accessing }
TSActivityMonitorView >> shape [
	^ shape
]

{ #category : #accessing }
TSActivityMonitorView >> shape: aShapeBuilder [
	shape := aShapeBuilder
]
