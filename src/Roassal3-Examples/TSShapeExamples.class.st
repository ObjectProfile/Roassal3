"
I have the basic examples for shapes
"
Class {
	#name : #TSShapeExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #'box and ellipses' }
TSShapeExamples >> example01Basic [
	<script: 'self new example01Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		extent: 100@100;
		yourself).
	c addShape: (TSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example02Basic [
	<script: 'self new example02Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSEllipse new
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example03Basic [
	<script: 'self new example03Basic'>

	| c g |
	c := TSCanvas new.
	g := TSGroup new.
	g addShape: (TSBox new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	g addShape: (TSBox new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
		
	c addShape: g.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example04Basic [
	<script: 'self new example04Basic'>

	| c g |
	c := TSCanvas new.
	g := TSGroup new.
	g addShape: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	g addShape: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
	g position: 100@100.
	
	c addShape: g.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example05Basic [
	<script: 'self new example05Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	c addShape: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
		
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #labels }
TSShapeExamples >> example06Basic [
	<script: 'self new example06Basic'>

	| c label |
	c := TSCanvas new.
	1 to: 12 do: [ :m | 
		| angle theta p|
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := TSLabel new
			color: (Color purple alpha: 0.5);
			fontSize: 20;
			text: (Month nameOfMonth: m);
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270) 
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).
		
		label rotateByDegrees: angle..
		label position: p + ((label textWidth/2) * theta).
		m even
			ifTrue: [ label bold ]
			ifFalse: [ label italic ].
		c addShape: label.
		].
	c addShape: (TSEllipse new
		radius: 90).
	c open
	



]

{ #category : #events }
TSShapeExamples >> example07Basic [
	<script: 'self new example05Basic'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	c addShape: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
		
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]
