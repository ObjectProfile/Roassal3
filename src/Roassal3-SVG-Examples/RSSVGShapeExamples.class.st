Class {
	#name : #RSSVGShapeExamples,
	#superclass : #RSShapeExamples,
	#category : #'Roassal3-SVG-Examples'
}

{ #category : #examples }
RSSVGShapeExamples >> example21SpockLizard [
	<script: 'self new example21SpockLizard open'>
	| canvas radius paint arrow relations color lb |
	canvas := RSCanvas new.
	radius := 1500.
	paint := LinearGradientPaint fromArray: {(0 -> 'E0BA82'). (1 -> 'F4DFA5')}.
	paint start: -900 @ 900; stop: 900 @ -900.
	canvas addShape: (RSEllipse new
		noPaint;
		border: (RSBorder new 
			width: 300; 
			paint: paint;
			yourself);
		radius: 1500;
		yourself).
	arrow := RSShapeFactory triangle
		extent: 380 @ 200;
		color: '36C5B8';
		yourself.
	1 to: 5 do: [ :i | 
		| angle a |
		angle := i * 360 / 5 + 45.
		canvas addShape: (RSPieSlice new
			color: '36C5B8';
			innerRadius: 1350;
			externalRadius: 1650;
			alphaAngle: angle;
			betaAngle: (angle := angle + 15)).
		a := arrow copy.
		a matrix rotateByDegrees: angle negated.
		angle := (angle + 3) degreesToRadians.
		a position: angle cos @ angle sin negated * radius.
		canvas addShape: a ].
	
	canvas addAll: (#('paper' 'scissors' 'spock' 'lizard' 'rock') 
		collectWithIndex: [:m :index|
			| com ang circle hand |
			ang := index * Float twoPi / 5 - Float halfPi.
			hand := RSSVGPath new
				svgPath: (self perform: m asSymbol).
			circle := RSEllipse new 
				color: Color white;
				position: hand position;
				size: (hand extent x max: hand extent y);
				yourself.
		
			com := RSComposite new
				popup;
				draggable;
				model: m;
				shapes: { circle. hand };
				position: ang cos @ ang sin * radius
				yourself.
			index = 5 ifTrue: [ com scaleBy: 2 ].
			com
		]).
	relations := {('scissors' -> 'lizard').
	('lizard' -> 'paper').
	('paper' -> 'spock').
	('spock' -> 'rock').
	('rock' -> 'scissors')}.
	color := NSScale category20c.
	RSEdgeBuilder bezier
		controlPointsController: (RSBlockCPController new
			block: [ :aLine | 
				| vec f t a b |
				a := aLine from position.
				b := aLine to position.
				vec := b - a.
				f := vec * 0.25 + a.
				t := vec * 0.75 + a.
				Array with: f with: 0@0 with: t ];
			yourself);
		canvas: canvas;
		useAssociations: relations.
	canvas edges do: [ :ed | | col |
		col := color scale: ed.
		ed
			border: (RSBorder new
				width: 300;
				color: col;
				yourself);
			markerEnd: ((arrow copy 
				color: col
				yourself) asMarker
				offset: -90;
				yourself)  ].  
	lb := RSLegend new.
	lb defaultLabel fontSize: 50.
	lb container: canvas.
	lb leyendDo: [ :l |l withBorder;padding: 50 ].
	lb
		text:
			'... It''s very simple. Scissors cuts paper, paper covers rock, rock crushes lizard, lizard poisons Spock, Spock smashes scissors, ';
		text:
			'scissors decapitates lizard, lizard eats paper, paper disproves Spock, Spock vaporizes rock, and, as it always has, rock crushes scissors';
		build.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSSVGShapeExamples >> example28SVGShape [
	<script: 'self new example28SVGShape open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSSVGPath new
		paint: nil;
		withBorder;
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color red);
		svgPath: 'M 100 350 l 150 -300';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color red);
		svgPath: 'M 250 50 l 150 300';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color green);
		svgPath: 'M 175 200 l 150 0';
		yourself).
	c showEncompassingRectangles.
	c zoomToFit.
	^ c
]
