Class {
	#name : #RSSVGExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-SVG-Examples'
}

{ #category : #examples }
RSSVGExamples >> example21SpockLizard [
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
RSSVGExamples >> example28SVGShape [
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

{ #category : #examples }
RSSVGExamples >> example30SVGIcons [
	<script: 'self new example30SVGIcons open setLabel: ''Icons'''>
	| canvas shapes color r theta |
	canvas := RSCanvas new.
	r := Random new.
	color := RSGradientPalette gradient21.
	color range at: 1 put: RSGradientPalette trueSunset.
	theta := (1 to: 3) collect: [:i | r next * Float twoPi ].
	
	shapes := #(america puzzlePiece supermarketCart) collectWithIndex: [ :m :index |
		| grad |
		grad := (color scale: m)
			start: -20 asPoint;
			stop: 20 asPoint.
		RSSVGPath new
			draggable;
			index: index;
			svgPath: (self perform: m);
			position: (r next * 50)@ (r next * 50) - 25;
			color: grad;
			yourself ].
	canvas addAll: shapes.
	canvas newAnimation repeat onStepDo: [:t | 
		shapes do: [:shape | | p ang ext block | 
			p := shape position.
			ext := shape extent / 2.
			ang := theta at: shape index.
			block := [ 
				ang := Float pi / 4 + ang.
				p := (ang cos@ ang sin) * 1.5 + shape position. ].
			p := (ang cos@ ang sin) * 1.5 + p.
			(p x + ext x) > 50 ifTrue: block.
			(p y + ext y)  > 50 ifTrue: block.
			(p x - ext x) < -50 ifTrue: block.
			(p y - ext y) < -50 ifTrue: block.
			theta at: shape index put: ang.
			shape position: p.
			 ] ].
	canvas addShape: (RSBox new
		extent: 100@100;
		noPaint;
		withBorder).
	canvas 
		when: RSExtentChangedEvent 
		do: [ canvas camera zoomToFit: canvas extent extent: 100 asPoint ].
	^ canvas
	
]

{ #category : #examples }
RSSVGExamples >> example31Miku [
	<script: 'self new example31Miku open setLabel: ''Miku'''>
	| random canvas lines easing |
	random := Random new.
	canvas := RSCanvas new.
	lines := RSAnimationExamples new miku lines.
	lines := (0 to: lines size / 2 - 1)
		collect: [ :i | (lines at: i * 2 + 1) -> (lines at: i * 2 + 2) ].
	canvas addAll: (lines collectWithIndex: [ :line :index |
		RSSVGPath new
			draggable;
			index: index;
			svgPath: line key;
			color: line value;
			yourself ] ).
	canvas @ RSCanvasController.
	easing := RSEasing elasticOut.
	canvas nodes do: [ :e | | position |
		position := (random next * 1000) @ (random next * 1000) - 100.
		canvas newAnimation
			easing: easing;
			delay: (e index * 50) milliSeconds;
			from: position;
			to: e position;
			duration: 5 seconds;
			on: e shape set: #position:.
			e position: position ].
	canvas addShape: (RSLabel new
		text: 'Roassal';
		fontName: 'Marker Felt';
		noPaint;
		border: (RSBorder new color: Color transparent; width: 1.5);
		fontSize: 100;
		position: 320 @ 630).
	canvas newAnimation
		delay: 6 seconds;
		duration: 3 seconds;
		from: Color transparent;
		to: Color black;
		on: canvas shapes last border set: #color:.
	^ canvas
]

{ #category : #examples }
RSSVGExamples >> example44Boat [
	<script: 'self new example44Boat open'>
	| canvas perlin frame scale lines boat x pharo g updateLines |
	canvas := RSCanvas new.
	canvas color: Color pink.
	perlin := NSPerlinNoise2 new.
	frame := 0.
	"perlin octaves: 3."
	scale := 20.
	lines := (1 to: 25) collect: [ :i |
		RSPolyline new
			"width: i log;"
			yourself ] as: RSGroup.
	g := RSGroup new.
	g add: (RSSVGPath new
		svgPath:'M254.4,440.8c0,2.4-2.4,4.8-4.8,4.8l0,0c-2.4,0-4.8-2.4-4.8-4.8V24c0-2.4,2.4-4.8,4.8-4.8l0,0c2.4,0,4.8,2.4,4.8,4.8V440.8z';
		color: '788787').
	g add: (RSSVGPath new
		svgPath: 'M9.6,418.4c10.4,45.6,113.6,80.8,240,80.8s229.6-36,240-80.8H9.6z';
		color: '9E6226').
	g add: (RSSVGPath new
		svgPath: 'M17.6,434.4c4.8,6.4,12,12.8,20,18.4h423.2c8.8-5.6,15.2-12,20-18.4H17.6z';
		color: 'AF7643').
	g add: (RSSVGPath new
		svgPath: 'M367.2,488c24-4.8,44.8-11.2,63.2-18.4H68.8c17.6,7.2,39.2,13.6,63.2,18.4H367.2z';
		color: 'AF7643').
	g add: (RSSVGPath new
		svgPath:'M497.6,414.4c0,2.4-2.4,4.8-4.8,4.8H6.4c-3.2,0-4.8-2.4-4.8-4.8l0,0c0-3.2,2.4-4.8,4.8-4.8H492C495.2,409.6,497.6,411.2,497.6,414.4L497.6,414.4z';
		color: 'AF7643').
	g add: (RSEllipse new
		position: 249.6@ 18.4; radius: 18.4;
		color: '788787').	
	g add: (RSSVGPath new
		svgPath: 'M454.4,371.2c0-7.2,0.8-14.4,0.8-22.4c0-166.4-84.8-302.4-189.6-305.6v328H454.4z';
		color: '0C91C4').
	g add: (RSSVGPath new
		svgPath: 'M454.4,371.2c0-7.2,0.8-14.4,0.8-22.4c0-166.4-84.8-302.4-189.6-305.6';
		color: '22B3E0').
	g add: (RSPolygon new
		points: {232.8@43.2. 144.8@87.2. 232.8@130.4};
		color: 'FFAE0B').
	g add: (RSPolygon new
		points: {232.8@80.8. 144.8@87.2. 232.8@130.4};
		color: 'FF860D').
	g add: (RSPolygon new
		points: {231.2@144.8. 231.2@363.2. 89.6@363.2};
		color: 'E00E0E').
	g add: (RSPolygon new
		points: {231.2@198.4. 231.2@363.2. 89.6@363.2};
		color: 'BF1111').

	boat := RSComposite new shapes: g; yourself.
	x := 1.
	updateLines := [ 
		lines doWithIndex: [:line :m |
			| points |
			points := (1 to: 200) collect: [ :i | | y |
				y := (perlin snoise: (i+ frame)/scale and: (m + frame) / scale) * 20.
				i @ (7* m + y)].
			line controlPoints: points ] ].
	updateLines value.
	canvas newAnimation
		repeat; 
		onStepDo: [ :t | 
			| cp p1 p2 vector |
			frame := frame + 0.5.
			updateLines value.
			cp := (lines at: lines size / 2) controlPoints.
			x := x + 0.3.
		
			(x between: 1 and: cp size - 1)
				ifFalse: [ x := cp size - 1 ].
			p1 := cp at: x.
			p2 := cp at: x + 1.
			vector := p2 - p1.
			boat matrix
				loadIdentity;
				rotateByRadians: vector angle;
				scaleBy: 0.025;
				translation: x @ p1 y.
			canvas signalUpdate. ].
	canvas addAll: lines.
	pharo := RSBitmap new
		form: (self iconNamed: #pharo);
		yourself.
	canvas zoomToFit.
	canvas camera scale: 2.5.
	canvas add: pharo.
	canvas add: boat.
	RSLocation new 
		inner; bottom; right;
		move: pharo on: lines.
	^ canvas
]

{ #category : #examples }
RSSVGExamples >> example46RoassalIcon [
	<script: 'self new example46RoassalIcon open'>
	| c newEllipse paint eAnimation |
	c := RSCanvas new.
	newEllipse := [ RSEllipse new
		color: 'E83A54';
		radius: 0;
		yourself].
	paint := (LinearGradientPaint 
		fromArray: { 0-> '25B4AF'. 1-> '0088AC'})
		start: 28.879@143.392;
		stop: 272.3663@143.392.
	c 
		addShape: (RSSVGPath new 
			noPaint;
			border: (RSBorder new paint: paint; width: 21);
			svgPath: 'M77,24.4v243.9
			M264.2,232.3c0,0-24.1,30-51.7,30C144.3,262.3,174,113,77,113c-18.5,0-37.6,12.6-37.6,30
		c0,16,11.8,28,38.3,28s115.7-10.7,115.7-77.1c0-53.9-45.7-69.5-116.5-69.5c-11.8,0-21.8,1.4-30.1,3.4c-4.6,1.1-8.7,2.4-12.3,3.8');
		addShape: (newEllipse value position: 264.2@232.3);
		addShape: (newEllipse value position: 143.6@158.1);
		addShape: (newEllipse value position: 77@268.4);
		addShape: (newEllipse value position: 34.6@31.6).
	c newAnimation
		from: 0; to: 1000;
		duration: 10 seconds;
		onStepDo: [ :t |
			c shapes first border dashArray: {t. 10000}.
			c signalUpdate ].
	eAnimation := [ :duration :shape | 
		c newAnimation 
			duration: duration milliSeconds;
			when: RSAnimationEndEvent do: [ 
				c newAnimation
					from: 0;
					to: 20.4;
					easing: RSEasing elasticOut;
					on: shape set: #radius:.  ] ].
	eAnimation value: 1 value: c shapes second.
	eAnimation value: 2000 value: c shapes third.
	eAnimation value: 2500 value: c shapes fourth.
	eAnimation value: 7500 value: c shapes fifth.
	c @ RSCanvasController.
	^ c
]

{ #category : #examples }
RSSVGExamples >> example48Corona [
	<script: 'self new example48Corona open'>
	| canvas extent mainScale curveScale yscale color axis title ytitle xtitle lineTitle line curve normalY spoint |
	canvas := RSCanvas new.
	extent := 500@250.
	mainScale := NSScale linear
		domain: {0@0. 100@100};
		range: {0@extent y. extent x@ 0}.
	curveScale := NSScale linear
		domain: #(0 0.5 1);
		range: #(50 90 50).
	yscale := NSScale linear
		domain: #(40 100);
		range: #(500 40).
	color := NSScale linear
		domain: #(40 80 100);
		range: { Color red. Color orange. Color green }.
	axis := RSPolyline new
		controlPoints:  ({ 0@100. 0@0. 100@0} collect: [:p| mainScale scale: p]);
		markerStartEnd: (RSShapeFactory arrow
			extent: 10@15;
			color: Color black);
		yourself.
	title := RSLabel new
		text: 'Simulation';
		bold;
		fontSize: 20;
		position: (mainScale scale: 50@100);
		yourself.
	ytitle := RSLabel new
		text: 'Number of cases';
		bold;
		position: (mainScale scale: -3@ 50);
		rotateByDegrees: -90;
		yourself.
	xtitle := RSLabel new
		text: 'Time';
		bold;
		position: (mainScale scale: 50@ -7);
		yourself.
	lineTitle := RSLabel new
		text: 'Heal care system capacity';
		bold;
		position: (mainScale scale: 75@ 30);
		yourself.
	line := RSLine new
		startPoint: (mainScale scale: 0@20);
		dashArray: #(10);
		endPoint: (mainScale scale: 100@20);
		yourself.
	curve := RSSVGPath new withBorder.
	normalY := [ :x :mean :std |
		(-0.5 * (2* Float pi) log - std log -
		 ( ((x - mean) raisedTo: 2) / (2 * std * std))) exp].
	spoint := [ :s :p | s << p x asFloat asString; space; << p y asFloat asString ].
	canvas newAnimation
		repeat;
		duration: 10 seconds;
		scale: curveScale;
		onStepDo: [ :t | 
			| low upp mean stdDev series y first |
			low := 0.
			upp := t.
			mean := (low + upp) / 2.
			stdDev := (upp - low) / 4.
			first := nil.
			series := (low to: upp) collect: [ :x | 
				y := normalY value: x value: mean value: stdDev.
				y := y * (yscale scale: t).
				first ifNil: [ first := y ].
				mainScale scale: x @ (y - first ) ].
			curve svgPath: (String streamContents: [ :s |
				s << 'M'.
				spoint value: s value: (mainScale scale: 0@0).
				series do: [ :p | s << 'L'. spoint value: s value: p ].
				s << 'L'.
				spoint value: s value: series last x@ 250.
				s << 'Z' ]).
			
			curve paint: (color scale: t).
			canvas signalUpdate.
			].
	canvas add: axis.
	canvas add: title.
	canvas add: ytitle.
	canvas add: xtitle.
	canvas add: curve. 
	canvas add: line.
	canvas add: lineTitle.
	canvas @RSCanvasController.
	^ canvas

]

{ #category : #examples }
RSSVGExamples >> example51AnimatedSVG [
	| monsterPath monster c |
	monsterPath := 'M256,200.348c-30.736,0-55.652,24.917-55.652,55.652s24.917,55.652,55.652,55.652s55.652-24.917,55.652-55.652
			S286.736,200.348,256,200.348z M272.696,256c-9.208,0-16.696-7.492-16.696-16.696c0-9.204,7.487-16.696,16.696-16.696
			c9.208,0,16.696,7.492,16.696,16.696C289.391,248.508,281.904,256,272.696,256zM418.265,117.344l22.177-22.179c6.529,3.119,13.752,5.009,21.471,5.009c27.662,0,50.087-22.424,50.087-50.087
			S489.576,0,461.913,0s-50.087,22.424-50.087,50.087c0,7.718,1.89,14.94,5.009,21.471L389.092,99.3
			C350.286,78.679,304.711,66.783,256,66.783S161.714,78.679,122.909,99.3L95.165,71.558c3.119-6.53,5.009-13.753,5.009-21.471
			C100.174,22.424,77.749,0,50.087,0S0,22.424,0,50.087s22.424,50.087,50.087,50.087c7.718,0,14.94-1.89,21.471-5.009l22.177,22.177
			C36.543,158.204,0,220.156,0,289.391C0,412.135,114.843,512,256,512s256-99.865,256-222.609
			C512,220.156,475.457,158.204,418.265,117.344z M322.783,445.217H200.348c-9.223,0-16.696-7.473-16.696-16.696
			c0-9.223,7.473-16.696,16.696-16.696h122.435c9.223,0,16.696,7.473,16.696,16.696
			C339.478,437.744,332.005,445.217,322.783,445.217z M256,378.435c-67.51,0-122.435-54.934-122.435-122.435
			S188.489,133.565,256,133.565c67.511,0,122.435,54.934,122.435,122.435S323.511,378.435,256,378.435z'.
	monster := RSSVGPath new svgPath: monsterPath.
	c := RSCanvas new.
	c add: monster.
	c newAnimation repeat
		duration: 0.1 seconds;
		when: RSAnimationLoopEvent
			do: [ :evt | monster rotateByDegrees: 5 ].
	c @ RSCanvasController.
	^ c
]
