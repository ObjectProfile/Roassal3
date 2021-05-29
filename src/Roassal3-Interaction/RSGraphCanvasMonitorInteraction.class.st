"
I have a canvas monitor
"
Class {
	#name : #RSGraphCanvasMonitorInteraction,
	#superclass : #RSAbstractCanvasMonitor,
	#instVars : [
		'polyline',
		'label',
		'frames',
		'polyScale',
		'polygon'
	],
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #accessing }
RSGraphCanvasMonitorInteraction >> box [
	^ RSBox new
		extent: 100@ 50;
		color: Color lightGray translucent;
		cornerRadius: 5;
		yourself.
]

{ #category : #defaults }
RSGraphCanvasMonitorInteraction >> defaultLabel [
	^ RSLabel new
		bold;
		text: '';
		position: 25 @ 15;
		color: Color blue;
		yourself
]

{ #category : #defaults }
RSGraphCanvasMonitorInteraction >> defaultPolygon [
	^ RSPolygon new
		paint: ((LinearGradientPaint fromArray:
				{0  -> Color red translucent.
				0.5 -> Color orange translucent.
				1   -> Color green translucent. } )
			start: 0@25;
			stop: 0@ -20;
			yourself);
		cornerRadii: 5;
		yourself
]

{ #category : #defaults }
RSGraphCanvasMonitorInteraction >> defaultPolyline [
	^ RSPolyline new
		controlPoints: #();
		border: (RSBorder new
			paint: ((LinearGradientPaint fromArray:
					{0  -> 'red'.
					0.5 -> 'orange'.
					1   -> 'gree'})
				start: 0@25;
				stop: 0@ -20;
				yourself))
]

{ #category : #initialization }
RSGraphCanvasMonitorInteraction >> initialize [
	polyScale := NSScale linear
		domain: { 1@0. 100@65 };
		range: { -50 @ 25. 50@ -25 }.
	frames := OrderedCollection new.
	super initialize.
	
	
]

{ #category : #initialization }
RSGraphCanvasMonitorInteraction >> initializeShape [
	shape := RSShapeFactory composite
		noPaint;
		shapes: { self box. self polygon. self  polyline. self label};
		padding: 5;
		yourself
]

{ #category : #accessing }
RSGraphCanvasMonitorInteraction >> label [
	^ label ifNil: [ label := self defaultLabel ]
]

{ #category : #accessing }
RSGraphCanvasMonitorInteraction >> polygon [
	^ polygon ifNil: [ polygon := self defaultPolygon ]
]

{ #category : #accessing }
RSGraphCanvasMonitorInteraction >> polyline [
	^ polyline ifNil: [ polyline := self defaultPolyline ]
]

{ #category : #update }
RSGraphCanvasMonitorInteraction >> updateShape [
	| cp |
	frames add: self lastFramePerSecond.
	
	frames size > shape shapes first extent x
		ifTrue: [ frames removeFirst ].
	self label text: frames last asString, 'fps'.
	frames first = 1000 ifTrue: [ frames removeFirst ].
	cp := frames collectWithIndex: [ :frame :i |
		polyScale scale: i @ frame ].
	self polyline controlPoints: cp.
	cp := cp copy.
	cp 
		add: (polyScale scale: cp size @ 0);
		add: (polyScale scale: 1@0).
	self polygon points: cp
]
