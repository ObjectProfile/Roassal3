"
I have examples for animation
"
Class {
	#name : #RSAnimationExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
RSAnimationExamples >> example01Basic [
	<script: 'self new example01Basic'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation 
		easing: TSEasing bounce;
		from: -100@ -100;
		to: 100@100;
		on: b set: #position:.
	c animation 
		from: Color red;
		to: Color blue;
		on: b set: #color:.
	c animation 
		from: 0;
		to: 10;
		on: b border set: 'width:'.
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c clearBackground: false.
	c open.
]

{ #category : #examples }
RSAnimationExamples >> example02Sequential [
	<script: 'self new example02Sequential'>
	| c b animation |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	animation := c animationFrom: { 
		(c tAnimation
			from: -100@ -200;
			to: 100@130;
			on: b set: #position:).
		(c tAnimation
			from: Color red;
			to: Color blue;
			on: b set: #color:).
		(c tAnimation 
			from: 0;
			to: 10;
			on: b border set: 'width:')
	}.
	animation
		loops: 2.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

{ #category : #examples }
RSAnimationExamples >> example03Ramp [
	<script: 'self new example03Ramp'>
	| c b |
	c := TSCanvas new.
	b := TSBox new
		extent: 100@100;
		border: TSBorder new.
	c addShape: b.
	
	c animation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)};
		on: b set: #position:.
	
	c 
		when:TSMouseClick
		do: [ c animations do: #pause ];
		when: TSMouseDoubleClick 
		do: [ c animations do: #continue ].
	c open.
]

{ #category : #examples }
RSAnimationExamples >> example04BoxWindmill [
	<script: 'self new example04BoxWindmill'>
	| v elements extent points frameCount |
	v := RSView new.
	v color: Color black.
	extent := 1920@1080.
	points := (0 to: extent x by: 50) flatCollect: [ :x |
		(0 to: extent y by: 50) collect: [ :y | (x@y)- (extent/2) ] ].
	elements := RSShapeBuilder box
		extent: 140@40;
		color: Color white;
		border: (TSBorder new
			color: (Color gray alpha: 0.5) ) ;
		elementsOn: points.
	v addAll: elements.
	frameCount := 0.
	v animation repeat;
		onStepDo: [ :t |
			elements do: [ :e | 
				e matrix 
					loadIdentity;
					translateBy: e model;
					rotateByRadians: (e model x + e model y + frameCount) degreesToRadians * 1.95  ].
			frameCount := frameCount + 1. ].
	v open.
]

{ #category : #examples }
RSAnimationExamples >> example05BoxesLineCircles [
	<script: 'self new example05BoxesLineCircles'>
	| v extent r  elements position shape alpha update updateLine lineX line |
	v := RSView new.
	r := SharedRandom globalGenerator.

	shape := RSShapeBuilder box
		paint: nil;
		border: (TSBorder new
			width: 4).
		
	elements := shape elementsOn: ((1 to: 12) collect: [:i | r next ]).
	v addAll: elements.
	
	RSNormalizer size
		from: 30;
		to: 100;
		elements: elements;
		normalize: #yourself.
	
	lineX := 0.
	line := RSEdgeBuilder line
		color: Color red;
		width: 8;
		from: 1@0; to: 0@0; edge.
	v add: line. 
	position := nil.
	updateLine := [
		line 
			from: lineX@position from y;
			to: lineX@position to y;
			update. ].
	v when: TSMouseMove do: [ :ev | 
		lineX := ev position x.
		updateLine value ].
	update := [ 
		extent := v extent.
		position := TSScale linear
			range: { extent / 2 negated. extent /2 }.
		updateLine value.
		elements do: [ :e | e translateTo: (position scale: r next@ r next) ].
	].
	update value.
	v when: TSExtentChangedEvent do: update.
	
	"shadow"
	alpha := TSScale linear domain: #(1 4); range: #(0.4 0.05).
	elements do: [ :e | | ant |
		ant := e.
		1 to: 4 do: [:i | | s |
			s := shape
				position: e position;
				extent: e extent;
				border: (TSBorder new
					width: 5;
					color: (e border color alpha: (alpha scale: i)));
				elementOn: i.
			ant when: TSPositionChangedEvent do: [ :evt | 
				s translateTo: evt oldPosition ].
			ant := s.
			v add: s
			] ] .
	"animation"
	v animation repeat; 
		onStepDo: [ :t | 
			elements do: [ :e |
				| delta newX |
				delta := e attributes at: #delta ifAbsentPut: [ 5 ].
				newX := e position x + delta.
				(newX 
					between: position from x 
					and: position to x) ifFalse: [ 
					delta := delta negated.
					newX := e position x + delta.
					 ].
				e translateTo: newX@e position y.
				e attributes at: #delta put: delta
				].
			v elements do: [ :e | | cls |
				cls := e position x > lineX 
					ifTrue: [ TSEllipse ]
					ifFalse: [ TSBox ].
				e trachelShape: cls new.
				 ].
	].
	v open.
	"87 lines of code"
]

{ #category : #examples }
RSAnimationExamples >> example05b [
	<script: 'self new example05b'>
	| v extent r elements position alpha update updateLine lineX line |
	v := RSView new.
	r := SharedRandom globalGenerator.
	elements := (1 to: 12) collect: [ :i | | e | 
		e := RSElement new
			model: r next;
			trachelShape: TSBox new;
			paint: nil;
			border: (TSBorder new width: 4);
			yourself.
		e.].
	v addAll: elements.
	RSNormalizer size
		from: 30;
		to: 100;
		elements: elements;
		normalize: #yourself.
	lineX := 0.
	line := RSEdgeBuilder line
		color: Color red;
		width: 8;
		from: 1@0; to: 0@0; edge.
	v add: line. 
	position := nil.
	updateLine := [
		line 
			from: lineX@position from y;
			to: lineX@position to y;
			update. ].
	v when: TSMouseMove do: [ :ev | 
		lineX := ev position x.
		updateLine value ].
	update := [ 
		extent := v extent.
		position := TSScale linear
			range: { extent / 2 negated. extent /2 }.
		updateLine value.
		elements do: [ :e | e translateTo: (position scale: r next@ r next) ].
	].
	update value.
	v when: TSExtentChangedEvent do: update.
	
	"shadow"
	alpha := TSScale linear domain: #(1 4); range: #(0.4 0.05).
	elements do: [ :e | | ant |
		ant := e.
		1 to: 4 do: [:i | | s |
			s := RSElement new 
				trachelShape: TSBox new;
				paint: nil;
				position: e position;
				extent: e extent;
				border: (TSBorder new
					width: 6;
					color: (e border color alpha: (alpha scale: i)));
				yourself.
			ant when: TSPositionChangedEvent do: [ :evt | 
				s translateTo: evt oldPosition ].
			ant := s.
			v add: s
			] ] .
	v animation repeat; 
		onStepDo: [ :t | 
			elements do: [ :e |
				| delta newX |
				delta := e attributes at: #delta ifAbsentPut: [ 5 ].
				newX := e position x + delta.
				(newX 
					between: position from x 
					and: position to x) ifFalse: [ 
					delta := delta negated.
					newX := e position x + delta.
					 ].
				e translateTo: newX@e position y.
				e attributes at: #delta put: delta
				].
			v elements do: [ :e | | cls |
				cls := e position x > lineX 
					ifTrue: [ TSEllipse ]
					ifFalse: [ TSBox ].
				e trachelShape: cls new.
				 ].
	].
	v open.
	"87 lines of code"
]

{ #category : #examples }
RSAnimationExamples >> example06Atom [
	<script: 'self new example06Atom'>
	| elements v border extent speed frame |
	v := RSView new.
	border := TSBorder new width: 4.
	extent := 450@110.
	elements := RSShapeBuilder ellipse
		border: border;
		extent: #yourself;
		color: nil;
		onElement;
		matrixDo: [ :e | [ :m | m rotateByRadians: e index * Float pi/4 ] ];
		if: [ :e | e index = 1 ] 
			actions: [ :s | s color: Color black ];
		elementsOn: { 40@40. extent. extent. extent. extent}.
	v addAll: elements.
	elements := RSShapeBuilder ellipse
		border: border;
		color: Color black;
		extent: 20@20;
		elementsOn: (1 to: 4).
	v addAll: elements.
	frame := 0.
	
	v animation repeat onStepDo: [ :t |
		frame := frame +1.
		speed := frame/50.
		elements do: [ :e | | ang |
			ang := speed + (e index * 90).
			e matrix
				loadIdentity;
				rotateByRadians: e index * Float pi /4;
				translateBy: (extent/2)* (ang cos @ ang sin)
			 ]
	].
		
	v when: TSExtentChangedEvent do: [ :evt | 
		v zoomToFit ].
	v open.
	
]

{ #category : #examples }
RSAnimationExamples >> example07Psycho [
	<script: 'self new example07Psycho'>
	| shape v theta slices unit color sc1 sc2 |
	v := RSView new.
	slices := 50.
	unit := Float pi * 2 / slices.
	"domain: aBoolean, range: aColor"
	color := TSScale ordinal rangeFrom: { '480D4A'. 'BB1C60' }.
	"input: a number between {-1 1} ouput: a number between 100 and 350"
	sc1 := TSScale linear domain: #(-1 1);range: { 100. 350 }.
	sc2 := TSScale linear domain: #(-1 1);range: { 350. 100 }.
	"for zoom to fit"
	v add: (RSShapeBuilder box extent: 800@800; paint: nil; element).
	theta := 0.	
	shape := RSEdgeBuilder linePath 
		onElement; 
		onMyselfDo: [ 
			[: e| e attributes at: #zn
				put: (e model even 
						ifTrue: [ sc1 scale: (e model *unit + theta) sin ]
						ifFalse: [ sc2 scale: (e model*unit - theta) sin ]).] ];
		svgPath: [ :e |
			"e is an instance of RSEdge, been created by shape"
			[ :a :b |
			"a and b are points, the vertices from this edge"
			"this block returns a block to use complex operations of Athens Canvas"
			"in this part you can also return a string, the svg path"
				[ :canvas | | angle sz |
				angle := e model* unit.
				sz := e attributes at: #zn. 
				canvas  
					moveTo: a + (sz * (angle cos@ angle sin));
					arcCenterX: a x
						centerY: a y 
						radius: sz
						startAngle: e model* unit
						endAngle: (e model+1)*unit 
				  ] ] ];
		width: [ :e | (e attributes at: #zn) /2 ];
		onModel;"change context, now the bock argument recives the model, a number between [1 50]"
		color: [ :m | color scale: m even ];
		from: [ :m | m even
			ifTrue: [-25@ -25 ]
			ifFalse: [ 25@25 ] ];
		to: 0@0.
	v addAll: (shape edgesOn: (1 to: slices)).
	
	v animation repeat onStepDo: [ :t |
		v edges do: [ :ed | shape updateElement: ed ].
		theta := theta + 0.0523 ].
	v when: TSExtentChangedEvent do: [ :evt | 
		v zoomToFit ].
	v open.
	"53 lines of code"
]

{ #category : #examples }
RSAnimationExamples >> example07b [
	<script: 'self new example07b'>
	| update v theta slices unit color sc1 sc2 |
	v := RSView new.
	slices := 50.
	unit := Float pi * 2 / slices.
	"domain: aBoolean, range: aColor"
	color := TSScale ordinal rangeFrom: { '480D4A'. 'BB1C60' }.
	"input: a number between {-1 1} ouput: a number between 100 and 350"
	sc1 := TSScale linear domain: #(-1 1);range: { 100. 350 }.
	sc2 := TSScale linear domain: #(-1 1);range: { 350. 100 }.
	"for zoom to fit"
	v add: (RSShapeBuilder box extent: 800@800; paint: nil; element).
	theta := 0.
	update := [ 
		v edges copy do: #remove.
		1 to: slices do: [ :i | | e sz  |
			"e is an instance of RSEdge, not been created by shape"
			e := RSEdge new
				model: i;
				trachelShape: TSSVGPathLine new.
			sz := i even
				ifTrue: [ sc1 scale: (i *unit + theta) sin ]
				ifFalse: [ sc2 scale: (e model*unit - theta) sin ].
			e 
				width:  sz /2;
				color: (color scale: i even);
				from: (i even
					ifTrue: [-25@ -25 ]
					ifFalse: [ 25@25 ]);
				to: 0@0.
			e svgPath: [ :a :b |
				"a and b are points, the vertices from this edge"
				"this block returns a block to use complex operations of Athens Canvas"
				"in this part you can also return a string, the svg path"
				[ :canvas | | angle |
					angle := i * unit.
					canvas  
						moveTo: a + (sz * (angle cos@ angle sin));
						arcCenterX: a x
							centerY: a y 
							radius: sz
							startAngle: e model* unit
							endAngle: (e model+1)*unit 
					 ] ].
			v add: e.
		].	
	].
	
	v animation repeat onStepDo: [ :t |
		update value.
		theta := theta + 0.0523 ].
	v when: TSExtentChangedEvent do: [ :evt | 
		v zoomToFit ].
	v open.
	"56 lines of code without RSShapeBuilder"
]

{ #category : #examples }
RSAnimationExamples >> example08ElasticEllipses [
	<script: 'self new example08ElasticEllipses'>
	| v r mouseClick |
	v := RSView new.
	r := SharedRandom globalGenerator.
	
	mouseClick := [ | c1 c2 color  |
		v elements copy do: #remove.
		c1 := Color r: r next g: r next b: r next.
		c2 := Color r: r next g: r next b: r next.
		color := TSScale linear range: { c1. c2 }.
		1 to: 10000 do: [ :i | | e shape radius ang overlapped |
			e := RSElement new.
			shape := TSEllipse new.
			e trachelShape: shape.
			"old days, without RSShapeBuilder"
			
			e radius: r next * 30 + 2.
			radius := r next * 250.
			ang := r next * Float pi * 2.
			e position: radius * (ang cos @ ang sin).
			overlapped := v elements anySatisfy: [ :other |
				(other position dist: e position) < 
					((e radius + other radius) * 1.4)  ].
			overlapped ifFalse: [ 
				v add: e.
				e attributes at: #radius put: e radius.
				e color: (color scale: (e position dist: 0@0)/250 ) ].
		].
		v animation
			easing: TSEasing elasticOut;
			onStepDo: [ :t |
				v elements do: [ :e | | scale |
					scale := TSScale linear range: { 1. e attributes at: #radius }.
					e radius: (scale scale: t)
					 ].
				]
	].
	mouseClick value.
	
	v 
		when: TSExtentChangedEvent do: [ :evt | v zoomToFit ];
		when: TSMouseClick do: mouseClick;
		open

]

{ #category : #examples }
RSAnimationExamples >> example09LinePatterns [
	<script: 'self new example09LinePatterns'>
	| v step frame border dot bar radius data update |
	v := RSView new.
	step := 0.
	frame := 0.
	bar := 200.
	radius := 150.
	data := (1 to: 360 by: 3) collect: #degreesToRadians.
	v add: (RSShapeBuilder box paint: nil; size: 640; element).
	border := TSBorder new
		color: (Color colorFrom: '00004A');
		width: 2.
	dot := RSShapeBuilder ellipse
		size: 5;
		border: border.
	update := [ 
		v elements copy do: #remove.
		v addAll: (data collect: [ :radian | | matrix e d1 d2 |
			"edges do not handle matrix"
			matrix := AthensAffineTransform new.
			matrix translateBy: radius * (radian cos @ radian sin);
				rotateByRadians: radian + (radian * step * 5) + (frame *0.02).
			d1 := dot element.
			d2 := dot element.
			d1 position: (matrix transform: bar/2@0).
			d2 position: (matrix transform: bar/ -2 * radian cos @ 0 ).
			d2 size: 6* radian cos.
			v add: d1; add: d2.
			e := RSEdge new
				trachelShape: TSLine new.
			e border: border.
			e from: d1.
			e to: d2.
			e ]).
	].
	v animation repeat onStepDo: [ :t | 
		frame := frame + 1.
		update value.
	].
	v 
		when: TSExtentChangedEvent do: [ :evt | v zoomToFit ];
		when: TSMouseClick do: [ 
			step := step +1.
			step > 20 ifTrue: [ step := 0 ] ];
		open

]

{ #category : #examples }
RSAnimationExamples >> example10CircleParty [
	<script: 'self new example10CircleParty'>
	| v x x2 speed speed2 r shape color |
	v := RSView new.
	x := 1. x2 := 2.
	speed := 5. speed2 := 10.
	r := SharedRandom globalGenerator.
	color := TSScale ordinal rangeFrom: { 
		(Color colorFrom: 'B4FA05') alpha: 0.7. 
		'FF7C7C'.
		(Color colorFrom: 'EA323E') alpha: 0.5.
		'BDEA5C'.
		(Color colorFrom: 'CB1D34') alpha: 0.3.
		'E0CC14'}.
	v color: Color black.
	shape := RSShapeBuilder circle
		borderDo: [ [:b |
			b width: 25;
			color: (Color 
				r: (r rsNext: 0 and: 40)
				g: (r rsNext: 100 and: 200)
				b: (r rsNext: 100 and: 255)
				range: 255)] ];
		color: [ :m | color scale: m ];
		position: #key;
		size: #value.
	v animation repeat onStepDo: [:t | 
		v elements copy do: #remove.
		color dictionary keysAndValuesRemove: [:a :b| true ].
		(x between: 0 and: 1000) ifFalse: [ speed := speed negated ].
		x2 >= x ifTrue: [ 
			speed2 := speed2 negated.
			x2 > 20 ifTrue: [ x2 := x2 - 20 ] ].
		x2 <= 0 ifTrue: [ speed2 := speed2 negated ].
		x := x + speed.
		x2 := x2 + speed2.
		v add: (shape elementOn: 0@0 -> x).
		v add: (shape elementOn: 0@0 -> x2).
		v add: (shape elementOn: -300 asPoint -> x).
		v add: (shape elementOn: -300 asPoint -> x2).
		v add: (shape elementOn: 300 asPoint -> x).
		v add: (shape elementOn: 300 asPoint -> x2).
		].
	v camera scale: 0.5.
	v open

]

{ #category : #examples }
RSAnimationExamples >> example11ArcTree [
	<script: 'self new example11ArcTree'>
	| v shape newArc alpha beta |
	v := RSView new.
	shape := RSShapeBuilder arc.
	shape 
		color: Color black;
		innerRadius: [:m | m * 0.9];
		externalRadius: #yourself.
	newArc := nil.
	newArc := [ :point :size :iteration | | e |
		e := shape elementOn: size index: iteration. 
		e position: point.
		v add: e.
		iteration > 1 ifTrue: [ 
			newArc 
				value: point + (0 - size@ (size/2 - (size* 0.01) ) ) 
				value: size/2
				value: iteration - 1.
			newArc 
				value: point + (size@ (size/2 - (size* 0.01) ) ) 
				value: size/2
				value: iteration - 1.
			 ]
		].
	newArc value: 0@0 value: 100 value: 5.
	alpha := TSScale linear range: #(90 0).
	beta := TSScale linear range: #(90 180).
	v showEncompassingRectangles.
	v animationFrom: ((1 to: 5) reverse collect: [ :i| | elements |
		elements := v elements select: [ :e | e index = i ].
		v tAnimation 
			duration: 1 seconds;
			easing: TSEasing bounceOut;
			onStepDo: [ :t |
			elements do: [ :e |
				e 
					alphaAngle: (alpha scale: t);
					betaAngle: (beta scale: t);
					resetPath.
				 ]
			 ]
		 ]).
	v when: TSExtentChangedEvent do: [ v zoomToFit; signalUpdate ].
	v open
	





]

{ #category : #examples }
RSAnimationExamples >> example12PerlinParticles [
	<script: 'self new example12PerlinParticles'>
	| v w label pts particle r |
	v := RSView new.
	r := SharedRandom globalGenerator.
	label := RSShapeBuilder label 
		color: Color black;
		text: 'Drag to draw. type ''c'' to clear the view'; element.
	v add: label.
	(v animation delay: 2 seconds;
		from: Color black; 
		to: Color transparent; 
		on: label trachelShape set: #color:)
		when: TSAnimationEndEvent do: [ v clearBackground: false ].
	pts := OrderedCollection new.
	particle := RSShapeBuilder box
		onMyselfDo: [ [ :e | 
			| ang vel |
			ang := r next * Float pi * 2.
			vel := r next * 5 * (ang cos @ ang sin).
			e attributes
				at: #vel put:vel ] ];
		color: [ Color h: r next * 255 s: r next * 255 v: 255 ];
		size: 50;
		position: [ :m | v camera fromPixelToSpace: m key ].
	
	v when: TSMouseDragging do: [ :evt | 
		1 to: 10 do: [ :i | | p |
			p := (particle elementOn: evt position-> (i+pts size) ).
			v add: p.
			pts add: p. ].
		v signalUpdate ].
	w := v open.
	w setLabel: 'Particles!!! :V'
]

{ #category : #examples }
RSAnimationExamples >> example13Arcs [
	<script: 'self new example13Arcs'>
	| view beta shape theta step size |
	theta := 0.
	step := 12.
	size := 21.
	view := RSView new.
	view color: Color black.
	beta := TSScale linear
		domain: #(-1 1);
		range: #(180 360).
	shape := RSShapeBuilder arc
		color: [:m | Color h: theta * 2 + (m * 10) s: 1 l: 0.5];
		innerRadius: [ :m | m * step ];
		externalRadius: [ :m | m * step + 5 ];
		alphaAngle: 180;
		betaAngle: [ :m | | offset |
			offset := Float pi * 2 / size * m.
			beta scale: (theta + offset) sin ].
		
	view addAll: (shape elementsOn: (1 to: size)).
	view animation repeat onStepDo: [ :t |
		theta := theta + 0.0523.
		view elements do: [ :e |
			shape 
				updateElement: e withCommand: #betaAngle:;
				updateElement: e withCommand: #color:
			 ] ].
	view when: TSExtentChangedEvent do: [ | s sc e |
		s := (size * step + 5) * 2.
		e := view extent.
		sc := e x / s.
		view camera
			scale: sc.
		view animation 
			from: 0@0; 
			to: 0@ (e y/sc "+ (s/2)"  )/2;
			on: view camera set: #translateTo:.  ].
	view open setLabel: 'Arc animation'.
	



]

{ #category : #examples }
RSAnimationExamples >> example14C [
	<script: 'self new example14C'>
	| view shape step theta |
	view := RSView new.
	view color: Color black.
	step := 15.
	theta := 0.
	shape := RSShapeBuilder arc
		innerRadius: [ :m | m * step + 7];
		externalRadius: [ :m | m * step + 10 ].
	view addAll: (shape elementsOn: (1 to: 16) ).
	view animation repeat onStepDo: [ :t |
		theta := theta + 0.2.
		view elements do: [ :e |
			e 
				alphaAngle: 30 + (theta * e model);
				betaAngle: 300 + (theta * e model);
				color: (Color h: theta * e model s: 1 l: 0.5) ] ].
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view open setLabel: 'C!!!'
]

{ #category : #examples }
RSAnimationExamples >> example15Sky [
	<script: 'self new example15Sky'>
	| view client image ext shape dots r frame box colors |
	view := RSView new.
	r := SharedRandom globalGenerator.
	ext := 2200 @ 2200.
	box := TSBox new
		extent: ext;
		position: 0 @ ext y / 2 negated;
		paint:
			(LinearGradientPaint new
				colorRamp:
					{(0 -> Color black).
					(1 -> Color blue muchDarker)};
				start: ext / 2 negated;
				stop: ext / 2).
	view addShape: box.
	colors := TSScale linear
		domain: #(5 15);
		range: {'6A6569' . 'white'}.
	shape := RSShapeBuilder ellipse
		attributesDo: [ [ :a | 
			a
				at: #a put: (r rsNext: 0 and: 350);
				at: #r put: (r rsNext: 3500 and: 6000) ] ];
		size: [ r rsNext: 5 and: 15 ];
		onElement;
		color: [ :e | (colors scale: e width) alpha: (r rsNext: 0.1 and: 0.8) ].
	dots := shape elementsOn: (1 to: 800).
	view addAll: dots.
	frame := 0.
	view clearBackground: false.
	(view animation duration: 5 seconds;onStepDo: [ :t| ])
		when: TSAnimationEndEvent do: [ box remove ].
	view animation repeat
		onStepDo: [ :t | 
			frame := frame + 0.1.
			dots
				do: [ :e | 
					| ang radius |
					ang := ((e attributes at: #a) + frame) degreesToRadians.
					radius := e attributes at: #r.
					e position: ang cos @ ang sin negated * radius + (2500 @ 3000) ] ].
	(client := ZnEasy client)
		url:
			'http://www.transparentpng.com/download/mountain/68IzPF-mountain-clipart-png-photos.png';
		accept: ZnMimeType imagePng;
		signalProgress: true;
		get.
	image := ImageReadWriter formFromStream: client entity readStream.
	view addShape: (TSBitmap new form: image).
	view
		when: TSExtentChangedEvent
		do: [ | e s |
			e := view extent.
			s := e x / 2200.
			"2200 x 800 = image extent"
			view camera
				scale: s;
				translateTo: 0 @ (e y / s - 800) / 2 negated ].
	view open setLabel: 'Star trails'
]

{ #category : #examples }
RSAnimationExamples >> example16ArcNoise [
	<script: 'self new example16ArcNoise'>
	| frame view perlin radius shape line points yscale |
	frame := 0.
	view := RSView new.
	view color: Color black.
	perlin := TSPerlinNoise new.
	radius := TSScale linear domain: #(1 20); range: #(50 250).
	shape := RSShapeBuilder arc 
		color: Color white;
		externalRadius: [ :m | radius scale: m ];
		alphaAngle: 0;
		onElement;
		betaAngle: [ :e | | t |
			t := (frame * 0.025) + (e externalRadius * 0.0005).
			360 * (perlin noise: t and: 0.01) abs ];
		innerRadius: [ :e | e externalRadius - 5 ].
	view addAll: (shape elementsOn: (1 to: 20) ).
	view addShape: (TSBox new 
		color: (Color white alpha: 0.4);
		cornerRadius: 7;
		extent: 140@80;
		position: 70@40;
		isFixed: true ).
		
	points := OrderedCollection new.
	yscale := TSScale linear domain: #(0 360); range: #(80 5).
	
	line := TSPolyline new
		border: (TSBorder new  width: 2; paint: (LinearGradientPaint new
			colorRamp:
				{(0 -> Color red).
				(0.5 -> Color yellow).
				(1 -> Color green)};
			start: 0@0;
			stop: 0@80));
		isFixed: true.
	view addShape: line.
		
	view animation repeat; onStepDo: [ :t| | last | 
		frame := frame + 0.2.
		view elements do: [ :e | 
			shape updateElement: e withCommand: #betaAngle:.
			e color: (Color h: e betaAngle s: 0.5 v: 1).
			
			 ].
		last := view elements last.
		points add: (yscale scale: last betaAngle).
		points size > 140 ifTrue: [ points removeFirst ].
		line controlPoints: (points collectWithIndex: [:y :x | x@ y]).
		 ].
	
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view open setLabel: 'Arcs with Perlin noise'
]

{ #category : #examples }
RSAnimationExamples >> example17Retina [
	<script: 'self new example17Retina'>
	| r view perlin side angle circleSize ringSize label minR updateValues offset rad val radius shape |
	view := RSView new.
	view color: Color black.
	minR := 0.08.
	side := 900.
	perlin := TSPerlinNoise new.
	circleSize := ringSize := 100.
	r := SharedRandom globalGenerator.
	angle := TSScale linear domain: { 1. circleSize }; range: {0. 360}.
	label := TSLabel new 
		fontName: 'Source Sans Pro'; 
		text: 'Now begin!'; 
		color: Color white;
		fontSize: 40.
	view addShape: label.
	(view animation 
		delay: 2 seconds; 
		from: 40; 
		to: 12; 
		on: label set:#fontSize: ).
	(view animation 
		delay: 2 seconds;
		from: Color white; to: Color transparent;
		on: label set: #color:) when: TSAnimationEndEvent do: [
			label remove.
			view clearBackground: false].
	updateValues := [ 
		offset := r rsNext: 90.
		rad := r rsNext: minR*side and: 1/ 2 sqrt*side.
		val := rad / side * 100.
		radius := ((rad / (side /2))-minR)*((perlin noise: val and: 0) abs) * side / 6.
	].
	updateValues value.
	shape := RSShapeBuilder circle
		size: [ radius ];
		paint: nil;
		borderDo: [ :m | [ :b | | theta |
			theta := angle scale: m.
			b color: (Color h: theta + offset s: 1 v: 1 alpha: 0.7) ] ];
		position: [:m | | theta |
			theta := (angle scale: m) degreesToRadians.
			((theta cos @ theta sin) * rad).
			].
	view addAll: (shape elementsOn: (1 to: circleSize)).

	(view animation 
		delay: 4 seconds;
		loops: ringSize; 
		duration: 200 milliSeconds; 
		onStepDo: [ :t | ])
	 	when: TSAnimationLoopEvent do: [ :evt | 
			updateValues value.
			view elements do: [ :e | shape updateElement: e ]
		].
		
	view when: TSExtentChangedEvent do: [ 
		view camera zoomToFit: view extent rectangle: (Rectangle center: 0@0 extent: side@side) ].
	view open setLabel: 'Retina (~˘.˘)~'.
]

{ #category : #examples }
RSAnimationExamples >> example18SpaceDandy [
	<script: 'self new example18SpaceDandy'>
	| random extent diagonal rotation init drawDist view shape elements |
	random := SharedRandom globalGenerator.
	extent := 800@600.
	diagonal := ((extent x * extent x)+ (extent y* extent y)) sqrt / 2.
	rotation := 0.
	init := [ :e | | n |
		e attributes 
			at: #l put: 1;
			at: #n put: (n := random rsNext: 1 and: extent x/2);
			at: #r put: (random rsNext: Float pi * 2);
			at: #off put: (random rsNext: 90);
			at: #o put: (random rsNext: 1 and: (random rsNext: 1 and: extent x / n ))  ].
	drawDist := [ :att | | n o |
		n := att at: #n.
		o := att at: #o.
		(n / o) arcTan * extent x / (Float pi / 2)].
	view := RSView new.
	view color: Color black.
	shape := RSShapeBuilder ellipse
		color: Color white.
	
	elements := shape elementsOn: (1 to: 500).
	elements do: [ :e | init value: e ].
	view addAll: elements.
	
	view addShape: (TSLabel new 
		paint: (LinearGradientPaint new
			colorRamp:
				{(0 -> Color yellow).
				(0.35 -> Color orange).
				(0.25 -> Color white darker).
				(0.35 -> Color orange).
				(1 -> Color white)};
			start: 0@ -150;
			stop: 0@130);
		fontSize: 150;
		"fontName: 'Source Sans Pro';"
		fontName: 'Brushcrazy DEMO';
		border: (TSBorder new color: Color black);
		bold;
		text: 'Pharo').
	(view animation repeat duration: 5 seconds; onStepDo: [ :t |  ]) 
		when: TSAnimationLoopEvent do: [ :e| view clearBackground: e animation currentLoop odd  ].
	view animation repeat onStepDo: [ :t|
		rotation := rotation - 0.002.
		elements do: [ :e | | l o r d off | 
			l := (e attributes at: #l)+1.
			e attributes at: #l put: l.
			r := (e attributes at: #r) + rotation.
			o := e attributes at: #o.
			off := e attributes at: #off.
			d := drawDist value: e attributes.
			
			"e color: (Color white alpha: d/ diagonal)."
			e color: ((Color h: (e attributes at: #r) radiansToDegrees+off s: 1 v: 0.5) 
				alpha: d / diagonal).
			e size: extent x/o/8.
			e position: (r cos @ r sin) * d.
			e attributes at: #o put: o - 0.07.
			(drawDist value: e attributes) > diagonal ifTrue: [ init value: e ].
			].
		 ].
	view when: TSExtentChangedEvent do: [ 
		view camera
			zoomToFit: view extent 
			rectangle: (Rectangle center: 0@0 extent: extent) ].
	view open setLabel: 'Space :D'.
]

{ #category : #examples }
RSAnimationExamples >> example19Gris [
	<script: 'self new example19Gris'>
	| v label shape border r mini animation |
	v := RSView new.
	r := SharedRandom globalGenerator.
	border := TSBorder new.
	label := TSLabel new
		fontName: 'Marker Felt';
		text: 'Roassal';
		paint: nil;
		border: border;
		fontSize: 30.
	v addShape: label.
	shape := RSShapeBuilder circle
		paint: nil;
		radius: [ :m | m * label width ];
		border: border;
		onElement;
		if: [ :e | e index = 5 ] actions: [ :s| s border: (TSBorder new width: 1.5) ];
		if: [ :e | e index = 4 ] actions: [ :s | s border: (TSBorder new dashArray: #(4)) ].
		
	v addAll: (shape elementsOn: { 0.6. 0.64. 1.05. 1.20. 1.7 }).
	
	v animation repeat from: 0; to: 8; duration: 200 milliSeconds;
		on: v elements fourth border set: #dashOffset:.
		
	mini := RSShapeBuilder circle
		paint: nil;
		border: (TSBorder new width: 0.5);
		radius: [ :m | m * 5 ];
		if: [ :m | m = 1 ] actions: [ :s | s paint: Color black ];
		if: [ :m | m = 2 ] actions: [ :s | s radius: [ :m | m * 6 ] ].
		
	animation := [ :e :seconds :target :dir | |  ang |
		ang := r next * Float pi * 2.
		v animation repeat duration: seconds asSeconds;
				from: ang; to: ang + (Float pi * 2* dir);
				onStepDo: [ :t | e translateTo: (t cos@ t sin)* target radius ] ].
			
	shape := RSShapeBuilder composite 
		shapes: [:m | mini elementsOn: (1 to: m value) ];
		onMyselfDo: [:m | [ :e | 
			animation value: e value: m key * 6 value: (v elements at: m key) value: 1
			 ] ].
	v addAll: (shape elementsOn: {3-> 3. 4->2}).
	
	shape := RSShapeBuilder composite 
		shapes: [:m | | g |
			g := mini elementsOn: (1 to: 4).
			g first radius: 10.
			g second radius: 15.
			g third radius: 18.
			g fourth radius: 25.
			g add: ((mini elementOn: 1) radius: 3).
			g ];
		onMyselfDo: [:m | [ :e |
			animation value: e value: 30 value: v elements fifth value: -1.
			animation value: e shapes fifth value: 10 value: e shapes fourth value: 1.
			] ].
	v add: shape element.
	v when: TSExtentChangedEvent do: [ v zoomToFit ].
	v open setLabel: 'Roassal :V'.
	


]
