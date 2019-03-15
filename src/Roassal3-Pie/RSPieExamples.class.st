"
I have examples for RSPieBuilder
"
Class {
	#name : #RSPieExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Pie-Examples'
}

{ #category : #data }
RSPieExamples >> esportPrizepool [
	"source https://www.esportsearnings.com/games"
	| arr data |
	arr := {
		{'Dota' . 2013 . 2874380}.
		{'Dota' . 2014 . 10931105}.
		{'Dota' . 2015 . 18429613}.
		{'Dota' . 2016 . 20770460}.
		{'Dota' . 2017 . 24787916}.
		{'SC2' . 2013 . 250000}.
		{'SC2' . 2014 . 250000}.
		{'SC2' . 2015 . 250000}.
		{'SC2' . 2016 . 500000}.
		{'SC2' . 2017 . 700000}.
		{'LOL' . 2013 . 246575}.
		{'LOL' . 2014 . 2130000}.
		{'LOL' . 2015 . 2130000}.
		{'LOL' . 2016 . 5070000}.
		{'LOL' . 2017 . 4946969}}.
	data := Dictionary new.
	arr do: [ :d | 
		| list |
		list := data at: d first ifAbsentPut: [ OrderedCollection new ].
		list add: d second -> d third ].
	^ data
	
]

{ #category : #examples }
RSPieExamples >> example01Basic [
	<script: 'self new example01Basic'>
	| classes pie |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPieBuilder new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	pie build.
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example02Emphasize [
	<script: 'self new example02Emphasize'>
	| classes pie |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPieBuilder new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	pie shape 
		if: [ :cls | cls numberOfMethods > 100 ] 
		actions: [ :s |
			s 
				onElement;
			 	position: [ :e | | angle |
					angle := (e alphaAngle + e betaAngle) / 2.
					angle := angle degreesToRadians.
					20 * (angle cos @ angle sin negated ) ]. ].
	
	pie build.
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example03BasicColors [
	<script: 'self new example03BasicColors'>
	| classes pie colors |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPieBuilder new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	colors := TSScale category10.
	"pie shape color: [:cls | colors scale: cls]"
	pie shape 
		color: colors;
		segmentSpacing: 5;
		externalRadius: 120.
	pie build.
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example04SegmentSpacingAnimation [
	<script: 'self new example04SegmentSpacingAnimation'>
	| pie colors |
	pie := RSPieBuilder new
		objects: #(3 3 2 2 5 8 14);
		yourself.
	colors := TSScale google20.
	pie shape 
		onElement;
		color: colors;
		border: (TSBorder new);
		onModel;
		segmentSpacing: 5;
		innerRadius: 50;
		externalRadius: 200.
	pie build.
	pie view animation 
		repeat;
		easing: TSEasing sinIn;
		duration: 5 seconds;
		from: 0; 
		to: 180;
		onStepDo: [ :t | 
			pie view elements do: [ :e | | op |
				op := 125 - (t degreesToRadians sin abs * 125).
				e segmentSpacing: op. ] ].
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example05Smash [
	<script: 'self new example05Smash'>
	| pie colors r |
	r := SharedRandom globalGenerator.
	pie := RSPieBuilder new
		objects: ((1 to: 10) collect: [:e | r next]) sort;
		yourself.
	colors := TSScale category10.
	pie shape 
		onElement;
		color: colors;
		onModel;
		border: (TSBorder new width: 1.5);
		innerRadius: 0;
		externalRadius: 200.
	pie build.
	pie elements do: [ :e | | a b |
		a := e alphaAngle.
		b := e betaAngle.
		pie view animationFrom: { 
			(pie view tAnimation 
				duration: 2 seconds;
				easing: TSEasing bounceOut;
				onStepDo: [ :t |
					e 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie view tAnimation 
				delay: (50 * e index) milliSeconds;
				duration: 750 milliSecond;
				easing: TSEasing elasticOut;
				from: 0;
				to: 120;
				on: e trachelShape set: #innerRadius: ) }. ].
	
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example06SmashHSL [
	<script: 'self new example06SmashHSL'>
	| pie |
	pie := RSPieBuilder new
		objects: (1 to: 360);
		yourself.
	"pie shape 
		removeCommandsBySelector: #alphaAngle:;
		removeCommandsBySelector: #betaAngle:."
	pie shape 
		onElement; 
		innerRadius: 0;
		externalRadius: 200;
		alphaAngle: [:e| e index - 1 ];
		betaAngle: [:e | e index + 1 ];
		color: [:e | Color h: e index s: 1 l: 0.5].
	pie build.
	pie elements do: [ :e | | a b |
		a := e alphaAngle.
		b := e betaAngle.
		pie view animationFrom: { 
			(pie view tAnimation 
				duration: 2 seconds;
				easing: TSEasing bounceOut;
				onStepDo: [ :t |
					e 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie view tAnimation 
				delay: (10 * e index) milliSeconds;
				duration: 2 seconds;
				easing: (TSEasing elasticOut period: 0.30; amplitude: 0.8) ;
				from: 0;
				to: 120;
				on: e trachelShape set: #innerRadius: ) }. ].
	
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example07Dendi [
	<script: 'self new example07Dendi'>
	| pie colors r |
	r := SharedRandom globalGenerator.
	pie := RSPieBuilder new
		objects: ((1 to: 10) collect: [:e | r next]) sort;
		yourself.
	colors := TSScale category20b.
	pie shape 
		onElement;
		color: colors;
		onModel;
		border: (TSBorder new width: 1.5);
		externalRadius: 200.
	pie build.
	pie elements do: [ :e | | a b |
		a := e alphaAngle.
		b := e betaAngle.
		pie view animationFrom: { 
			(pie view tAnimation 
				easing: TSEasing bounce;
				onStepDo: [ :t |
					e 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie view tAnimation 
				delay: 3 seconds;
				easing: TSEasing  bounce;
				onStepDo: [:t | 
					e
						alphaAngle: a + ((360 - a) * t);
						betaAngle: b + ((360 - b) * t) ] ) }. ].
	
	pie open.
]

{ #category : #examples }
RSPieExamples >> example08CornerRadii [
	<script: 'self new example08CornerRadii'>
	| pie colors |
	pie := RSPieBuilder new
		objects: #(1 1 2 3 4 8 14 21);
		yourself.
	colors := TSScale category20c.
	pie shape 
		onElement;
		color: colors;
		onModel;
		border: (TSBorder new width: 1.5);
		externalRadius: 220;
		innerRadius: 220/3;
		cornerRadii: 30.
	pie build.
	
	pie open.
]

{ #category : #examples }
RSPieExamples >> example09TickAnimation [
	<script: 'self new example09TickAnimation'>
	| pie |
	pie := RSPieBuilder new.
	pie objects: (0 to: 360).
	pie shape 
		removeCommandsBySelector: #alphaAngle:;
		removeCommandsBySelector: #betaAngle:.
	pie shape 
		externalRadius: 200;
		innerRadius: 150;
		alphaAngle: #yourself;
		betaAngle: [:d | d + 2]."avoid arc spacing"
	pie build.
	pie view animation repeat; from: 0; to: 500;
		easing: TSEasing elasticOut;
		onStepDo: [ :t |
			pie elements do: [ :e |
				e color: (Color h: e model + t s: 1 l: 0.5) ] ].
	
	pie open.
]

{ #category : #examples }
RSPieExamples >> example10CornerRadiiAnimation [
	<script: 'self new example10CornerRadiiAnimation'>
	| pie colors |
	pie := RSPieBuilder new.
	pie objects: #(1 1 2 3 4 8 14 21).
	
	pie shape 
		color: nil;
		segmentSpacing: 1;
		border: (TSBorder new width: 1.5; color: Color gray);
		externalRadius: 220;
		innerRadius: 70.
	pie build.
	
	colors := TSScale paired12.
	pie shape
		onElement;
		color: colors.

	pie build.
	pie view animation repeat
		onStepDo: [ :k |
			pie elements do: [ :el | 
				| t |
				t := 1 - ((k - 0.5) abs * 2).
				el cornerRadii: (220-70)/2 * t ]
			 ].
	
	pie open.


]

{ #category : #examples }
RSPieExamples >> example11OpenningAnimation [
	<script: 'self new example11OpenningAnimation'>
	| pie colors bounce inout outin reset |
	pie := RSPieBuilder new.
	pie objects: #(1 1 2 3 4 8 14 21) reverse.
	colors := TSScale category20.
	pie shape 
		onElement;
		color: [:e | colors scale: e index];
		segmentSpacing: 1;
		border: (TSBorder new width: 1.5; color: Color gray);
		externalRadius: 220;
		innerRadius: 70.
	reset := [ pie elements do: #remove. pie build. pie view signalUpdate ].
	pie build.
	
	bounce := pie view tAnimation from: 0; to: 360; 
		easing: TSEasing bounceOut;
		onStepDo: [ :t | 
		pie elements do: [ :e | | beta |
			beta := e attributes at: #beta.
			(t between: e alphaAngle and: beta)
				ifTrue: [ e betaAngle: t ].
			t >= beta ifTrue: [ e betaAngle: beta ].
			t < e alphaAngle ifTrue: [ e betaAngle: e alphaAngle ]
			 ] ].
	bounce when: TSAnimationStartEvent do: [ 
		pie elements do: [ :e|
			e attributes at: #beta put: e betaAngle.
			e betaAngle: e alphaAngle.
			 ] ].
	bounce when: TSAnimationEndEvent do: reset.
	
	inout := pie view tAnimation 
		delay: 1 second;
		easing: TSEasing backOut;
		onStepDo: [ :t |
			pie elements do: [ :e |
				e innerRadius: 70 * t.
				e externalRadius: 220 * t ]
			 ].
	inout when: TSAnimationEndEvent do: reset.
	
	outin := pie view tAnimation
		delay: 1 second;
		easing: TSEasing elasticOut;
		onStepDo: [ :t |
			pie elements do: [ :e | | p a b att |
				att := e attributes.
				p := att at: #position ifAbsentPut: [ 
					| angle |
					angle := (e alphaAngle + e betaAngle)/2 + 180.
					angle := angle degreesToRadians.
					TSScale linear range: {300*(angle cos@angle sin negated). 0@0 } ].
				a := att at: #alpha ifAbsentPut: [ 
					TSScale linear range: { e alphaAngle + 180. e alphaAngle } ].
				b := att at: #beta ifAbsentPut: [ 
					TSScale linear from: e betaAngle + 180; to: e betaAngle; yourself ].
				e position: (p scale: t).
				e alphaAngle: (a scale: t).
				e betaAngle: (b scale: t).
				 ] ].
	"It is not necessary rebuild all the arc, you can reuse them
	but I did not try this animation event, for that reason I use it"
	outin when: TSAnimationEndEvent do: reset.
	(pie view animationFrom: { bounce. inout. outin }) repeat.
	pie open.


]

{ #category : #examples }
RSPieExamples >> example12RainbowPie [
	<script: 'self new example12RainbowPie'>
	| pie frame n d w |
	n := 48.
	d := 100.
	frame := 0.
	pie := RSPieBuilder new
		objects: (1 to: n);
		slice: [:v | 1 ].
	pie shape 
		innerRadius: 75;
		segmentSpacing: 1;
		arcRadiusAuto;
		color: [ :i | | f r g b |
			f := (i / n) * Float pi * 2.
			r := (f + 0) sin * 127 + 128.
			g := (f + 2) sin * 127 + 128.
			b := (f + 4) sin * 127 + 128.
			Color r: r g: g b: b range: 256 ];
		externalRadius: [ :i | | t |
			t := frame / 50.0.
			300 + ( (t +  ((i /n) * Float pi * 4)) sin * d )].
	pie build.
	pie view animation repeat onStepDo: [ :t | 
		frame := frame + 1.
		pie elements do:[ :e | 
			pie shape updateElement: e withCommand: #externalRadius:.
			] ].
	pie view when: TSExtentChangedEvent do: [ :evt | pie view zoomToFit ].
	w := pie view open.
	w setLabel: 'Roassal :V'.
]

{ #category : #examples }
RSPieExamples >> example13BasicColorNormalize [
	<script: 'self new example13BasicColorNormalize'>
	| classes pie  |
	classes :=TSEvent withAllSubclasses.
	pie := RSPieBuilder new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	
	pie shape 
		segmentSpacing: 1;
		innerRadius: 30;
		externalRadius: 120.
	pie build.
	RSNormalizer color
		from: Color cyan;
		to: Color red;
		elements: pie elements;
		normalize: #numberOfMethods.
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example14Pyramid [
	<script: 'self new example14Pyramid'>
	| b data w |
	data := {
	{ 0.7. 'Sky'. Color lightBlue }.
	{0.2. 'Sunny side of pyramid'. Color yellow darker }.
	{ 0.05. 'Shady side of pyramid'. Color yellow muchDarker} }.
	b := RSPieBuilder new.
	b
		objects: data;
		slice: #first.
	b shape
		externalRadius: 200;
		color: #third;
		interactionDo: [:i| i popupText: #second ];
		onElement; 
		alphaAngle: [ :e | e alphaAngle - 40 ];
		betaAngle: [ :e | e betaAngle - 40 ].
	
	b build.
	w := b open.
	w setLabel: 'Pyramid'.
]

{ #category : #examples }
RSPieExamples >> example15Clockwise [
	<script: 'self new example15Clockwise'>
	| b r  |
	
	b := RSPieBuilder new.
	r := SharedRandom globalGenerator.
	b objects: ((1 to: 10) collect: [:e | r next]) sort.
	b shape
		onElement;
		color: TSScale sky8;
		externalRadius: 200;
		interactionDo: #popup;
		onElement; 
		alphaAngle: [ :e | (b betaAngleFor: e) negated+90 ];
		betaAngle: [ :e | (b alphaAngleFor: e) negated+90 ].
	
	b build.
	b open.
]

{ #category : #examples }
RSPieExamples >> example16MyDay [
	<script: 'self new example16MyDay'>
	| pie data color title view |
	
	data := { 
		{ 'sleep'. 'I dream with my gf 8hrs'. 8 }.
		{ 'eat'. 'Sometimes I cook for 4hrs'. 3 }.
		{ 'work with smalltalk'. 'with Roassal & Carlone 8hrs'. 8 }.
		{ 'draw and play dota'. 'I draw with manga style and play dota in leyend level 4hrs'. 5} }.
	color := TSScale ordinal
		domain: data;
		rangeFrom: { 'ae579c'. 'f28d1b'. 'e21454'. '4cbcec' }.
	view := RSView new.
	pie := RSPieBuilder new
		view: view;
		objects: data;
		slice: #third.
	pie view color: (Color colorFrom: '1a1b3a').
	pie shape
		externalRadius: 200;
		interactionDo: [:i | i popupText: [ :obj | obj first capitalized ] ];
		innerRadius: 140;
		color: color;
		segmentSpacing: 1.
	pie label
		fontSize: 16;
		fontName: 'Source Code Pro';
		color: color;
		text: [ :obj | (obj third * 100 / pie totalSum) rounded asString, '%' ];
		rotated;
		offset: 50.
	pie build.
	title := RSShapeBuilder label
		color: Color white;
		fontSize: 30;
		text: #asUppercase;
		fontName: 'Source Code Pro'.
	view 
		add: (title elementOn: 'Milton');
		add: (title elementOn: 'Day').
	view elements last translateTo: 0@30.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example17PieLabels [
	<script: 'self new example17PieLabels'>
	| data pie |
	"source https://www.indexmundi.com/bolivia/age_structure.html"
	data := { 
		'<=14'->3547498.
		'15-24'->2168047. 
		'25-54'->4174931. 
		'55-64'->657007. 
		'>=65'->590751}.
	pie := RSPieBuilder new 
		objects: data;
		slice: #value.
	pie shape 
		externalRadius: 240;
		innerRadius: 170;
		color: TSScale category20;
		segmentSpacing: 0.4.
	pie label
		fontSize: 13;
		text: [ :obj | obj key, ', ', (obj value * 100 / pie totalSum) rounded asString, ' %' ].
	pie build.
	pie view when: TSExtentChangedEvent do: [ pie view zoomToFit ].
	pie open.
]

{ #category : #examples }
RSPieExamples >> example18ManyPies [
	<script: 'self new example18ManyPies'>
	| data pie title color view |
	data := self esportPrizepool.
	title :=RSShapeBuilder label
		fontSize: 20;
		bold.
	color := TSScale google20.
	pie := RSPieBuilder new.
	view := pie view.
	pie shape 
		externalRadius: 200;
		innerRadius: 100;
		color: [ :obj | color scale: obj key ];
		segmentSpacing: 0.5.

	pie label
		text: #key;
		rotated.
	data keysAndValuesDo: [ :k :v | 
		| elements sum e |
		pie 
			objects: v;
			slice: #value;
			build.
		sum := pie totalSum.
		pie elements @ (RSPopup text: [ :obj|
			obj value asStringWithCommas , '$, ' ,
			(obj value * 100 / sum) rounded asString, '%' ] ).
		elements := pie elements, pie labelElements.
		elements do: #remove.
		elements add: (title elementOn: k).
		
		e := RSElement new.
		e trachelShape: (elements collect: #trachelShape).
		view add: e.
		
		 ].
	view showEncompassingRectangles.
	RSGridLayout on: view elements.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view @ RSControlsView.
	view open.
]

{ #category : #examples }
RSPieExamples >> example19Buttons [
	<script: 'self new example19Buttons'>
	| v elements pie move  |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	RSNormalizer color
		elements: elements;
		normalize: #numberOfMethods.

	v addAll: elements.
	RSGridLayout on: elements.

	v camera position: v elements encompassingRectangle center.
	v when: TSExtentChangedEvent do: [ v zoomToFit; signalUpdate ].
	v @ RSControlsView.
	
	pie := RSPieBuilder new.
	pie 
		view: v;
		objects: { 1@0. 1@ -1. 0@ -1. -1@ -1. -1@0. -1@1. 0@1. 1@1 };
		slice: [:ob | 1 ].
	pie shape
		innerRadius:10;
		onElement; 
		border: (TSBorder new color: Color lightGray);
		paint: (RadialGradientPaint new 
			center: 0 asPoint;
			focalPoint: 0 asPoint;
			colorRamp: { 
				0 -> (Color colorFrom: 'E5EFF0').
				0.6->(Color colorFrom: 'D9D9D9').
				1 -> (Color colorFrom: 'A0ABAD') };
			radius: 50);
		alphaAngle: [ :e | e alphaAngle - (45/2) ];
		position: 50 asPoint;
		betaAngle: [ :e | e betaAngle - (45/2) ];
		externalRadius: 40.
	pie build.
	move := 0@0.
	pie view animation repeat;
		onStepDo: [ :t | 
			v camera translateBy: move. ].
	"todo
	pie elements
		setAsFixed;
		when: ... do: ..."
	pie elements do: [:e | 
		e 
			setAsFixed
			when: TSMouseEnter do: [ 
				move := e model.
				v animation 
					duration: 1 second;
					easing: TSEasing backOut;
					from: 40; to: 50;
					on: e trachelShape set: #externalRadius:. ];
			when: TSMouseLeave do: [ 
				move := 0@0.
				v animation 
					duration: 1 second;
					easing: TSEasing backOut;
					from: 50; to: 40;
					on: e trachelShape set: #externalRadius:. ] ] .
	v open
	



]

{ #category : #examples }
RSPieExamples >> example20AddingRemoving [
	<script: 'self new example20AddingRemoving'>
	| pie objects view color elements updatePie label labels removed updateLabel |
	objects := String withAllSubclasses.
	removed := OrderedCollection new.
	pie := RSPieBuilder new.
	view := pie view.
	pie objects: objects;
		slice: #linesOfCode.
	color := TSScale category10.
	labels := TSGroup new.
	elements := nil.
	updatePie := nil.
	updateLabel := nil.
	view add: (RSShapeBuilder box
		extent: 100@200;
		paint: nil;
		border: (TSBorder new);
		position: 300@100 ) element.
		
	label := RSShapeBuilder label
		onElement; 
		position: [ :e | e index * (0@30) + (300@0) ];
		when: TSMouseClick do: [:e | [ 
			objects add: e model.
			removed remove: e model.
			updateLabel value.
			updatePie value.
			 ] ].
		
	pie shape 
		innerRadius: 70;
		externalRadius: 220;
		interactionDo: #popup;
		color: color;
		onElement;
		when: TSMouseClick do: [ :e | [ 
			objects remove: e model.
			removed add: e model.
			updateLabel value.
			updatePie value.
			] ].
	updatePie := [ 
		elements := pie elements.
		elements do: #remove.
		pie slice: #linesOfCode; build.
		pie elements do: [:e2 | | x y |
			x := e2 alphaAngle.
			y := e2 betaAngle.
			elements 
				detect: [ :e1 | e1 model = e2 model ]
				ifFound: [ :e1|
					view animation 
						easing: TSEasing quad;
						onStepDo: [:t |
							e2 
								alphaAngle: (e1 alphaAngle interpolateTo: x at: t);
								betaAngle: (e1 betaAngle interpolateTo: y at: t);
						 		signalUpdate.
						] 
				].
		].
		pie elements size > elements size ifTrue: [ 
			| e x |
			e := pie elements last.
			x := e alphaAngle.
			view animation
				easing: TSEasing quad;
				onStepDo: [ :t |
					e 
						alphaAngle: (e betaAngle interpolateTo: x at: t);
						signalUpdate. ]
		].
	].
	updateLabel := [ 
		labels do: #remove.
		view addAll: (labels := label elementsOn: removed) ].
		
	pie build.
	view zoomToFit.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view open.
]

{ #category : #examples }
RSPieExamples >> example21ProgressLable [
	<script: 'self new example21ProgressLable'>
	| data org pie label l scale |
	org := RPackage organizer.
	data := (org packageNames 
		select: [ :s | 'Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode < b linesOfCode ].
	pie := RSPieBuilder new
		objects: data;
		slice: #linesOfCode.
	scale := TSScale eva10.
	pie shape 
		innerRadius: 50;
		segmentSpacing: 0.5;
		externalRadius: 100;
		interactionDo: [:i | i popupText: #name ];
		color: scale.
	pie build.
	label := RSShapeBuilder label
		fontSize: 20;
		color: scale;
		text: '';
		if: #notNil actions: [ :s |
			s text: [ :obj | (obj linesOfCode*100/pie totalSum) rounded asString,'%' ]
			].
	l := label element.
	pie view add: l.
	pie elements do: [ :e | | color |
		color := e color.
		e 
			when: TSMouseEnter do: [ :evt | 
				e color: (color adjustBrightness: 0.08).
				l model: e model.
				label updateElement: l.
				 ];
			when: TSMouseLeave do: [ :evt | e color: color.
				l model: nil.
				label updateElement: l. ]
	].
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example22RotatedAnimation [
	<script: 'self new example22RotatedAnimation'>
	| data org pie labels animation view |
	org := RPackage organizer.
	data := (org packageNames 
		select: [ :s | 'Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode < b linesOfCode ].
	pie := RSPieBuilder new
		objects: data;
		slice: #linesOfCode.
	view := pie view.
	animation := nil.
	pie shape
		color: TSScale category20b;
		innerRadius: 70;
		segmentSpacing: 0.5;
		externalRadius: 220;
		when: TSMouseClick do: [ [ animation toggle ] ].
	pie build.
	labels := RSShapeBuilder label
		text: #name;
		elementsOn: data.
	view addAll: labels.
	animation := view animation
		from: 0; to: 360; repeat; duration: 15 seconds;
		onStepDo: [ :t | 
			pie elements do: [ :e | | att a b l ext ang |
				att := e attributes.
				a := att at: #a ifAbsentPut: [ e alphaAngle ].
				b := att at: #b ifAbsentPut: [ e betaAngle ].
				e alphaAngle: a + t.
				e betaAngle: b + t.
				l := labels at: e index.
				ang := ((e alphaAngle + e betaAngle)/2) %360.
				ext := l extent x/2 @ 0.
				(ang between: 90 and: 270) ifFalse: [ ext := ext negated ].
				l position: (e centroid: 80) - ext .
			]
		].
	view camera zoomToFit: 270 asPoint.
	pie open.
	



]
