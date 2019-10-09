"
I have examples for RSPieBuilder load the package Roassal3-Pie
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
		then: [ :s |
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
	pie view newAnimation 
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
	r := Random new.
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
				on: e shape set: #innerRadius: ) }. ].
	
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
				on: e shape set: #innerRadius: ) }. ].
	
	pie view zoomToFit.
	pie open.
]

{ #category : #examples }
RSPieExamples >> example07Dendi [
	<script: 'self new example07Dendi'>
	| pie colors r |
	r := Random new.
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
	pie view newAnimation repeat; from: 0; to: 500;
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
	pie view newAnimation repeat
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
	pie view newAnimation repeat onStepDo: [ :t | 
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
		allowRepeatCommands;
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
	r := Random new.
	b objects: ((1 to: 10) collect: [:e | r next]) sort.
	b shape
		allowRepeatCommands;
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
		interactionDo: [:i | i popupText: [ :obj | 
				obj first capitalized, '. ', obj third asString, ' hrs' ] ];
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
		add: (title elementOn: 'Milton''s');
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
	pie open setLabel: 'Bolivia population by age'.
]

{ #category : #examples }
RSPieExamples >> example18ManyPies [
	<script: 'self new example18ManyPies'>
	| data pie title color view elements |
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
	elements := RSShapeBuilder composite
		shapes: [ :m | | sum shapes |
			shapes := TSGroup new.
			pie
				container: shapes;
				objects: (data at: m);
				slice: #value;
				build.
			sum := pie totalSum.
			pie elements @ (TSPopup text: [ :obj|
				obj value asStringWithCommas , '$, ' ,
				(obj value * 100 / sum) rounded asString, '%' ] ).
			shapes add: (title elementOn: m).
			shapes ];
		elementsOn: data keys.
	elements do: [ :e | e scaleBy: 0.5@1.
		e matrix shy: 0.25 ].
	view addAll: elements.
	elements @TSDraggable.
	view showEncompassingRectangles.
	RSGridLayout on: view elements.
	view when: TSExtentChangedEvent do: [ view zoomToFit ].
	view @ TSControlsCanvas.
	view open setLabel: 'Prizepool in esports :V'
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
	v @ TSControlsCanvas.
	
	pie := RSPieBuilder new.
	pie 
		view: v;
		objects: { 1@0. 1@ -1. 0@ -1. -1@ -1. -1@0. -1@1. 0@1. 1@1 };
		slice: [:ob | 1 ].
	pie shape
		allowRepeatCommands;
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
			radius: 40);
		alphaAngle: [ :e | e alphaAngle - (45/2) ];
		position: 50 asPoint;
		betaAngle: [ :e | e betaAngle - (45/2) ];
		externalRadius: 40.
	pie build.
	move := 0@0.
	pie view newAnimation repeat;
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
				v newAnimation 
					duration: 1 second;
					easing: TSEasing backOut;
					from: 40; to: 50;
					on: e shape set: #externalRadius:. ];
			when: TSMouseLeave do: [ 
				move := 0@0.
				v newAnimation 
					duration: 1 second;
					easing: TSEasing backOut;
					from: 50; to: 40;
					on: e shape set: #externalRadius:. ] ] .
	v open setLabel: 'Arc buttons'
	



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
		fontName: 'Source Sans Pro';
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
					view newAnimation 
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
			view newAnimation
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
	view open setLabel: 'Click in arcs or labels'
]

{ #category : #examples }
RSPieExamples >> example21ProgressLabel [
	<script: 'self new example21ProgressLabel'>
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
		if: #notNil then: [ :s |
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
	pie open setLabel: 'Roassal3 packages by linesOfCode'
]

{ #category : #examples }
RSPieExamples >> example22RotatedAnimation [
	<script: 'self new example22RotatedAnimation'>
	| data org pie animation view |
	org := RPackage organizer.
	data := (org packageNames 
		select: [ :s | '*Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode < b linesOfCode ].
	pie := RSPieBuilder new
		objects: data;
		slice: #linesOfCode.
	view := pie view.
	animation := nil.
	pie shape
		color: TSScale category20b;
		interactionDo: [ :i | i popupText: [ :obj| 
			obj linesOfCode asString, ' LOC' ] ];
		innerRadius: 70;
		segmentSpacing: 0.5;
		externalRadius: 220;
		when: TSMouseClick do: [ [ animation toggle ] ].
	pie label text: #name.
	pie build.
	animation := view newAnimation
		from: 0; to: 360; repeat; duration: 15 seconds;
		onStepDo: [ :t | 
			pie elements do: [ :e | | att a b l ext ang |
				att := e attributes.
				a := att at: #a ifAbsentPut: [ e alphaAngle ].
				b := att at: #b ifAbsentPut: [ e betaAngle ].
				e alphaAngle: a + t.
				e betaAngle: b + t.
				l := pie labelElements at: e index.
				ang := ((e alphaAngle + e betaAngle)/2) %360.
				ext := l extent x/2 @ 0.
				(ang between: 90 and: 270) ifFalse: [ ext := ext negated ].
				l position: (e centroid: 80) - ext .
			]
		].
	view add:(RSShapeBuilder label elementOn: pie totalSum asString, ' LOC').
	view camera zoomToFit: 270 asPoint.
	view @ TSControlsCanvas.
	pie open setLabel: 'Roassal3 packages by #linesOfCode'



]

{ #category : #examples }
RSPieExamples >> example23RotatedAnimation [
	<script: 'self new example23RotatedAnimation'>
	| data pie animation view lines directorySize |
	"data := (IceRepository registry detect: [ :each | each includesPackageNamed: 'Roassal3' ] ifNone: [ self error: 'Please add a clone of this project to Iceberg to access to the resources' ]) location directories."
	data := './pharo-local/iceberg/ObjectProfile/Roassal3/src' asFileReference
		directories.
	directorySize := nil.
	directorySize := [ :d | | sum |
		sum := 0.
		d children do: [ :child |
			sum := sum + (child isDirectory 
				ifTrue: [ directorySize value: child ]
				ifFalse: [ child size ]) ].
		sum ].
	pie := RSPieBuilder new
		objects: data;
		slice:  directorySize.
	view := pie view.
	animation := nil.
	pie shape
		color: TSScale category20b;
		innerRadius: 70;
		interactionDo: [ :i | i popupText: [ :obj| 
			obj humanReadableSize ] ];
		segmentSpacing: 0.5;
		externalRadius: 220;
		when: TSMouseClick do: [ [ animation toggle ] ].
	pie label text: #basename.
	pie build.
	lines := RSEdgeBuilder polyline
		border: (TSBorder new dashArray: #(3));
		edgesOn: pie labelElements.
	view addAll: lines.
	view add: (RSShapeBuilder label 
		elementOn: pie totalSum humanReadableSIByteSize).
	animation := view newAnimation
		from: 0; to: 360; repeat; duration: 15 seconds;
		onStepDo: [ :t | 
			pie elements do: [ :e | | att a b l ext ang x p1 p2 p3 line |
				att := e attributes.
				a := att at: #a ifAbsentPut: [ e alphaAngle ].
				b := att at: #b ifAbsentPut: [ e betaAngle ].
				e alphaAngle: a + t.
				e betaAngle: b + t.
				l := pie labelElements at: e index.
				ang := ((e alphaAngle + e betaAngle)/2) %360.
				ext := l extent x/2 @ 0.
				x := -250.
				(ang between: 90 and: 270) ifFalse: [ 
					ext := ext negated.
					x := x negated ].
				p1 := e centroid: 0.
				p2 := e centroid: 80.
				p3 := x @ p2 y.
				line := lines at: e index.
				line shape 
					controlPoints: { p1. p2. p3 }.
				l position: p3-ext.
			]
		].
	view camera zoomToFit: 270 asPoint.
	view when: TSExtentChangedEvent do: [ 
		view camera 
			zoomToFit: view extent * 0.9
			extent: 800@600 ].
	pie open setLabel: 'Roassal3 packages by size in the file system'
]

{ #category : #examples }
RSPieExamples >> example24ManyPies [
	<script: 'self new example24ManyPies'>
	| data labels maxSum radius color view composite pie title sumLabel format |
	"data processing"
	data := self usaPopulation.
	labels := data first.
	maxSum := 0.
	data := (data allButFirst collect: [ :line | | arr sum |
		arr :=  Array new: line size.
		sum := 0.
		2 to: line size do: [ :n | | v |
			v := (line at: n) asNumber.
			sum := sum + v.
			arr at: n put: v ].
		arr at: 1 put: line first -> sum.
		maxSum := maxSum max: sum.
		arr ]) sorted: [:a :b | a first value > b first value ].
	
	"the visualization"
	radius := TSScale sqrt domain: { 0. maxSum }; range: #(0 220).
	color := TSScale eva10.
	view := RSView new.
	pie := RSPieBuilder new.
	pie shape
		onElement;
		color: [ :e | color scale: e index ];
		segmentSpacing: 0.5.
	title := RSShapeBuilder label
		fontSize: 12;
		bold;
		position: 0@ -6;
		text: [:obj | obj first key ].

	format := [ :n | 
		n < 1000000 
			ifTrue: [ (n / 1000) asInteger asString,'K' ]
			ifFalse: [ (n / 1000000) asInteger asString,'M'  ] ].
	sumLabel := RSShapeBuilder label
		fontSize: 11;
		position: 0@5;
		text: [ :obj | format value: obj first value ].
	composite := RSShapeBuilder composite shapes: [ :m | | g |
		g := TSGroup new.
		pie shape 
			externalRadius: [ radius scale: m first value ];
			innerRadius: [ :e| e externalRadius * 0.6 ].
		pie 
			view: g;
			objects: m allButFirst;
			slice: #yourself;
			build.
		pie elements do: [ :e  | e @ (TSPopup text: [:obj | 
			(labels at: e index+1),': ',obj asString ] ) ].
		g add: (title elementOn: m).
		g add: (sumLabel elementOn: m).
		g
		].
	view addAll: (composite elementsOn: data).
	RSFlowLayout on: view elements.
	view @ TSControlsCanvas.
	view zoomToFit.
	view open setLabel: 'Usa population by State'.
]

{ #category : #data }
RSPieExamples >> usaPopulation [
	| str |
	str := 'State,Under 5 Years,5 to 13 Years,14 to 17 Years,18 to 24 Years,25 to 44 Years,45 to 64 Years,65 Years and Over
AL,310504,552339,259034,450818,1231572,1215966,641667
AK,52083,85640,42153,74257,198724,183159,50277
AZ,515910,828669,362642,601943,1804762,1523681,862573
AR,202070,343207,157204,264160,754420,727124,407205
CA,2704659,4499890,2159981,3853788,10604510,8819342,4114496
CO,358280,587154,261701,466194,1464939,1290094,511094
CT,211637,403658,196918,325110,916955,968967,478007
DE,59319,99496,47414,84464,230183,230528,121688
DC,36352,50439,25225,75569,193557,140043,70648
FL,1140516,1938695,925060,1607297,4782119,4746856,3187797
GA,740521,1250460,557860,919876,2846985,2389018,981024
HI,87207,134025,64011,124834,356237,331817,190067
ID,121746,201192,89702,147606,406247,375173,182150
IL,894368,1558919,725973,1311479,3596343,3239173,1575308
IN,443089,780199,361393,605863,1724528,1647881,813839
IA,201321,345409,165883,306398,750505,788485,444554
KS,202529,342134,155822,293114,728166,713663,366706
KY,284601,493536,229927,381394,1179637,1134283,565867
LA,310716,542341,254916,471275,1162463,1128771,540314
ME,71459,133656,69752,112682,331809,397911,199187
MD,371787,651923,316873,543470,1556225,1513754,679565
MA,383568,701752,341713,665879,1782449,1751508,871098
MI,625526,1179503,585169,974480,2628322,2706100,1304322
MN,358471,606802,289371,507289,1416063,1391878,650519
MS,220813,371502,174405,305964,764203,730133,371598
MO,399450,690476,331543,560463,1569626,1554812,805235
MT,61114,106088,53156,95232,236297,278241,137312
NE,132092,215265,99638,186657,457177,451756,240847
NV,199175,325650,142976,212379,769913,653357,296717
NH,75297,144235,73826,119114,345109,388250,169978
NJ,557421,1011656,478505,769321,2379649,2335168,1150941
NM,148323,241326,112801,203097,517154,501604,260051
NY,1208495,2141490,1058031,1999120,5355235,5120254,2607672
NC,652823,1097890,492964,883397,2575603,2380685,1139052
ND,41896,67358,33794,82629,154913,166615,94276
OH,743750,1340492,646135,1081734,3019147,3083815,1570837
OK,266547,438926,200562,369916,957085,918688,490637
OR,243483,424167,199925,338162,1044056,1036269,503998
PA,737462,1345341,679201,1203944,3157759,3414001,1910571
RI,60934,111408,56198,114502,277779,282321,147646
SC,303024,517803,245400,438147,1193112,1186019,596295
SD,58566,94438,45305,82869,196738,210178,116100
TN,416334,725948,336312,550612,1719433,1646623,819626
TX,2027307,3277946,1420518,2454721,7017731,5656528,2472223
UT,268916,413034,167685,329585,772024,538978,246202
VT,32635,62538,33757,61679,155419,188593,86649
VA,522672,887525,413004,768475,2203286,2033550,940577
WA,433119,750274,357782,610378,1850983,1762811,783877
WV,105435,189649,91074,157989,470749,514505,285067
WI,362277,640286,311849,553914,1487457,1522038,750146
WY,38253,60890,29314,53980,137338,147279,65614'.
	^ str lines collect: [ :line |  line trimBoth splitOn: ',' ].
]
