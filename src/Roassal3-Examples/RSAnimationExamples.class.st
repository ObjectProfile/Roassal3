"
I have examples for animation
"
Class {
	#name : #RSAnimationExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
RSAnimationExamples >> example01 [ 
	<script: 'self new example01'>
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
RSAnimationExamples >> example02 [
	<script: 'self new example02'>
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
RSAnimationExamples >> example03 [
	<script: 'self new example03'>
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
RSAnimationExamples >> example04 [
	<script: 'self new example04'>
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
RSAnimationExamples >> example05 [
	<script: 'self new example05'>
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
	v when: TSResizeCanvasEvent do: update.
	
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
			ant when: TSTranslationShapeEvent do: [ :evt | 
				s translateTo: evt position ].
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
	v when: TSResizeCanvasEvent do: update.
	
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
			ant when: TSTranslationShapeEvent do: [ :evt | 
				s translateTo: evt position ].
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
RSAnimationExamples >> example06 [
	<script: 'self new example06'>
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
		
	v when: TSResizeCanvasEvent do: [ :evt | 
		v zoomToFit ].
	v open.
	
]

{ #category : #examples }
RSAnimationExamples >> example07 [
	<script: 'self new example07'>
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
	v when: TSResizeCanvasEvent do: [ :evt | 
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
	v when: TSResizeCanvasEvent do: [ :evt | 
		v zoomToFit ].
	v open.
	"56 lines of code without RSShapeBuilder"
]

{ #category : #examples }
RSAnimationExamples >> example08 [
	<script: 'self new example08'>
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
		when: TSResizeCanvasEvent do: [ :evt | v zoomToFit ];
		when: TSMouseClick do: mouseClick;
		open

]

{ #category : #examples }
RSAnimationExamples >> example09 [
	<script: 'self new example09'>
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
		when: TSResizeCanvasEvent do: [ :evt | v zoomToFit ];
		when: TSMouseClick do: [ 
			step := step +1.
			step > 20 ifTrue: [ step := 0 ] ];
		open

]

{ #category : #examples }
RSAnimationExamples >> example10 [
	<script: 'self new example10'>
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
RSAnimationExamples >> example11 [
	<script: 'self new example11'>
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
	v when: TSResizeCanvasEvent do: [ v zoomToFit; signalUpdate ].
	v open
	





]
