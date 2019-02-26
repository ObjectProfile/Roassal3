"
I have the basic examples for shapes
"
Class {
	#name : #TrachelShapeExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #'box and ellipses' }
TrachelShapeExamples >> example01Basic [
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
TrachelShapeExamples >> example02Basic [
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
TrachelShapeExamples >> example03Basic [
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
TrachelShapeExamples >> example04Basic [
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
TrachelShapeExamples >> example05Basic [
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
TrachelShapeExamples >> example06Basic [
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
		color: nil;
		border: TSBorder new;
		radius: 90).
	c open
	



]

{ #category : #events }
TrachelShapeExamples >> example07Basic [
	<script: 'self new example07Basic'>

	| c ellipse a b drag update |
	c := TSCanvas new.
	ellipse := TSEllipse new
		radius: 40;
		border: TSBorder new.
	c addShape: ellipse.
	a := Color colorFrom: '12A288'.
	b := Color colorFrom: 'AB2567'.
	drag := false.
	update := [ :evt |
		ellipse 
			color: (drag ifTrue: [ a ] ifFalse: [b ]);
			position: evt position.
		c signalUpdate ].
	c
		when: TSMouseMove do: [ :evt | update value: evt.  ];
		when: TSMouseDragStart do: [ :evt| drag := true. ];
		when: TSMouseDragEnd do: [ :evt | drag := false. ].
	c clearBackground: false.
	
	c open.
	
]

{ #category : #'box and ellipses' }
TrachelShapeExamples >> example08Basic [
	<script: 'self new example08Basic'>

	| c y r m |
	c := TSCanvas new.
	r := SharedRandom globalGenerator.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (TSEllipse new
			color: Color transparent;
			border: (TSBorder new
				width: x/ 50;
				color: (Color 
					r: r next * 255 
					g: r next * 200
					b: 255
					range: y) );
			position: (x*2@y)-250;
			extent: (y/10)@( x * 75/ 499 ) ).
		 ].
	m := c morph.
	PolymorphSystemSettings setDesktopLogoWith: m.
	m position: 0@World menubar height.
	m extent: World extent- (0@World menubar height).
	c open
]

{ #category : #events }
TrachelShapeExamples >> example09Basic [
	<script: 'self new example09Basic'>

	|  c e prev dif |
	c := TSCanvas new.
	c color: Color black.
	e := TSEllipse new
		border: (TSBorder new color: Color white);
		radius: 0.
	c addShape: e.
	prev := 0.
	c when: TSMouseMove do: [ :evt | 
		dif := (evt position x - prev) abs.
		prev := evt position x.
		e 
			color: (Color r: 0 g: dif b: 0 range: 255);
			position: evt position;
			size: dif.
		c signalUpdate.
		 ].
	c clearBackground: false.
	c open.
]

{ #category : #events }
TrachelShapeExamples >> example10Basic [
	<script: 'self new example10Basic'>

	| c border circleResolution angle a b radius |
	c := TSCanvas new.
	c color: Color white.
	border := TSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c when: TSMouseMove do: [ :evt | 
		circleResolution := b.
		circleResolution isZero ifTrue: [ circleResolution := 1 ].
		angle := Float twoPi / circleResolution.
		a := 175 * evt position x / c extent x.
		b := 200 * evt position y / c extent y.
		c shapes copy do: #remove.
		0 to: circleResolution do: [ :i |
			c addShape: (TSEllipse new 
				color: Color transparent;
				rotateByDegrees: 45;
				border: border;
				extent: ((angle * i) cos @ (angle * i) sin) * radius + a
			)].
		
		c signalUpdate.
		 ].
	c open.
]

{ #category : #events }
TrachelShapeExamples >> example11Basic [
	<script: 'self new example11Basic'>

	| c easing canvasExtent boxSize zindex maxDist scale border |
	c := TSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 dist: canvasExtent.
	scale := TSScale linear 
		domain: { 0. maxDist}; 
		rangeRound: #(80 0).
	border := TSBorder new.
	c when: TSResizeCanvasEvent do: [ 
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 dist: canvasExtent.
		scale := TSScale linear 
			domain: { 0. maxDist}; 
			rangeRound: #(80 0).
		0 to: canvasExtent y/boxSize do: [ :y|
			0 to: canvasExtent x/boxSize do: [ :x| 
				c addShape: (TSBox new 
					color: Color white;
					position: ((x@y)*boxSize) - (canvasExtent/2);
					extent: 10@10;
					border: border )
				] ]
		].
	c when: TSMouseMove do: [ :evt | 
		easing := easing + ((evt position - easing)* 0.1).
		c shapes copy do: [ :s |
			zindex := scale scale: (easing dist: s position).
			s extent: boxSize * (zindex /100) asPoint ].
		c signalUpdate.
	].
	c clearBackground: false.
	c open.
]

{ #category : #lines }
TrachelShapeExamples >> example12Basic [
	<script: 'self new example12Basic'>

	| c |
	c := TSCanvas new.
	c addShape: TSLine new.
	c open.
]

{ #category : #lines }
TrachelShapeExamples >> example13Basic [
	<script: 'self new example13Basic'>

	| c box paint form border |
	c := TSCanvas new.
	form := self iconNamed: #eyedropper.
	paint := (AthensCairoPatternSurfacePaint 
		createForSurface: (AthensCairoSurface 
			fromForm: form)).
	paint origin: (form extent / 2) negated.
	border := TSBorder new
		color: Color purple;
		width: 1;
		dashArray: #(4).
	box := TSBox new
		paint: paint;
		extent: form extent;
		border: border;
		scaleBy: 3.
	
	c addShape: box.
	
	c animation
		repeat;
		from: 0;
		to: 8;
		on: border set: #dashOffset:.
	c open.
	




]

{ #category : #lines }
TrachelShapeExamples >> example14Basic [
	<script: 'self new example14Basic'>

	
]
