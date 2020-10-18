"
I have examples for animation
"
Class {
	#name : #RSAnimationExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
RSAnimationExamples >> example01BoxWindmill [
	<script: 'self new example01BoxWindmill open'>
	| canvas shapes extent points frameCount border |
	canvas := RSCanvas new.
	canvas color: Color black.
	extent := 1920@1080.
	points := (0 to: extent x by: 50) flatCollect: [ :x |
		(0 to: extent y by: 50) collect: [ :y | (x@y)- (extent/2) ] ].
	border := RSBorder new
		color: (Color gray alpha: 0.5);
		yourself.
		
	shapes := points collect: [ :p | 
		RSBox new
			extent: 140@40;
			model: p;
			color: Color white;
			border: border;
			yourself  ].
	canvas addAll: shapes.
	frameCount := 0.
	canvas newAnimation repeat;
		onStepDo: [ :t |
			shapes do: [ :s | 
				s matrix 
					loadIdentity;
					translateBy: s model;
					rotateByRadians: (s model x + s model y + frameCount) degreesToRadians * 1.95  ].
			frameCount := frameCount + 1. ].
	canvas @ RSGraphCanvasMonitor.
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example02BoxesLineCircles [
	<script: 'self new example02BoxesLineCircles open'>
	| c extent r shapes position alpha update updateLine lineX line |
	c := RSCanvas new.
	r := Random new.
	shapes := (1 to: 12) collect: [ :i | 
		RSBox new
			model: r next;
			noPaint;
			border: (RSBorder new width: 4; color: Color black);
			yourself].
	c addAll: shapes.
	RSNormalizer size
		from: 30;
		to: 100;
		shapes: shapes;
		normalize: #yourself.
	lineX := 0.
	line := RSLine new
		color: Color red;
		width: 8;
		yourself;
		startPoint: 1@0;
		endPoint: 0@0;
		yourself.
	c add: line. 
	position := nil.
	updateLine := [
		line 
			startPoint: lineX@position from y;
			endPoint: lineX@position to y. ].
	c when: RSMouseMove do: [ :ev | 
		lineX := ev position x.
		updateLine value ].
	update := [ 
		extent := c extent.
		position := NSScale linear
			range: { extent / -2. extent /2 }.
		updateLine value.
		shapes do: [ :e | e translateTo: (position scale: r next@ r next) ].
	].
	update value.
	c when: RSExtentChangedEvent do: update.
	
	"shadow"
	alpha := NSScale linear domain: #(1 4); range: #(0.4 0.05).
	shapes do: [ :e | | ant |
		ant := e.
		1 to: 4 do: [:i | | s |
			s := RSBox new 
				noPaint;
				position: e position;
				extent: e extent;
				border: (RSBorder new
					width: 6;
					color: (e border color alpha: (alpha scale: i)));
				yourself.
			ant when: RSPositionChangedEvent do: [ :evt | 
				s translateTo: evt oldPosition ].
			ant := s.
			c add: s
			] ] .
	c newAnimation repeat; 
		onStepDo: [ :t | 
			| round empty |
			round := RSCornerRadius new radius: 100.
			empty := RSCornerRadius new.
			shapes do: [ :shape |
				| delta newX |
				delta := shape propertyAt: #delta ifAbsentPut: [ 5 ].
				newX := shape position x + delta.
				(newX 
					between: position from x 
					and: position to x) ifFalse: [ 
					delta := delta negated.
					newX := shape position x + delta.
					 ].
				shape translateTo: newX@shape position y.
				shape propertyAt: #delta put: delta
				].
			c nodes copy do: [ :shape | | corner |
				corner := shape position x > lineX 
					ifTrue: [ round ]
					ifFalse: [ empty ].
				shape cornerRadius: corner.
				 ].
	].
	^ c
	
]

{ #category : #examples }
RSAnimationExamples >> example03Atom [
	<script: 'self new example03Atom open'>
	| shapes canvas border extent speed frame |
	canvas := RSCanvas new.
	border := RSBorder new width: 4.
	extent := 450@110.
	
	shapes := { 40@40. extent. extent. extent. extent} collectWithIndex: [ :m :index | 
		| ellipse |
		ellipse := RSEllipse new
			border: border;
			extent: m;
			noPaint;
			yourself.
		ellipse matrix
			rotateByRadians: index * Float pi / 4.
		index = 1 ifTrue: [ ellipse color: Color black ].
		ellipse
		 ].
	canvas addAll: shapes.
	shapes := (1 to: 4) collect: [ :m |
		RSEllipse new
			border: border;
			color: Color black;
			extent: 20 asPoint;
			yourself ].
	canvas addAll: shapes.
	
	frame := 0.
	
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame +1.
		speed := frame/50.
		shapes doWithIndex: [ :shape :index | | ang |
			ang := speed + (index * 90).
			shape matrix
				loadIdentity;
				rotateByRadians: index * Float pi /4;
				translateBy: (extent/2)* (ang cos @ ang sin)
			 ]
	].
	canvas when: RSExtentChangedEvent do: [ :evt | 
		canvas zoomToFit ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example05ElasticEllipses [
	<script: 'self new example05ElasticEllipses open'>
	| canvas random mouseClick |
	canvas := RSCanvas new.
	random := Random new.
	
	mouseClick := [ | c1 c2 color  |
		canvas nodes copy do: #remove.
		c1 := Color r: random next g: random next b: random next.
		c2 := Color r: random next g: random next b: random next.
		color := NSScale linear range: { c1. c2 }.
		1 to: 10000 do: [ :i | | shape radius ang overlapped |
			shape := RSEllipse new.
			shape radius: random next * 30 + 2.
			radius := random next * 250.
			ang := random next * Float pi * 2.
			shape position: radius * (ang cos @ ang sin).
			overlapped := canvas nodes anySatisfy: [ :other |
				(other position dist: shape position) < 
					((shape radius + other radius) * 1.4)  ].
			overlapped ifFalse: [ 
				canvas add: shape.
				shape propertyAt: #radius put: shape radius.
				shape color: (color scale: (shape position dist: 0@0)/250 ) ].
		].
		canvas newAnimation
			easing: RSEasing elasticOut;
			onStepDo: [ :t |
				canvas nodes do: [ :shape | | scale |
					scale := NSScale linear range: { 1. shape propertyAt: #radius }.
					shape radius: (scale scale: t)
					 ].
				]
	].
	mouseClick value.
	
	canvas 
		when: RSExtentChangedEvent do: [ :evt | canvas zoomToFit ];
		when: RSMouseClick do: mouseClick.
	^ canvas

]

{ #category : #lines }
RSAnimationExamples >> example06LinePatterns [
	<script: 'self new example06LinePatterns open'>
	| canvas step frame border dot bar radius data update ap |
	canvas := RSCanvas new.
	step := 0.
	frame := 0.
	bar := 200.
	radius := 150.
	data := (1 to: 360 by: 3) collect: #degreesToRadians.
	canvas add: (RSBox new noPaint; size: 640; yourself).
	border := RSBorder new
		color: (Color colorFrom: '00004A');
		width: 2.
	dot := [ RSBox new
		size: 5;
		border: border; 
		yourself ].
	ap := RSCenteredAttachPoint new.
	update := [ 
		canvas nodes copy do: #remove.
		canvas addAll: (data collect: [ :radian | | matrix line d1 d2 |
			"edges do not handle matrix"
			matrix := AthensAffineTransform new.
			matrix translateBy: radius * (radian cos @ radian sin);
				rotateByRadians: radian + (radian * step * 5) + (frame *0.02).
			d1 := dot value.
			d2 := dot value.
			d1 position: (matrix transform: bar/2@0).
			d2 position: (matrix transform: bar/ -2 * radian cos @ 0 ).
			d2 size: 6* radian cos.
			canvas add: d1; add: d2.
			line := RSLine new.
			line border: border.
			line from: d1.
			line to: d2.
			line attachPoint: ap.
			line ]).
	].
	canvas newAnimation repeat onStepDo: [ :t | 
		frame := frame + 1.
		update value.
	].
	canvas 
		when: RSExtentChangedEvent do: [ :evt | canvas zoomToFit ];
		when: RSMouseClick do: [ 
			step := step +1.
			step > 20 ifTrue: [ step := 0 ] ].
	^ canvas

]

{ #category : #examples }
RSAnimationExamples >> example07CircleParty [
	<script: 'self new example07CircleParty open'>
	| canvas x x2 speed speed2 random shape color |
	canvas := RSCanvas new.
	x := 1. x2 := 2.
	speed := 5. speed2 := 10.
	random := Random new.
	color := NSScale ordinal rangeFrom: { 
		(Color colorFrom: 'B4FA05') alpha: 0.7. 
		'FF7C7C'.
		(Color colorFrom: 'EA323E') alpha: 0.5.
		'BDEA5C'.
		(Color colorFrom: 'CB1D34') alpha: 0.3.
		'E0CC14'}.
	canvas color: Color black.
	shape := [ :m | 
		RSEllipse new
			border: (RSBorder new 
				width: 25;
				color: (Color
					r: (random rsNext: 0 and: 40)
					g: (random rsNext: 100 and: 200)
					b: (random rsNext: 100 and: 255));
				yourself);
			color: (color scale: m);
			position: m key;
			size: m value;
			yourself
		].
	canvas newAnimation repeat onStepDo: [:t | 
		canvas nodes copy do: #remove.
		color dictionary keysAndValuesRemove: [:a :b| true ].
		(x between: 0 and: 1000) ifFalse: [ speed := speed negated ].
		x2 >= x ifTrue: [ 
			speed2 := speed2 negated.
			x2 > 20 ifTrue: [ x2 := x2 - 20 ] ].
		x2 <= 0 ifTrue: [ speed2 := speed2 negated ].
		x := x + speed.
		x2 := x2 + speed2.
		canvas add: (shape value: 0@0 -> x).
		canvas add: (shape value: 0@0 -> x2).
		canvas add: (shape value: -300 asPoint -> x).
		canvas add: (shape value: -300 asPoint -> x2).
		canvas add: (shape value: 300 asPoint -> x).
		canvas add: (shape value: 300 asPoint -> x2).
		].
	canvas camera scale: 0.5.
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example08ArcTree [
	<script: 'self new example08ArcTree open'>
	| canvas newArc alpha beta |
	canvas := RSCanvas new.
	
	newArc := nil.
	newArc := [ :point :size :iteration | | arc |
		arc := RSPieSlice new
			color: Color black;
			index: iteration;
			innerRadius: size * 0.9;
			externalRadius: size;
			yourself.
		arc position: point.
		canvas add: arc.
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
	alpha := NSScale linear range: #(90 0).
	beta := NSScale linear range: #(90 180).
	canvas showEncompassingRectangles.
	canvas animationFrom: ((1 to: 5) reverse collect: [ :i| | shapes |
		shapes := canvas nodes select: [ :e | e index = i ].
		canvas transitionAnimation 
			duration: 1 seconds;
			easing: RSEasing bounceOut;
			onStepDo: [ :t |
			shapes do: [ :e |
				e 
					alphaAngle: (alpha scale: t);
					betaAngle: (beta scale: t);
					resetPath.
				 ]
			 ]
		 ]).
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit; signalUpdate ].
	^ canvas




]

{ #category : #perlin }
RSAnimationExamples >> example09PerlinParticles [
	<script: 'self new example09PerlinParticles  open setLabel: ''Particles!!! :V'''>
	| canvas label particle random frame perlin color |
	canvas := RSCanvas new.
	random := Random new.
	frame := 0.
	perlin := NSPerlinNoise new.
	
	label := RSLabel new
		color: Color black;
		text: 'Drag to draw. type ''c'' to clear the view'.
	canvas addShape: label.
	
	canvas newAnimation delay: 2 seconds;
		from: Color black; 
		to: Color transparent; 
		on: label set: #color:;
		when: RSAnimationEndEvent do: [ 
			canvas clearBackground: false.
			label remove. ].
	color := RSGradientPalette fabledSunset asScale.
	color domain: color domain reverse.
	particle := [ :m | 
		| ang vel att lifeSpan decay passedLife weightRange update shape |
		shape := RSEllipse new
			withBorder;
			position: m key;
			yourself.
		att := shape properties.
			
		ang := random next * Float pi * 2.
		vel := random next * 5 * (ang cos @ ang sin).
		lifeSpan := random rsNext: 30 and: 90.
		
		decay := random rsNext: 0.75 and: 0.9.
		passedLife := 0.
		weightRange := random rsNext: 3 and: 50.
		att at: #dead put: false.
		"in this case use a class"
		update := [ | radius rn acc mag pos dir rand alpha |
			att at: #dead put: (passedLife >= lifeSpan).
			passedLife := passedLife + 1.
			acc := (lifeSpan - passedLife)/lifeSpan.
			alpha := acc max: 0.4.
			shape border color: (Color black alpha: alpha).
			shape color: (color scale: acc asFloat).
			radius := acc * weightRange.
			pos := shape position.
			rn := 4*Float pi*((perlin 
				noise: 0.02
				and:0.02) - 0.5).
			mag := (perlin noise: (pos y + frame) * 0.01 and: (pos x + frame)* 0.01) abs.
			dir := rn cos @ rn sin.
			ang :=  random next * Float pi * 2.
			rand := (ang cos @ ang sin) * 0.5.
			acc := (dir * mag) + rand.
			vel := (vel + acc)* decay.
			vel := vel normalized * 3.	
			shape size: radius.
			shape translateBy: vel.
			].
			att at: #update put: update.
			shape ].
	canvas newAnimation repeat; onStepDo: [ :t| 
		frame := frame + 30.
		canvas nodes copy do: [ :e| 
			(e propertyAt: #update) value.
			(e propertyAt: #dead) ifTrue: [ e remove ] ].
		canvas signalUpdate ].
	
	canvas when: RSMouseDragging do: [ :evt | 
		1 to: 10 do: [ :i | | p |
			p := (particle value: evt position->(i+canvas nodes size)).
			canvas add: p ].
		canvas signalUpdate ];
		when: RSKeyUp do: [:evt | 
			evt keyValue = 8 ifTrue: [ 
				canvas clearBackground: true.
				canvas nodes copy do: #remove.
				canvas signalUpdate.
				canvas newAnimation duration: 200 milliSeconds;
				when: RSAnimationEndEvent do: [ canvas clearBackground: false ] ] ].

	^ canvas









]

{ #category : #perlin }
RSAnimationExamples >> example09b [
	<script: 'self new example09b  open setLabel: ''Particles!!! :V'''>
	| canvas label particle random frame perlin changeHue hIndex hExtent h |
	canvas := RSCanvas new.
	canvas color: Color black.
	random := Random new.
	frame := 0.
	perlin := NSPerlinNoise new.
	
	label := RSLabel new
		color: Color white;
		text: 'Drag to draw. type ''c'' to clear the view.'.
	canvas addShape: label.
	
	canvas newAnimation delay: 2 seconds;
		from: Color black; 
		to: Color transparent; 
		on: label set: #color:;
		when: RSAnimationEndEvent do: [ 
			canvas clearBackground: false.
			label remove. ].
		
	hIndex := 4.
	changeHue := [
		hIndex := hIndex + 1.
		hIndex > 4 ifTrue: [ hIndex := 0 ].
		hExtent := NSScale linear
			domain: #(0 1 2 3 4);
			range: { 220@100. 55@0. 100@20. 180@110. 255@150 };
			scale: hIndex.
		hExtent := hExtent * 360 / 255.
		h := hExtent y ].
	changeHue value.
	particle := [ :m |  
		| ang vel att lifeSpan decay passedLife update sizeMult shape |
		shape := RSEllipse new
			position: m key;
			yourself.
		att := shape properties.
		
		ang := random next * Float pi * 2.
		vel := random next * 5 * (ang cos @ ang sin).
		lifeSpan := random rsNext: 30 and: 90.
		
		decay := random rsNext: 0.75 and: 0.9.
		passedLife := 0.
		h := h + 0.5.
		h > hExtent x ifTrue: [ h := hExtent y + h - hExtent x ].
		shape color: ((Color h: h s: 1 v: 1) alpha: 0.2).
		sizeMult := ((frame * 0.02) sin max: 0.05) min: 0.5.
		att at: #dead put: false.
		"in this case use a class"
		update := [ | radius rn acc mag pos dir rand |
			att at: #dead put: (passedLife >= lifeSpan).
			passedLife := passedLife + 1.
			acc := lifeSpan - passedLife.
			
			radius := acc * sizeMult.
			pos := shape position.
			rn := 4*Float pi*((perlin 
				noise: 0.02
				and:0.02) - 0.5).
			mag := (perlin noise: (pos y + frame) * 0.01 and: (pos x + frame)* 0.01) abs.
			dir := rn cos @ rn sin.
			ang :=  random next * Float pi * 2.
			rand := (ang cos @ ang sin) * 0.5.
			acc := (dir * mag) + rand.
			vel := (vel + acc)* decay.
			vel := vel normalized * 3.	
			shape size: radius.
			shape translateBy: vel.
		].
		att at: #update put: update.
		shape
	].
	
	canvas newAnimation repeat; onStepDo: [ :t| 
		frame := frame + 30.
		canvas nodes copy do: [ :e| 
			(e propertyAt: #update) value.
			(e propertyAt: #dead) ifTrue: [ e remove ] ].
		canvas signalUpdate ].
	
	canvas when: RSMouseDragging do: [ :evt | 
		1 to: 10 do: [ :i | | p |
			p := (particle value: evt position-> (i+canvas nodes size) ).
			canvas add: p ].
		canvas signalUpdate ];
		when: RSKeyUp do: [:evt | 
			evt keyValue = 8 ifTrue: [ 
				canvas clearBackground: true.
				canvas nodes copy do: #remove.
				canvas signalUpdate.
				canvas newAnimation duration: 200 milliSeconds;
				when: RSAnimationEndEvent do: [ canvas clearBackground: false ] ]
			ifFalse: changeHue ].

	^ canvas








]

{ #category : #perlin }
RSAnimationExamples >> example10Arcs [
	<script: 'self new example10Arcs open setLabel: ''Arc animation'''>
	| canvas beta shapes theta step size |
	theta := 0.
	step := 12.
	size := 21.
	canvas := RSCanvas new.
	canvas color: Color black.
	beta := NSScale linear
		domain: #(-1 1);
		range: #(180 360).
	shapes := (1 to: size) collect: [ :m | 
		RSPieSlice new
			model: m;
			innerRadius: m * step;
			externalRadius: m * step + 5;
			alphaAngle: 180;
			yourself ].
		
	canvas addAll: shapes.
	canvas newAnimation repeat onStepDo: [ :t |
		theta := theta + 0.0523.
		shapes do: [ :shape | | m offset |
			m := shape model.
			offset := Float pi * 2 / size * m.
			shape 
				color: (Color h: theta * 2 + (m * 10) s: 1 l: 0.5);
				betaAngle: (beta scale: (theta + offset) sin)
			 ] ].
	canvas when: RSExtentChangedEvent do: [ | s sc e |
		s := (size * step + 5) * 2.
		e := canvas extent.
		sc := e x / s.
		canvas camera
			scale: sc.
		canvas newAnimation 
			from: 0@0; 
			to: 0@ (e y/sc)/2;
			on: canvas camera set: #translateTo:.  ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example11C [
	<script: 'self new example11C open setLabel: ''C!!!'''>
	| canvas shapes step theta |
	canvas := RSCanvas new.
	canvas color: Color black.
	step := 15.
	theta := 0.
	shapes := (1 to: 16) collect: [ :m |
		RSPieSlice new
			model: m;
			innerRadius: m * step + 7;
			externalRadius: m * step + 10;
			yourself
		 ].
	canvas addAll: shapes.
	canvas newAnimation repeat onStepDo: [ :t |
		theta := theta + 0.4.
		shapes do: [ :shape | | m |
			m := shape model.
			shape
				alphaAngle: 30 + (theta * m);
				betaAngle: 300 + (theta * m);
				color: (Color h: theta * m s: 1 l: 0.5) ] ].
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example12Sky [
	<script: 'self new example12Sky open setLabel: ''Star trails'''>
	<noTest>
	| canvas client image ext dots random frame box colors |
	canvas := RSCanvas new.
	random := Random new.
	ext := 2200 @ 2200.
	box := RSBox new
		extent: ext;
		position: 0 @ ext y / 2 negated;
		paint:
			(LinearGradientPaint new
				colorRamp:
					{(0 -> Color black).
					(1 -> Color blue muchDarker)};
				start: ext / 2 negated;
				stop: ext / 2).
	canvas addShape: box.
	colors := NSScale linear
		domain: #(5 15);
		range: {'6A6569' . 'white'}.

	dots := (1 to: 800) collect: [ :n | 
		| e |
		e := RSEllipse new
			propertyAt: #a put: (random rsNext: 0 and: 350);
			propertyAt: #r put: (random rsNext: 3500 and: 6000);
			size: (random rsNext: 5 and: 15);
			yourself. 
		e color: ((colors scale: e width) alpha: (random rsNext: 0.1 and: 0.8)).
		e ].
	canvas addAll: dots.
	frame := 0.
	canvas clearBackground: false.
	(canvas newAnimation duration: 5 seconds;onStepDo: [ :t| ])
		when: RSAnimationEndEvent do: [ box remove ].
	canvas newAnimation repeat
		onStepDo: [ :t | 
			frame := frame + 0.1.
			dots
				do: [ :e | 
					| ang radius |
					ang := ((e propertyAt: #a) + frame) degreesToRadians.
					radius := e propertyAt: #r.
					e position: ang cos @ ang sin negated * radius + (2500 @ 3000) ] ].
	(client := ZnEasy client)
		url:
			'http://www.transparentpng.com/download/mountain/68IzPF-mountain-clipart-png-photos.png';
		accept: ZnMimeType imagePng;
		signalProgress: true;
		get.
	image := ImageReadWriter formFromStream: client entity readStream.
	canvas addShape: (RSBitmap new form: image).
	canvas
		when: RSExtentChangedEvent
		do: [ | e s |
			e := canvas extent.
			s := e x / 2200.
			"2200 x 800 = image extent"
			canvas camera
				scale: s;
				translateTo: 0 @ (e y / s - 800) / 2 negated ].
	^ canvas
]

{ #category : #perlin }
RSAnimationExamples >> example13ArcNoise [
	<script: 'self new example13ArcNoise open setLabel: ''Arcs with Perlin noise'''>
	| frame canvas perlin radius line points yscale |
	frame := 0.
	canvas := RSCanvas new.
	canvas color: Color black.
	perlin := NSPerlinNoise new.
	radius := NSScale linear domain: #(1 20); range: #(50 250).
	canvas addAll: ((1 to: 20) collect: [:n |
		| r |
		r := radius scale: n.
		RSPieSlice new
			color: Color white;
			externalRadius: r;
			alphaAngle: 0;
			innerRadius: r - 5;
			yourself. ]).
	canvas addShape: (RSBox new 
		color: (Color white alpha: 0.4);
		cornerRadius: 7;
		extent: 140@80;
		position: 70@40;
		isFixed: true ).
		
	points := OrderedCollection new.
	yscale := NSScale linear domain: #(0 360); range: #(80 5).
	
	line := RSPolyline new
		border: (RSBorder new  
			width: 2;
			paint: ((LinearGradientPaint fromArray:
				{0 -> 'red'.
				0.5 -> 'yellow'.
				1 -> 'green'})
				start: 0@0;
				stop: 0@80;
				yourself);
			yourself);
		isFixed: true;
		yourself.
	canvas addShape: line.
		
	canvas newAnimation repeat; onStepDo: [ :t|
		| last temp | 
		frame := frame + 0.2.
		canvas nodes do: [ :arc | 
			temp := (frame * 0.025) + (arc externalRadius * 0.0005).
			arc betaAngle: 360 * (perlin noise: temp and: 0.01) abs.
			arc color: (Color h: arc betaAngle s: 0.5 v: 1).
			 ].
		last := canvas nodes last.
		points add: (yscale scale: last betaAngle).
		points size > 140 ifTrue: [ points removeFirst ].
		line controlPoints: (points collectWithIndex: [:y :x | x@ y]).
		 ].
	
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	^ canvas
]

{ #category : #perlin }
RSAnimationExamples >> example14Retina [
	<script: 'self new example14Retina open setLabel: ''Retina (~o.o)~'''>
	| random canvas perlin side angle circleSize ringSize label minR updateValues offset rad val radius |
	canvas := RSCanvas new.
	canvas color: Color black.
	minR := 0.08.
	side := 900.
	perlin := NSPerlinNoise new.
	circleSize := ringSize := 100.
	random := Random new.
	angle := NSScale linear domain: { 1. circleSize }; range: {0. 360}.
	label := RSLabel new 
		fontName: 'Source Sans Pro'; 
		text: 'Now begin!'; 
		color: Color white;
		fontSize: 40.
	canvas addShape: label.
	(canvas newAnimation 
		delay: 2 seconds; 
		from: 40; 
		to: 12; 
		on: label set:#fontSize: ).
	(canvas newAnimation 
		delay: 2 seconds;
		from: Color white; to: Color transparent;
		on: label set: #color:) when: RSAnimationEndEvent do: [
			label remove.
			canvas clearBackground: false].
	updateValues := [ 
		offset := random rsNext: 90.
		rad := random rsNext: minR*side and: 1/ 2 sqrt*side.
		val := rad / side * 100.
		radius := ((rad / (side /2))-minR)*((perlin noise: val and: 0) abs) * side / 6.
	].
	updateValues value.
	
	canvas addAll: ((1 to: circleSize) collect: [:m |
		RSEllipse new
			noPaint;
			withBorder;
			yourself ]).

	canvas newAnimation 
		delay: 4 seconds;
		loops: ringSize; 
		duration: 200 milliSeconds; 
	 	when: RSAnimationLoopEvent do: [ :evt | 
			updateValues value.
			canvas nodes doWithIndex: [ :e :index | 
				| theta |
				theta := angle scale: index.
				e border color: (Color h: theta + offset s: 1 v: 1 alpha: 0.7).
				theta := theta degreesToRadians.
				e size: radius.
				e position: (theta cos @ theta sin) * rad.
				 ].
		].
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera zoomToFit: canvas extent extent: side@side ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example15SpaceDandy [
	<script: 'self new example15SpaceDandy open setLabel: ''Space :D'''>
	| random extent diagonal rotation init drawDist canvas shapes |
	random := Random new.
	extent := 800@600.
	diagonal := ((extent x * extent x)+ (extent y* extent y)) sqrt / 2.
	rotation := 0.
	init := [ :e | | n |
		e properties 
			at: #l put: 1;
			at: #n put: (n := random rsNext: 1 and: extent x/2);
			at: #r put: (random rsNext: Float pi * 2);
			at: #off put: (random rsNext: 90);
			at: #o put: (random rsNext: 1 and: (random rsNext: 1 and: extent x / n ))  ].
	drawDist := [ :att | | n o |
		n := att at: #n.
		o := att at: #o.
		(n / o) arcTan * extent x / (Float pi / 2) ].
	canvas := RSCanvas new.
	canvas color: Color black.

	shapes := (1 to: 500) collect: [ :m |
		RSEllipse new
			color: Color white;
			yourself ].
	shapes do: [ :e | init value: e ].
	canvas addAll: shapes.
	
	canvas addShape: (RSLabel new 
		paint: ((LinearGradientPaint fromArray:
				{0 -> 'yellow'.
				0.35 -> 'orange'.
				0.25 -> Color white darker.
				0.35 -> 'orange'.
				1 -> 'white'})
			start: 0@ -150;
			stop: 0@130;
			yourself);
		fontSize: 150;
		fontName: 'Brushcrazy DEMO';
		withBorder;
		bold;
		text: 'Pharo';
		yourself).
	canvas newAnimation 
		repeat;
		duration: 5 seconds; 
		when: RSAnimationLoopEvent do: [ :e| canvas clearBackground: e animation currentLoop odd  ].
	canvas newAnimation repeat onStepDo: [ :t|
		rotation := rotation - 0.002.
		shapes do: [ :e | | l o r d off | 
			l := (e propertyAt: #l)+1.
			e propertyAt: #l put: l.
			r := (e propertyAt: #r) + rotation.
			o := e propertyAt: #o.
			off := e propertyAt: #off.
			d := drawDist value: e properties.
			
			e color: ((Color h: (e properties at: #r) radiansToDegrees+off s: 1 v: 0.5) 
				alpha: d / diagonal).
			e size: extent x/o/8.
			e position: (r cos @ r sin) * d.
			e propertyAt: #o put: o - 0.07.
			(drawDist value: e properties) > diagonal ifTrue: [ init value: e ].
			].
		 ].
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera
			zoomToFit: canvas extent 
			extent: extent ].
	^ canvas.
]

{ #category : #examples }
RSAnimationExamples >> example16Gris [
	<script: 'self new example16Gris open setLabel: ''Roassal :V'''>
	| c label shape border r mini animation g|
	c := RSCanvas new.
	r := Random new.
	border := RSBorder new.
	label := RSLabel new
		fontName: 'Marker Felt';
		text: 'Roassal';
		noPaint;
		border: border;
		fontSize: 30.
	c addShape: label.
	
	c addAll: ({0.6. 0.64. 1.05. 1.20. 1.7} collectWithIndex: [ :m :i | | s |
		s := RSEllipse new
			noPaint;
			radius: m * label width;
			border: border;
			yourself.
		i = 5 ifTrue: [ s border: (RSBorder new width: 1.5) ].
		i = 4 ifTrue: [ s border: (RSBorder new dashArray: #(4)) ].
		s ] ).
	
	c newAnimation repeat from: 0; to: 8; duration: 200 milliSeconds;
		on: c nodes fourth border set: #dashOffset:.
		
	mini := [ :m | | s |
		s := RSEllipse new
			noPaint;
			radius: m * 5;
			border: (RSBorder new width: 0.5);
			yourself.
		m = 1 ifTrue: [ s paint: Color black ].
		m = 2 ifTrue: [ s radius: m * 6 ].
		s ].
	animation := [ :s :seconds :target :dir | |  ang |
		ang := r next * Float pi * 2.
		c newAnimation repeat duration: seconds asSeconds;
				from: ang; to: ang + (Float pi * 2* dir);
				onStepDo: [ :t | s translateTo: (t cos@t sin) * target radius ] ].
			
	c addAll: ({3-> 3. 4->2} collect: [ :m | | s |
		s := RSComposite new
			shapes: ((1 to: m value) collect: [ :k | mini value: k ]);
			yourself.
		animation value: s value: m key * 6 value: (c nodes at: m key) value: 1.
		s ] ).
	g := (1 to: 4) collect: [ :m | mini value: m ] as: RSGroup.
	g first radius: 10.
	g second radius: 15.
	g third radius: 18.
	g fourth radius: 25.
	g add: ((mini value: 1) radius: 3).
	shape := RSComposite new
		shapes: g;
		yourself.
	c add: shape.
	animation value: shape value: 30 value: c nodes fifth value: -1.
	animation value: shape shapes fifth value: 10 value: shape shapes fourth value: 1.
	c when: RSExtentChangedEvent do: [ c zoomToFit ].
	^ c
	


]

{ #category : #examples }
RSAnimationExamples >> example17Flor [
	<script: 'self new example17Flor open setLabel: ''Animation test'''>
	| c frame angleSp alphaS hueS dia1 dia2 |
	c := RSCanvas new.
	frame := 0.
	angleSp := 0.
	hueS := NSScale linear domain: #(50 200); range: #(250 360).
	alphaS := NSScale linear domain: #(50 200); range: #(0.3 1).
	dia1 := NSScale linear domain: #(50 180); range: #(90 1).
	dia2 := NSScale linear domain: #(-1 1); range: #(5 20).
	(0 to: 350 by: 60) do: [ :i | 
		(50 to: 170 by: 10) do: [ :m |  | color |
			color := Color 
				h: (hueS scale: m)
				s: 0.8 
				v: 1 
				alpha: (alphaS scale: m).
			c addShape: (RSEllipse new
				color: color;
				model: i -> m;
				yourself).
			 ].
		 ].
	c newAnimation repeat onStepDo: [ :t | 
		frame := frame + 1.
		angleSp := frame / 250.0 * (Float pi * 2).
		c shapes do: [ :s | 
			| angle i m dist diameter |
			i := s model key.
			m := s model value.
			angle := (i + (angleSp sin * m)) degreesToRadians.
			s position: m * (angle cos @ angle sin).
			dist := s position dist: 0@0.
			diameter := dia2 scale: (dia1 scale: dist) sin.
			s extent: diameter asPoint.
	 	].
		c signalUpdate.
		].
	c when: RSExtentChangedEvent do: [ 
		c camera zoomToFit: c extent extent: 500 asPoint ].
	^ c
	
]

{ #category : #perlin }
RSAnimationExamples >> example18Rainbow [
	<script: 'self new example18Rainbow open setLabel: ''Worms'''>
	| canvas random shape mode color frame border |
	canvas := RSCanvas new.
	canvas clearBackground: false.
	canvas color: Color black.
	random := Random new.
	
	border := RSBorder new
		width: 0.5;
		yourself. 
	shape := [ | e att xs ys  |
		e := RSEllipse new.
		e border: border.
		att := e properties.
		xs := random rsNext: -3 and: 3.
		ys := (xs between: -1 and: 1)
			ifTrue: [ random next > 0.5
				ifTrue: [ random rsNext: 1 and: 3 ]
				ifFalse: [ random rsNext: -3 and: -1 ] ]
			ifFalse: [ random rsNext: 3 and: -3 ].
		att
			at: #s put: 0;
			at: #t put: 0;
			at: #degX put: random next;
			at: #degY put: random next;
			at: #xs put: xs;
			at: #ys put: ys;
			at: #hue put: random next * 360;
			at: #hue2 put: 4.
		e].
	mode := 1.
	frame := 0.
	color := NSScale ordinal
		domain: #(0 1 2);
		range:
			{[ Color black ].
			[ :e | Color h: (e propertyAt: #hue) s: 0.7 v: 1 ].
			[ :e | 
			frame even
				ifTrue: [ Color black ]
				ifFalse: [ Color h: (e propertyAt: #hue) s: 1 v: 1 ] ]}.
	canvas newAnimation repeat
		onStepDo: [ :k | 
			| shapes |
			canvas add: shape value.
			frame := frame + 1.
			shapes := canvas shapes copy.
			shapes do: [ :e | | att t s degX degY xs ys hue hue2|
				att := e properties.
				t := att at: #t.
				s := att at: #s.
				degX := att at: #degX.
				degY := att at: #degY.
				xs := att at: #xs.
				ys := att at: #ys.
				hue := att at: #hue.
				hue2 := att at: #hue2.
				
				e color: ((color scale: mode) rsValue: e).
				e border color: (Color h: 360 - (att at: #hue) s: 1 v: 1).
				e size: s.
				
				t := t + 0.02.
				s := s + 0.2.
				e translateBy: ((xs @ ys )+(degX cos@ degY cos)) * t.
				degX := degX +  (random rsNext: 0.1 and: 0.8).
				degY := degY + (random rsNext: 0.1 and: 0.8).
				hue := hue + hue2.
				(hue > 360 or: [hue < 0])
					ifTrue: [ hue2 := hue2 negated ].
				att
					at: #t put: t;
					at: #s put: s;
					at: #degX put: degX;
					at: #degY put: degY;
					at: #hue put: hue;
					at: #hue2 put: hue2.
				((Rectangle center: 0@0 extent: canvas extent + 200) 
					containsPoint: e position)
					ifFalse: [ e remove ]  ] ].
	canvas
		when: RSExtentChangedEvent
		do: [ canvas camera zoomToFit: canvas extent extent: canvas extent ];
		when: RSMouseClick do: [ 
			mode := mode +1.
			mode > 2 ifTrue: [mode := 0] ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example19Stars [
	<script: 'self new example19Stars open setLabel: ''Stars'''>
	| canvas color random stars |
	canvas := RSCanvas new.
	random := Random new.
	color := NSScale linear domain: #(0 10); range: #('black' 'blue').
	canvas addAll: ((1 to: 100) collect: [:m | 
		RSBox new
			size: 39;
			color: (color scale: m-1 // 10);
			yourself ]).
	RSGridLayout new lineItemsCount: 10; gapSize: 1; on: canvas nodes. 
	stars := (1 to: 5) collect: [:m | 
		RSShapeFactory star
			withBorder;
			size: (random rsNext: 10 and: 100);
			position:  (random rsNext: 50 and: 300)@ (random rsNext: 50 and: 300);
			color: Color white;
			yourself ].
	canvas addAll: stars.
	canvas newAnimation repeat to: 360; onStepDo: [ :t |
		stars do: [ :star | | position |
			position := star position.
			star matrix loadIdentity.
			star translateTo: position.
			star rotateByDegrees: t ] ].
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example20CircleWaves [
	<script: 'self new example20CircleWaves open setLabel: ''Waves'''>
	| canvas shapes frame |
	canvas := RSCanvas new.
	frame := 0.
		
	shapes := #('15c108' '8d0402' '0002ab') collect: [:m |
		RSPolygon new
			noPaint;
			border: (RSBorder new
				color: ((Color colorFrom: m) alpha: 0.5);
				width: 10;
				yourself);
			yourself ].
	canvas addAll: shapes.
	
	canvas newAnimation repeat onStepDo: [ :transition | 
		frame := frame + 0.02.
		shapes doWithIndex: [ :poly :index | 
			| points |
			points := RSPolygon
				generateUnitNgonPoints: 150
				rotation: 0 
				angle: [ :a :i | a ]
				radius: [ :a :i | | t |
					t := frame.
					200 + (((a * 8) - ((index * 2 * Float pi) / 3) + t ) cos * 
				(((1 + (a - t) cos) / 2) raisedTo: 3) * 32 ) ].
			poly 
				privatePoints: points;
				resetPath
			 ] ].
	canvas 
		when: RSExtentChangedEvent 
		do: [ canvas camera zoomToFit: canvas extent extent: 500@500 ].
	^ canvas
]

{ #category : #lines }
RSAnimationExamples >> example21Lines [
	<script: 'self new example21Lines open setLabel: ''.=.= Lines =.=.'''>
	| canvas frame radius hueOffset angleSp shapes soffset size mult shape |
	canvas := RSCanvas new.
	canvas color: Color black.
	frame := 0.
	radius := 200.
	hueOffset := 0.
	angleSp := 0.
	"<globals>"
	soffset := nil. size := nil. mult := 0.
	"</globals>"
	shape := [ :array |
		array collect: [ :m | | com ang a line |
			com := RSComposite new.
			com model: m + soffset.
			ang := m degreesToRadians.
			a := Float halfPi + ang.
			com propertyAt: #offset put: a * size.
			line := RSLine new
				width: 1.5;
				yourself.
				
			com add: line.
			com translateTo: ang cos @ ang sin * radius * mult.
			com matrix rotateByRadians: a.
			com ] ].
	
	soffset := 0. size := 12. mult := 1.
	shapes := shape value: (0 to: 359 by: 12).
	canvas addAll: shapes.
	
	soffset := 180. size := 8. mult := 0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.
	
	soffset := 120. size := 4. mult := 0.5@0.75.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes."
	
	"soffset := 240. size := 4. mult := 0.75@0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.
	shapes := canvas nodes.
	canvas addShape: (RSLabel new 
		text: 'Roassal';
		fontSize: 30;
		border: (RSBorder new color: Color white);
		color: nil).
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame + 1. 
		angleSp := frame / 300 * Float twoPi.
		hueOffset := hueOffset + 1.
		shapes do: [ :s | | pos line |
			pos := (angleSp negated + (s propertyAt: #offset)) cos * 30.
			line := s shapes first.
			line color: (Color h: s model + hueOffset s: 0.6 v: 1).
			line endPoint: 0@ pos ].
		 ].
	canvas when: RSExtentChangedEvent do: [ canvas camera zoomToFit: canvas extent extent: 500 asPoint ].
	^ canvas
]

{ #category : #lines }
RSAnimationExamples >> example22Lines [
	<script: 'self new example22Lines open setLabel: ''Line patterns'''>
	| canvas radius bar step frame label border |
	canvas := RSCanvas new.
	canvas color: (Color colorFrom: 'EEEEEE').
	radius := 200.
	bar := 180.
	step := 1.
	frame := 0.
	border := RSBorder new
		color: Color lightGray;
		yourself.
	canvas addAll: ((0 to: 360 by: 0.5) collect: [ :i |
		RSComposite new
			model: i;
			add: (RSLine new
				border: border;
				startPoint: bar negated /2 @0;
				endPoint: bar / 2 @ 0;
				yourself);
			yourself ] ).
	canvas newAnimation repeat onStepDo: [ :t | 
		frame := frame + 4.
		canvas nodes do: [ :s | | radian |
			radian := s model degreesToRadians.
			s matrix 
				loadIdentity;
				translation: radius * (radian cos@radian sin);
				rotateByRadians: radian + (frame * (radian * step * 0.5) sin * 0.05) ]
		].
	label := RSLabel new 
		text: 'Pharo';
		fontName: 'Brushcrazy DEMO';
		fontSize: 50;
		noPaint;
		bold;
		border: (RSBorder new paint: Color black; dashArray: #(4)).
	canvas addShape: label.
	canvas newAnimation repeat from: 0; to: 8; on: label border set: #dashOffset:.
	
	canvas when: RSMouseClick do: [
		step := step + 0.5.
		step > 11 ifTrue: [ step := 1 ] ].
	canvas when: RSExtentChangedEvent do: [ canvas camera zoomToFit: canvas extent extent: 640@640 ].
	^ canvas
	



]

{ #category : #perlin }
RSAnimationExamples >> example23PerlinNoise [
	<script: 'self new example23PerlinNoise open setLabel: ''Perlin Noise'''>
	"inpired by wangyasai Twitter: @yasai_wang"
	| canvas random c1 c2 c3 size perlin noiseScale rec |
	canvas := RSCanvas new.
	rec := Rectangle floatCenter: 0@0 extent: self currentWorld extent.
	random := Random new.
	size := 200.
	noiseScale := 300.
	canvas clearBackground: false.
	perlin := NSPerlinNoise2 new.
	canvas color: (Color colorFrom: '150832').
	c1 := '45217C'. c2 := '0799F2'. c3 := 'white'.
	
	canvas addAll: ((1 to: size) collect: [ :i |
		| newcircle |
		newcircle := [ :col | RSEllipse new
			position: (random next* rec width)@(random next * rec height) + rec origin;
			size: 0.1 + (i/size);
			color: ((Color colorFrom: col) alpha: i*(250 / 255)/ size);
			yourself ].
		RSComposite new
			model: i;
			add: (newcircle value: c1);
			add: (newcircle value: c2);
			add: (newcircle value: c3);
			yourself.
			 ] ).
	canvas newAnimation repeat onStepDo: [ :t | | speed |
		speed := 0.4.
		canvas nodes do: [ :c |
			c shapes do: [ :e |
				| angle p dir vel pval |
				p := e position.
				pval := perlin 
					noise: p x / noiseScale
					and: p y / noiseScale.
				pval := (pval + 1) / 2.
				angle := Float twoPi * noiseScale * pval.
				dir := angle cos @ angle sin.
				vel := dir * speed.
				p := p + vel.
				(rec containsPoint: p) ifFalse: [ 
					p := (random next * rec width )@(random next * rec height) + rec origin ].
				e translateTo: p.
				].
			].
		].
	^ canvas
	



]

{ #category : #perlin }
RSAnimationExamples >> example24RoassalPerlinNoise [
	<script: 'self new example24RoassalPerlinNoise open extent: 800@500; setLabel: ''Roassal'''>
	| canvas density rect maxLife size perlin r color noiseScale sc1 sc2 |
	canvas := RSCanvas new.
	canvas color: Color black.
	canvas clearBackground: false.
	r := Random new.
	perlin := NSPerlinNoise2 new.
	density := 800. maxLife := 10. noiseScale := 800.
	rect := Rectangle floatCenter: 0@0 extent: self currentWorld extent.
	size := rect width * rect height / density.
	color := NSScale ordinal rangeFrom: { '6E39CC'. '0799F2'. 'white'}.
	sc1 := NSScale linear domain: {1. size}; range: #(5 1).
	sc2 := NSScale linear domain: {1. size}; range: #(1 2).
	canvas addAll: ((1 to: size) collect: [:i |
		RSEllipse new
			size: (sc2 scale: i);
			model: i;
			propertyAt: #flip put: (r next* 2) asInteger * 2 - 1;
			propertyAt: #life put: r next * maxLife;
			propertyAt: #color put: (color scale: (r next * 3) asInteger);
			position: (r next * rect width)@ (r next * rect height )+ rect origin;
			yourself.
		]).
	canvas newAnimation repeat onStepDo: [ :t |
		canvas nodes do: [ :e | 
			| life att p flip iterations respawn case fadeRatio colorCase c |
			att := e properties.
			flip := att at: #flip.
			life := att at: #life.
			c := att at: #color.
			life := life - 0.06667.
			respawn := [
				e position: (r next * rect width)@ (r next * rect height )+ rect origin.
				life := maxLife. ].
			life < 0 ifTrue: respawn.
			att at: #life put: life.
			p := e position-rect origin.
			iterations := sc1 scale: e model.
			1 to: iterations do: [ :i| | angle dir |
				angle := Float twoPi * noiseScale * flip * (perlin 
					snoise: p x / noiseScale  
					and: p y / noiseScale).
				dir := angle cos @ angle sin * 1.2.
				p := p + dir.
				].
			case := p / rect extent.
			case := ((case x + case y)/2 *3 )asInteger.
			p := p + rect origin.
			e position: p.
			(rect containsPoint: p) ifFalse: respawn.
			fadeRatio := (life * 5) min: 1.
			fadeRatio := fadeRatio min: (maxLife - life)*5 / maxLife .
			colorCase := NSScale ordinal domain: #(0 1 2); range: { 
				[ Color gray: life / maxLife ].
				[ c ].
				[ (Color 
					r: (c blue * 255) + 10
					g: (c green * 255)- 20
					b: (c red * 255) - 5 range: 255) ]
			}.
			c := (colorCase scale: case) value.
			e color: (c alpha: fadeRatio).
			 ]. ].
	canvas 
		when: RSExtentChangedEvent 
		do: [ canvas camera zoomToFit: canvas extent rectangle: rect ].
	^ canvas
	"morph := v canvas morph.
	morph extent: 800@500.
	v2 := RSView new.
	v2 color: Color black.
	
	v2 addShape: (TSLabel new
		text: 'Roassal3';
		fontName: 'Impact';
		fontSize: 150;
		border: (TSBorder new color: Color white trans)).
	
	v2 animation repeat onStepDo: [ :t| | paint |
		morph drawOnMockCanvas.
		paint := AthensCairoPatternSurfacePaint createForSurface: morph surface.
		paint origin: ( -100@ -300) .
		v2 shapes first paint: paint.
		v2 signalUpdate ].
	v2 when: TSExtentChangedEvent do: [ v zoomToFit ].
	v2 open extent: 800@500; setLabel: 'Roassal'.
	



"
]

{ #category : #examples }
RSAnimationExamples >> example25AnimationCircle [
	<script: 'self new example25AnimationCircle open setLabel: ''Animation Test'''>
	| canvas radius  shapes update points lines sc1 sc2 |
	canvas := RSCanvas new.
	radius := 50.
	lines := 1.
	canvas addShape: (RSEllipse new
		color: Color black;
		radius: radius).
	shapes := (1 to: 10) collect: [:i | | e |
		e := RSEllipse new
			model: i; 
			index: i;
			size: 5;
			color: Color white;
			yourself.
		i = 1 ifTrue: [ e color: Color red ].
		i = 2 ifTrue: [ e color: Color green ].
		e ].
	
	points := [ :r :i |
		| a b slice |
		slice := Float twoPi / (lines * 2).
		a := (i-1) * slice + Float halfPi.
		b := a + Float pi.
		a := (a cos @ a sin ) * r.
		b := (b cos @ b sin) * r.
		a -> b ].
	update := [ 
		lines := lines + 1.
		lines > 10 ifTrue: [ lines := 2 ].
		canvas nodes copy do: #remove.
		canvas edges copy do: #remove.
		shapes do: [ :e | e model: (e index - 1) / (lines*2) ].
		1 to: lines do: [ :i| | ab |
			ab := points value: radius value: i.
			canvas add: (
				RSLine new
					width: 0.1;
					color: Color white;
					startPoint: ab key;
					endPoint: ab value;
					yourself).
			canvas add: (shapes at: i).
		].
	].
	update value.
	sc1 := NSScale linear range: {0. Float twoPi}.
	sc2 := NSScale linear domain: #(-1 1).
	shapes do: [ :e | | animation |
		animation := canvas newAnimation repeat 
			"easing: TSEasing bounceOut;"
			duration: 2 seconds; onStepDo: [ :t | 
			| val |
			val := (e model + t)%1.
			val := (sc1 scale: val) cos.
			canvas edges size >= e index ifTrue: [ | ab |
				ab := points value: radius - 2.5 value: e index.
				e position: (sc2 range: { ab key. ab value. };
					scale: val).
			] ].
		e index = 1 ifTrue:[ animation when: RSAnimationLoopEvent do: update ] ].
	
	canvas @ RSCanvasController.
	^ canvas
	




]

{ #category : #lines }
RSAnimationExamples >> example26Bezier [
	<script: 'self new example26Bezier open setLabel: ''Bezier Test'''>
	| canvas size theta sc borderWhite cpController |
	canvas := RSCanvas new.
	size := 50.
	theta := 0.
	canvas color: Color black.
	sc := NSScale linear domain: #(-1 1); range: #(0 80).
	cpController := RSBlockCPController new
		block: [ :line | 
			| x1 |
			x1 := sc scale: (theta + (line model * 5)) sin.
			Array
				with: x1 @ 0
				with: 100 @ -100
				with: 100 @ 50
				with: 200 @ -120 ];
		yourself.
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	canvas addAll: ((1 to: size) collectWithIndex: [ :m :index | 
		| com offset edge |
		com := RSComposite new.
		offset := Float twoPi / size * index.
		com matrix rotateByRadians: offset.
		edge := RSBezier new
			color: Color white;
			model: offset;
			width: 2;
			controlPointsController: cpController;
			paint: (Color h: 360 / size * index s: 1 v: 1 alpha: 0.5);
			yourself.
		edge 
			markerEnd: ((RSShapeFactory triangle
					extent: 10@20;
					color: edge paint;
					border: borderWhite;
					yourself) asMarker 
				offset: -10;
				yourself).
		com add: edge.
		com ]).
	canvas newAnimation repeat onStepDo: [ :t | 
		theta := theta + 0.0523.
		canvas nodes do: [ :com | com shapes first update ] ].
	canvas
		when: RSExtentChangedEvent
		do: [ canvas camera zoomToFit: canvas extent extent: 500 @ 500 ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example27RSLocate [
	<script: 'self new example27RSLocate open setLabel: ''RSLocation methods'''>
	| canvas newBox updateText fixedElement movableElement buttons labeled locate label grad1 grad2 color |
	canvas := RSCanvas new.
	locate := RSLocation new.
	color := RSColorPalette qualitative paired3.
	newBox := [ :m | RSBox new
			size: 200;
			color: (color scale: m);
			yourself. ].

	label := RSLabel new.
	updateText := [ 
		label text: 'Offset:', 
			(locate offset x printShowingDecimalPlaces: 1),'@',
			(locate offset y printShowingDecimalPlaces: 1) ].
	updateText value.
	fixedElement := newBox value: 1.
	"movableElement := newBox value: 2."
	movableElement := RSComposite new
		add: (RSLabel new 
			text: 'foo';
			rotateByDegrees: -45;
			yourself);
		adjustToChildren;
		color: (color scale: 2);
		yourself.
	"movableElement size: 40."
	movableElement when: RSMouseClick do: [ 
		canvas newAnimation
			scale: (NSScale linear 
				domain: #(0 0.5 1); 
				range: { 0@0. 20@20. 0@0});
			onStepDo: [ :t | 
				locate offset: t.
				locate move: movableElement on: fixedElement.
				updateText value.
				label signalUpdate.
				 ]  ].
	
	canvas add: fixedElement; add: movableElement; add: label.
	grad2 := (LinearGradientPaint fromArray: 
		{0->'white'.
		0.25->'black'.
		1 ->'lightGray'})
		start: 0@ -15;
		stop: 0@ 15.
	grad1 := (LinearGradientPaint fromArray:
		{0->'lightGray'.
		0.25->'black'.
		1 ->'gray'})
		start: 0@ -15;
		stop: 0@ 15.
	labeled := RSLabeled new.
	labeled shapeBuilder: [ :m | RSLabel new text: m asString; color: Color white ].
	labeled location middle.
	buttons :=  #(outer border inner left center right top middle bottom) collect: [ :t |
		RSBox new
			border: (RSBorder new color: Color lightGray);
			cornerRadius: 5;
			extent: 60@30;
			paint: grad1;
			model: t;
			addInteraction: labeled;
			when: RSMouseEnter do: [:evt | evt shape paint: grad2; signalUpdate ]; 
			when: RSMouseLeave do: [:evt | evt shape paint: grad1; signalUpdate ];
			when: RSMouseClick do: [:evt | | p |
				evt shape model value: locate.
				p := movableElement position.
				locate move: movableElement on: fixedElement.
				canvas newAnimation
					from: p;
					duration: 500 milliSeconds;
					to: movableElement position;
					on: movableElement shape set: #position: ]
			] as: RSGroup.
	RSGridLayout new lineItemsCount: 3; on: buttons.
	RSVerticalLineLayout new alignCenter; gapSize: 30; on: (RSGroup with: canvas nodes with: buttons).
	canvas addAll: buttons.
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera zoomToFit: canvas extent * 0.7.
		canvas signalUpdate ].
	
	^ canvas
]

{ #category : #perlin }
RSAnimationExamples >> example28AlteredWorld [
	"base on Gerard Ferrandez source code"

	"https://codepen.io/ge1doot/details/GQobbq/"

	<script:
	'self new example28AlteredWorld open setLabel: ''Altered World :V'''>
	| canvas extent px perlin r period length |
	canvas := RSCanvas new.
	r := Random new.
	extent := 500 @ 500.
	period := 0.01.
	length := 400.
	canvas clearBackground: false.
	canvas color: Color black.
	px := 0.
	perlin := NSPerlinNoise3 new octaves: 5.
	canvas addAll: ((1 to: extent y / 6) collect: [ :m | 
			 RSPolyline new
				 width: 0.5;
				 yourself ]).
	canvas newAnimation
		loops: extent x;
		duration: 50 milliSeconds;
		when: RSAnimationLoopEvent do: [ 
			canvas edges do: [ :e | 
					| x y n points m |
					x := px.
					y := extent y * r next.
					n := perlin noise: x * period and: y * period.
					e color:
							((Color h: -210 + (n * 600) s: 1 l: 8 * n * n * n) alpha: 0.05).
					points := OrderedCollection new.
					points add: x @ y.
					m := 0.
					[ m < length and: [ y between: 0 and: extent y ] ] whileTrue: [ 
							n := perlin noise: x * period and: y * period.
							x := x + (n * 14) cos.
							y := y + (n * 14) sin.
							points add: x @ y.
							m := m + 1 ].
					e shape controlPoints: points ].
			canvas signalUpdate.
			px := px + 1 ].
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera
			zoomToFit: canvas extent
			rectangle: (Rectangle floatCenter: extent / 2 extent: extent) ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example29Tick [
	<script: 'self new example29Tick open setLabel: ''Can you hear it?'''>
	| c slice animation ios g |
	c := RSCanvas new.
	c color: Color black.
	slice := Float twoPi / 16.
	
	ios := (1 to: 16) collect: [:i | 
		i even
			ifTrue: [ 'I' ]
			ifFalse: [ 'O' ] ].
	g := ios collect: [ :m | RSLabel new
		color: Color gray;
		text: m;
		yourself ].
	g doWithIndex: [ :s :i  | | ang | 
		ang := i * slice.
		s matrix rotateByRadians: ang + Float halfPi.
		s position: (ang cos @ ang sin) * 30.
		 ].
	c add: (RSComposite new
		shapes: g;
		yourself).
	
	c addAll: ('TICK' asArray collectWithIndex: [:m :i | | s |
		s := RSLabel new
			color: Color white;
			text: m asString;
			yourself.
		s position: 0@ ( -60 + (i * 15)).
		s]).
	(c nodes at: 3) remove.
	animation := [:a :b :k | c transitionAnimation 
		duration: 700 milliSeconds;
		easing: RSEasing bounceOut;
		from: a;
		to: b;
		onStepDo: [ :t | | s |
			c nodes first matrix
				loadIdentity;
				rotateByRadians: t.
			s := c nodes first shapes.
			(s at: k key) color: Color lightGray.
			(s at: k value) color: Color white. ]].
	(c animationFrom: { 
		(animation value: 0 value: slice value: 10->11).
		(animation value: slice value: slice * 2 value: 11->10)}) repeat.
	
	c when: RSExtentChangedEvent do: [ c camera zoomToFit: c extent extent: 120 asPoint ].
	^ c
	


]

{ #category : #perlin }
RSAnimationExamples >> example30Perlin [
	<script: 'self new example30Perlin open setLabel: ''Perlin :V'''>
	| canvas random frame scIterations scRadius rect extent maxLife perlin noiseScale respawnTop |
	random := Random new.
	canvas := RSCanvas new.
	canvas clearBackground: false.
	extent := 500@500.
	rect := Rectangle floatCenter: extent/2 extent: extent.
	maxLife := 10.
	perlin := NSPerlinNoise3 new octaves: 3.
	noiseScale := 80.
	canvas color: Color black.
	scIterations := NSScale linear domain: #(0 100); range: #(5 1).
	scRadius := NSScale linear domain: #(0 100); range: #(1 3).
	
	frame := 0.
	respawnTop := [ :e | 
		e 
			propertyAt: #life put: random next* maxLife;
			position: random next @ 0 * extent ].
		
	canvas addAll: ((1 to: 100) collect: [:n | | e c1 c2 |
		c1 := c2 :=  Color white.
		(random next * 3) asInteger = 1 ifTrue: [ 
			c1 := Color purple.
			c2 := Color cyan ].
		e := RSEllipse new.
		e size: (scRadius scale: n).
		e properties
			at: #c1 put: c1;
			at: #c2 put: c2;
			at: #iterations put: (scIterations scale: n).
		respawnTop value: e.
		e ]).
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame + 1.
		
		canvas nodes do: [ :e |
			| life p heading vel color alpha |
			life := e propertyAt: #life.
			e propertyAt: #life put: (life := life - 0.01666).
			life < 0 ifTrue: [ respawnTop value: e ].
			p := e position.
			vel := 0@0.
			1 to: (e propertyAt: #iterations) do: [ :k | 
				| transition angle |
				transition := p x / extent x.
				angle := (perlin
					noise: p x / noiseScale
					and: p y / noiseScale) * transition * Float twoPi * noiseScale.
				vel := angle cos @ angle sin * 0.2.
				p := p + vel. ].
			(rect containsPoint: p) ifFalse: [respawnTop value: e].
			e position: p.
			
			
			heading := vel angle / Float twoPi.
			heading < 0 ifTrue: [ heading := heading negated ].
			color := NSScale linear 
				range: { e propertyAt: #c1. e propertyAt: #c2 }; scale: heading.
			alpha := life * 5 / maxLife min: 1.
			alpha := (maxLife - life * 5 )/ maxLife min: alpha.
			e color: (color alpha: alpha).
			 ]. ].
	canvas when: RSExtentChangedEvent do: [ canvas camera 
		zoomToFit: canvas extent
		rectangle: rect ].
	^ canvas
	
]

{ #category : #examples }
RSAnimationExamples >> example31RoundRectagles [
	"example inspired in paper.js"
	<script: 'self new example31RoundRectagles open setLabel: ''Round Rectangles'''>
	| canvas mouse extent frame scale color |
	canvas := RSCanvas new.
	extent := 500@500.
	mouse := 0@0.
	scale := [ :i | (1- (i / 25)) * 10 ].
	color := RSColorPalette sequential blues9.
	canvas addAll:  ((1 to: 25) collect: [ :n |
		RSBox new
			size: 25 * (scale value: n);
			cornerRadius: 6 * (scale value: n);
			color: (color scale: n);
			yourself  ] ).
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera zoomToFit: canvas extent extent: extent ].
	canvas when: RSMouseMove do: [ :evt | mouse := evt position. ].
	frame := 0.
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame + 1.
		canvas nodes doWithIndex: [ :e :index | | pos angle |
			pos := e position + ((mouse - e position) / (index + 5)).
			angle := e propertyAt: #angle ifAbsentPut: [ 0 ].
			angle := angle +(((frame + index) / 10) sin * 7).
			e propertyAt: #angle put: angle.
			e matrix 
				loadIdentity;
				translation: pos;
				rotateByDegrees: angle.
			]].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example32SimpleClock [
	<script: 'self new example32SimpleClock open setLabel: ''4 gradient corners'''>
	| canvas extent half linear color label roassal clock location |
	canvas := RSCanvas new.
	extent := 800 @ 600.
	half := extent / 2.
	linear := [ :val :a :b | 
	(LinearGradientPaint fromArray: val)
		start: a * half;
		stop: b * half ].
	color := NSScale ordinal range:
		{(linear value: {0 -> '7D66E9'. 1 -> 'E664AC'} value: -1 @ 1 value: 1 @ -1).
		(linear value: {0 -> '71C1E2'. 0.9 -> Color transparent} value: -1 @ -1 value: 0 @ 1).
		(linear value: {0 -> 'EDB259'. 0.9 -> Color transparent} value: 1 @ 1 value: 0 @ -1)}.

	canvas addAll: ((1 to: 3) collect: [:i | 
		RSBox new
			draggable;
			extent: extent;
			color: (color scale: i);
			yourself
		]).
	label := [:t | RSLabel new
		fontSize: 40;
		color: Color white;
		text: t;
		yourself 
	].
	roassal := label value: 'Roassal3 2019'.
	clock := label value: Time now print24.
	clock fontSize: 100.
	canvas add: roassal.
	canvas add: clock.
	canvas newAnimation
		duration: 500 milliSeconds;
		repeat;
		when: RSAnimationLoopEvent do: [ clock text: Time now print24 ].
	location := RSLocation new
		inner;
		bottom;
		offset: 0 @ -15.
	location move: roassal on: canvas nodes.
	canvas
		addShape: (RSBitmap new form: PolymorphSystemSettings pharoLogoForm).
	location
		top;
		offset: 0 @ 15.
	location move: canvas shapes last on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example33AnimatedLayout [
	<script: 'self new example33AnimatedLayout open setLabel: ''Layouts'''>
	| c objects layout update labels shapes color |
	c := RSCanvas new.
	objects := 1 to: 100.
	
	color := RSColorPalette sequential ylorrd9.
	shapes := objects collect: [ :m |
		RSBox new
			border: RSBorder new;
			color: (color scale: m);
			size: 10;
			model: m;
		yourself ].
	c addAll: shapes.
	RSEdgeBuilder line 
		canvas: c;
		objects: objects;
		connectFrom: [ :value | value //2 ] to: #yourself.
	layout := RSLayoutBuilder new.
	update := [ :sel | 
		layout perform: sel asSymbol.
		layout on: shapes.
		 ].
	update value: #tree.
	RSZoomToFitCanvas new animatedZoomToFit: c.

	labels := #('grid' 'tree' 'cell' 'horizontalTree' 'cluster' 'circle' 'radial' 'sugiyama').
	labels := labels collect: [ :sel |
		RSLabel new
			isFixed: true;
			text: sel capitalized;
			when: RSMouseLeave do: [ :evt | evt shape 
				color: Color black; 
				normal;
				signalUpdate ];
			when: RSMouseEnter do: [ :evt | evt shape 
				color: Color blue; 
				underline;
				signalUpdate ];
			when: RSMouseClick do: [ :evt | | pos1 pos2 |
				pos1 := shapes collect: #position.
				update value: sel.
				pos2 := shapes collect: #position.
				c newAnimation onStepDo: [ :t |
					shapes doWithIndex: [ :e :i |
						e translateTo: ((pos1 at: i) 
							interpolateTo: (pos2 at: i) at: t) ].
					c zoomToFit ] ] ].
	c addAll: labels.
	RSHorizontalLineLayout on: labels.
	^ c
	
]

{ #category : #examples }
RSAnimationExamples >> example34ForceLayout [
	<script: 'self new example34ForceLayout open'>
	| c classes layout |
	c := RSCanvas new.
	classes := Collection withAllSubclasses collect: [ :cls | | e |
		e := RSEllipse new
			draggable;
			model: cls;
			color: Color purple translucent;
			size: 10;
			yourself.
		cls = Collection ifTrue: [ e color: Color red ].
		e
		 ].

	RSEdgeBuilder line
		canvas: c;
		shapes: classes;
		color: (Color purple alpha: 0.2);
		connectFrom: #superclass to: #yourself.
	c addAll: classes.
	layout := RSForceBasedLayout new 
		nodes: classes;
		edges: c edges;
		start;
		yourself.
	c newAnimation repeat onStepDo: [ :t | 
		layout step ].

	^ c
	


]

{ #category : #examples }
RSAnimationExamples >> example35Roassal [
	<script: 'self new example35Roassal open'>
	| canvas points paint fscale timeSize text |
	canvas := RSCanvas new.
	text := 'Roassal3'.
	points := RSPolygon 
		generateUnitNgonPoints: 3
		rotation: Float pi.
	
	canvas addShape: (RSPolygon new
		cornerRadii: 5;
		color: Color red;
		points: points;
		size: 300;
		position: 0@0).
	canvas addShape: (RSPolygon new
		cornerRadii: 5;
		border: (RSBorder new color: Color white; width: 5);
		noPaint;
		points: points;
		position: 0@ -3;
		size: 280).
	
	timeSize := 500.
	fscale := NSScale linear range: #(130 80).
	paint := LinearGradientPaint new 
		colorRamp: {0 -> Color white};
		start: 0@ -100;
		stop: 0@100.
	text doWithIndex: [ :char :index | |lbl |
		lbl := RSLabel new
			text: char;
			bold;
			fontName: 'Marker Felt';
			position: 0@ -40;
			border: (RSBorder new color: Color white; width: 3);
			paint: paint;
			fontSize: 130.
		canvas newAnimation
			duration: timeSize milliSeconds;
			delay: ((index - 1) * timeSize) milliSeconds;
			onStepDo: [ :t |
				lbl isInACanvas ifFalse: [ canvas addShape: lbl].
				lbl fontSize: (fscale scale: t).
				paint colorRamp: 
					{ 0 -> Color white. 
					t -> Color white.
					t+0.001->Color transparent.
					1 -> Color transparent } ];
			when: RSAnimationEndEvent do: [ lbl remove ].
		 ].
	canvas newAnimation duration: (timeSize * text size) milliSeconds ; when: RSAnimationEndEvent do: [
		canvas addShape: (RSLabel new
		text:  text;
		bold;
		position: 5@ -50;
		fontName: 'Marker Felt';
		color: Color white;
		fontSize: 30).
		canvas newAnimation
			easing: RSEasing elasticOut;
			from: -1; to: 0; onStepDo: [ :t |
			canvas shapes last matrix shy: t ] ]. 
	canvas when: RSExtentChangedEvent do: [ canvas camera zoomToFit: canvas extent * 0.8 extent: 300@300 ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example36Title [
	<script: 'self new example36Title open setLabel: ''Basic Animation'''>
	| c t1 t2 s line1 line2 line3 line4 title desc r1 r2 pad mid marker sum lineAnime p lblbase |
	c := RSCanvas new.
	t1 := 'Roassal3'.
	t2 := 'It is a new agile visualization engine
for Pharo 7 and Pharo 8.'.
	lblbase := RSLabel new
		color: Color white;
		fontSize: 30;
		fontName: 'Marker Felt';
		withBorder;
		yourself.
	s := [ :m | lblbase copy text: m ].
	desc := t2 lines collect: [:m | s value: m ] as: RSGroup.
	RSVerticalLineLayout new
		gapSize: 0;
		on: desc.
	desc := desc asShape.
	lblbase fontSize: 25.
	title := s value: t1.

	RSLocation new 
		outer; right; top;
		offset: title width / -2 @ -20;
		move: title on: desc.
	
	r1 := title encompassingRectangle.
	r2 := desc encompassingRectangle.
	pad := 15.
	mid := (r2 origin + r1 corner)/2. 

	marker := RSPieSlice new 
		color: Color black;
		externalRadius: 5;
		alphaAngle: -90;
		betaAngle: -90.
	line1 := RSPolyline new
		cornerRadii: 30;
		markerEnd: marker;
		controlPoints: {
			mid.
			(r1 corner x + (pad * 2) ) @ mid y.
			r1 topRight + ((pad *2) @ pad negated ).
			r1 origin - pad asPoint }.
	line2 := RSPolyline new 
		markerEnd: marker;
		cornerRadii: 50;
		controlPoints: { 
			mid.
			(r2 origin x - (pad*2)) @ mid y.
			r2 bottomLeft + ( pad negated * 2 @ pad). 
			(r1 corner x @ r2 corner y)  + (pad@pad)}.
	line3 := RSPolyline new
		cornerRadii: 30;
		controlPoints: { 
			r1 rightCenter  + ( pad * 3 @ 0).
			r1 topRight + (3@ -2 * pad).
			r1 topCenter + (0 @ -2 * pad) } .
	line4 := RSPolyline new
		cornerRadii: 50;
		controlPoints: {
			r2 leftCenter + (-3 @ 0 * pad).
			r2 bottomLeft + (-3 @ 2 * pad).
			r2 bottomCenter + (0 @ 2 * pad).
		}.
	c addShape: line1.
	c addShape: line2.
	c addShape: line3.
	c addShape: line4.
	c camera 
		zoomToFit: c extent * 0.8 
		rectangle: c encompassingRectangle.
	sum := [ :line | |cp|
		cp := line controlPoints.
		(cp first x - cp second x) abs + 
		(cp second y - cp third y) abs + 
		(cp third x - cp fourth x) abs  ].
	lineAnime := [ :line :lbl :pscale :array |
		line border dashArray: array.
		c newAnimation 
			from: 0;
			to: (sum value: line);
			onStepDo: [ :t | array at: 1 put: t ].
		c newAnimation 
			duration: 1 second; 
			when: RSAnimationEndEvent do: [ c add: lbl ].
		c newAnimation
			delay: 1 second;
			duration: 1 second;
			from: 0.05;
			to: 1;
			onStepDo: [ :t |
				lbl matrix loadIdentity;
					translation: (pscale scale: t );
					scaleBy: t @ 1.  ].
	 	].
	p := title position.
	lineAnime 
		value: line1 
		value: title
		value: (NSScale linear range: {(p x + (title width/2))@ p y. p })
		value: { 0. 1000 }.
	p := desc position.
	lineAnime 
		value: line2
		value: desc 
		value: (NSScale linear range: {(p x - (desc width/2))@ p y. p })
		value: { 0. 1000 }.
	c newAnimation
		delay: 2 seconds;
		duration: 1 second;
		from: 0; to: 360;
		onStepDo: [ :t | marker betaAngle: t - 90.].
	^ c.
	"TODO add animation to line3 and line4, hide and remove with animation these elements"
]

{ #category : #examples }
RSAnimationExamples >> example37RectangleForceLayout [
	<script: 'self new example37RectangleForceLayout open'>
	| canvas classes layout color |
	canvas := RSCanvas new.
	color := NSScale category20.
	classes := Collection withAllSubclasses collect: [ :cls |
		RSBox new
			model: cls;
			color: (color scale: cls);
			size: 10;
			yourself ] as: RSGroup.
	RSEdgeBuilder line
		canvas: canvas;
		shapes: classes;
		color: (Color blue alpha: 0.5);
		connectFrom: #superclass to: #yourself.
	canvas addAll: classes.
	
	layout := RSRectangleForceLayout new
		nodes: classes;
		edges: canvas edges;
		start;
		yourself.
	canvas @ RSSimpleCanvasMonitor.
	canvas newAnimation repeat onStepDo: [ :t | layout step. ].

	"Apply forces from the window borders to the elements."
	canvas when: RSExtentChangedEvent do: [ :evt |
		| camera origin corner |
		camera := canvas canvas camera.
		origin := camera fromPixelToSpace: 0@0.
		corner := camera fromPixelToSpace: canvas canvas extent.
		layout enclosingRectangle: (origin corner: corner).
	].
	classes @ (RSDraggableForce new layout: layout).

	canvas camera scale: 2.
	^ canvas
]

{ #category : #perlin }
RSAnimationExamples >> example38PerlinRose [
	<script: 'self new example38PerlinRose open extent: 800@600; setLabel: ''Rose'''>
	| canvas offset offsetInc inc m s tau perlin border |
	canvas := RSCanvas new.
	offset:= 0@0.			"Perlin offset"
	offsetInc := 0.006.	"Perlin offset increment"
	inc := 1. 				"Perlin increment"
	m := 1.005.				"size multiplier"
	s := 1.					"Start size of perlin ring"
	tau := 6.2831855.		"It is the circle constant relating the circumference of a circle to its linear dimension"
	canvas color: Color black.
	perlin := NSPerlinNoise3 new. 
	perlin octaves: 3.
	canvas clearBackground: false.
	border := RSBorder new
		color: (Color blue alpha: 0.1);
		yourself.
	canvas addAll: ((1 to: 10) collect: [ :i | 
		RSPolygon new 
			noPaint
			border: border;
			yourself]).
	canvas newAnimation 
		loops: 1000;
		duration: 50 milliSeconds;
		when: RSAnimationLoopEvent do: [ :evt | 
			"Create a series of perlin rings from big to small"
			s < 2000 ifTrue: [ 
				canvas nodes do: [ :e | | nPoints points |
					nPoints := 2* Float pi * s.
					nPoints := nPoints min: 500.
					points := (1 to: nPoints) collect: [ :i | 
						|a p n |
						a := i / nPoints * tau.
						p := a cos @ a sin.
						n := (perlin 
							noise: offset x + (p x * inc)
							and: offset y + (p y * inc )) * s.
						p * n ].
					e points: points.
					offset := offset + offsetInc.
					s := s * m
				]
			] ifFalse: [evt animation stop].
			canvas signalUpdate. ].
	^ canvas




]

{ #category : #perlin }
RSAnimationExamples >> example39Duna [
	<script: 'self new example39Duna  open extent: 1000@700; position: World center - (1000@700 / 2)'>
	| canvas extent num color noiseScale perlin c particles |
	canvas := RSCanvas new.
	extent := 1000@700.
	canvas clearBackground: false.
	num := 1000.
	color := Color purple.
	noiseScale := 400. "<<<-- change this"
	perlin := NSPerlinNoise3 new. 
	perlin octaves: 2."<<<-- also this :D"
	c := NSScale linear 
		domain: { 0. num/2 };
		range: { color alpha: 0.8. color alpha: 0 }.
	particles := (1 to: num) collect: [ :n | 
		RSEllipse new
			size: 1;
			isFixed: true;
			position: n @ extent y;
			color: (c scale: (n - (num / 2)) abs);
			yourself ].
	canvas addAll: particles.
	canvas newAnimation repeat; onStepDo: [ :t | 
		particles do: [ :particle | 
			| p dir vel  |
			p := particle position.
			dir := Float twoPi * (perlin 
				noise: p x / noiseScale 
				and: p y / noiseScale).
			vel := dir sin @ dir cos * 0.5.
			particle translateBy: vel.
			 ].
		 ].
	^ canvas
]

{ #category : #examples }
RSAnimationExamples >> example40Circles [
	<script: 'self new example40Circles open'>
	| canvas max min gscale alpha scale circleSize vertexSize updateMouse center getSize color frameCount |
	canvas := RSCanvas new.
	canvas color: Color black.

	max := 2500.
	min := 100.
	gscale := NSScale linear
		range: { max@20. min@3 }.
	alpha := NSScale linear
		domain: { min. max };
		range: { 0.6. 0.12 }.
	scale := 300.

	updateMouse := [ :pos | | offset size |
		offset := pos abs.
		gscale domain: { 0@0. canvas extent/2 }.
		size := gscale scale: offset.
		circleSize := size x.
		vertexSize := size y.
		 ].
	center := [ :theta :time | 
		| dir distance |
		dir := theta cos @ theta sin.
		distance := 0.6 + (0.2 * (theta * 6 + (theta * 8 + time) cos ) cos ).
		dir * distance * scale. ].

	getSize := [ :theta :time | 
		| offset |
		offset := 0.2 + (0.12 * (theta * 9 - (time * 2) ) cos).
		scale * offset
		].
	color := [ :theta :time |
		| th |
		th := 8*theta + (time * 2).
		Color 
			r: 0.6 + (0.4 * th cos)
		 	g: 0.6 + (0.4 * (th - (Float pi / 3) ) cos  )
			b: 0.6 + (0.4 * (th - (Float pi * 2 / 3) ) cos )
			alpha: (alpha scale: circleSize) ].
	canvas 
		when: RSMouseMove 
		do: [ :evt | updateMouse value: evt position ].
	updateMouse value: 0@0.
	frameCount := 0.
	canvas newAnimation
		repeat;
		onStepDo: [ :t |
			frameCount := frameCount + 1.
			canvas shapes copy do: #remove.
			1 to: circleSize do: [ :ci | 
				| time thetaC c circleCenter cSize points |
				time := frameCount / 20.
				thetaC := ci * Float twoPi / circleSize.
				circleCenter := center value: thetaC value: time.
				cSize := getSize value: thetaC value: time.
				c := color value: thetaC value: time.
				points := (1 to: vertexSize) collect: [:vi | 
					| thetaV |
					thetaV := vi * Float twoPi / vertexSize. 
				 	(thetaV cos @ thetaV sin) * cSize + circleCenter 
					].
					
				canvas add: (RSPolygon new 
					noPaint;
					border: (RSBorder new color: c);
					points: points;
					yourself).
				 ].
		].
	^ canvas 
]

{ #category : #perlin }
RSAnimationExamples >> example41River [
	<script: 'self new example41River open setLabel: ''River''; extent: 900@200.'>
	| extent half c r back rect perlin cScale alphaS inc setParticles |
	extent := 900@ 200.
	half := extent / 2.
	c := RSCanvas new.
	c clearBackground: false.
	c color: Color black.
	r := Random new.
	back := RSBox new
		color: Color black translucent;
		extent: extent;
		yourself.
	rect := back encompassingRectangle.
	perlin := NSPerlinNoise3 new octaves: 3.

	cScale := NSScale linear
		domain: { half negated y. half y};
		range: #(255 0).
	alphaS := NSScale linear
		domain: { half negated x. half x};
		range: #(0.05 0.4).
	inc := 0.
	setParticles := [ 
		c nodes copy do: #remove.
		c add: back.
		c addAll: ((1 to: 3000) collect: [:i | 
			| box |
			box := RSBox new
				size: 1;
				position: (r next @ r next) * extent - half.
			
			box 
				color: (Color 
					r: 40
					g: (cScale scale: box position y)
					b: 255
					range: 255);
				propertyAt: #update put: [ | theta p |
					p := box position.
					theta := (perlin 
						noise: p x * 0.006 + inc
						and: p y * 0.004 + inc) * Float twoPi.
					p := p + (theta cos @ theta sin * 2).
					p x < rect origin x ifTrue: [ p := rect corner x @ p y ].
					p x > rect corner x ifTrue: [ p := rect origin x @ p y ].
					p y < rect origin y ifTrue: [ p := p x @ rect corner y ].
					p y > rect corner y ifTrue: [ p := p x @ rect origin y ].
					box translateTo: p
				 ].
			box 
			])  ].
	setParticles value.
	c
		when: RSMouseClick do: setParticles;
		when: RSMouseMove do: [ :evt | | alpha |
			alpha := alphaS scale: evt position x.
			back color: (Color black alpha: alpha) ].
	c newAnimation repeat onStepDo: [ :t | 
		inc := inc + 0.008. 
		c shapes do: [ :node | (node propertyAt: #update) value ]
		].
	^ c
]

{ #category : #lines }
RSAnimationExamples >> example42OneLine [
	<script: 'self new example42OneLine open extent: 1112@834; setLabel: ''One line'''>
	| canvas line ang1 ang2 radio x1 y1 x2 y2 |
	canvas := RSCanvas new clearBackground: false.
	canvas color: Color black.
	canvas add: (line := RSLine new).
	ang1 := 0. ang2 := 0.radio := 200. 
	canvas newAnimation repeat onStepDo: [ :t | | nx ny |
		line color: (Color h: ang2 radiansToDegrees s: 1 v: 1 alpha: 0.1).
		nx := ang2 sin * radio.
		ny := ang2 cos * radio.
		x1 := nx - (ang1 sin * radio).
		y1 := ny - (ang1 cos * radio).
		x2 := nx + (ang1 sin * radio).
		y2 := ny + (ang1 cos * radio).
		line startPoint: x1@y1; endPoint: x2@y2.
		ang1 := ang1 + (Float pi / 33).
		ang1 > Float twoPi ifTrue: [ ang1 := 0 ].
		ang2 := ang2 + (Float pi / 360).
		ang2 > Float twoPi ifTrue: [ ang2 := 0 ].
		].
	^ canvas
]

{ #category : #lines }
RSAnimationExamples >> example43Waves [
	<script: 'self new example43Waves open
		position: 0@20;
		color: Color transparent;
		setLabel: ''Waves'';
		extent: 1600@1000'>
	| canvas frame size extent perlin paint height points |
	canvas := RSCanvas new.
	canvas color: Color transparent.
	frame := 0.
	size := 100.
	extent := 1600@1000.
	perlin := NSPerlinNoise2 new.
	paint := NSScale linear domain: { 0. size }.
	height := NSScale linear range: { extent y* 0.3. extent y* 0.6}.
	canvas newAnimation repeat
		onStepDo: [ :t |
			canvas edges copy do: #remove.
			0 to: size do: [ :i | | color |
				color := paint scale: i.
				color := Color gray: color.
				points := (-10 to: extent x + 11 by: 20) collect: [ :x | | y n |
					n := perlin noise: x*0.004 y: i * 0.03 z: frame * 0.05.
					n := (n + 1) / 2.
					y := height scale: n.
					x @ y. ].
				canvas add: (RSPolyline new
					isFixed: true;
					width: 2;
					borderColor: color;
					controlPoints: points;
					yourself)
				].
			frame := frame + 1. ].
	^ canvas
]

{ #category : #perlin }
RSAnimationExamples >> example44A [
	<script: 'self new example44A open'>
	"
|c|
	c := RSCanvas new.
c add: (RSLabel new
	border: (RSBorder new color: Color black);
	paint: Color red;
	text: 'A';
	fontSize: 100;
	yourself).
c svgExporter export"

	| canvas r path perlin visitor frame |
	canvas := RSCanvas new.
	r := Random new.
	path := RSSVGPath new.
	perlin := NSPerlinNoise3 new octaves: 5.
	"generated with https://github.com/ObjectProfile/Roassal3Exporters"
	path svgPath: 'M 27.063543 -48.93775 L 22.938543 -35.594001 L 49.204165 -35.594001 L 45.063541 -48.93775 C 43.469791 -53.820562 41.958072 -58.687749 40.532291 -63.531498 C 39.114323 -68.375248 37.692448 -73.328372 36.266667 -78.390872 L 35.735417 -78.390872 C 34.399479 -73.328372 33.020573 -68.375248 31.594792 -63.531498 C 30.176824 -58.687749 28.665105 -53.820562 27.063543 -48.93775 Z M 0.407295 -0.000254728 L 30.001042 -87.468996 L 42.532291 -87.468996 L 72.126038 -0.000254728 L 60.266664 -0.000254728 L 52.00104 -26.672127 L 20.126043 -26.672127 L 11.735419 -0.000254728 Z M 72.532288 -0.000254728'.
	
	visitor := RSBlockSegmentsVisitor new.
	visitor simplePoints:[ :segment :current |
		canvas addAll: ((segment pointsWithStart: current) collect: [:p |
			(RSEllipse new
				size: (r next * 1.5 +0.5);
				position: p;
				color: Color black;
				yourself) ]).
		].
		
	path accept: visitor.

	frame := 0.
	canvas newAnimation repeat; onStepDo: [ :t |
		canvas nodes doWithIndex: [ :each :i | 
			| n |
			n := (perlin noise: (each position + frame)* 0.01)- 0.5.
			each translateBy: n.
			].
		frame := frame + 1.
		canvas signalUpdate.
		].
	canvas zoomToFit.
	^ canvas
		
		
]
