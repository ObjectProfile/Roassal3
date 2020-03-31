"
I have a canvas monitor
"
Class {
	#name : #RSGraphCanvasMonitor,
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
RSGraphCanvasMonitor >> box [
	^ RSBox new
		extent: 100@ 50;
		color: Color lightGray trans;
		cornerRadius: 5;
		yourself.
]

{ #category : #defaults }
RSGraphCanvasMonitor >> defaultLabel [
	^ RSLabel new
		bold;
		text: '';
		position: 25 @ 15;
		color: Color blue;
		yourself
]

{ #category : #defaults }
RSGraphCanvasMonitor >> defaultPolygon [
	^ RSPolygon new
		paint: ((LinearGradientPaint fromArray:
				{0  -> Color red trans.
				0.5 -> Color orange trans.
				1   -> Color green trans. } )
			start: 0@25;
			stop: 0@ -20;
			yourself);
		cornerRadii: 5;
		yourself
]

{ #category : #defaults }
RSGraphCanvasMonitor >> defaultPolyline [
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
RSGraphCanvasMonitor >> initialize [
	polyScale := NSScale linear
		domain: { 1@0. 100@65 };
		range: { -50 @ 25. 50@ -25 }.
	frames := OrderedCollection new.
	super initialize.
	
	
]

{ #category : #initialization }
RSGraphCanvasMonitor >> initializeShape [
	shape := RSShapeFactory composite
		noPaint;
		shapes: { self box. self polygon. self  polyline. self label};
		padding: 5;
		yourself
]

{ #category : #accessing }
RSGraphCanvasMonitor >> label [
	^ label ifNil: [ label := self defaultLabel ]
]

{ #category : #accessing }
RSGraphCanvasMonitor >> polygon [
	^ polygon ifNil: [ polygon := self defaultPolygon ]
]

{ #category : #accessing }
RSGraphCanvasMonitor >> polyline [
	^ polyline ifNil: [ polyline := self defaultPolyline ]
]

{ #category : #update }
RSGraphCanvasMonitor >> updateShape [
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
