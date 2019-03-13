"
I have examples for RSPieBuilder
"
Class {
	#name : #RSPieExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Pie-Examples'
}

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
	pie view camera zoomToFit: 200@200.
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
	pie view camera zoomToFit: 200@200.
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
	pie view camera zoomToFit: 200@200.
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
	pie view camera zoomToFit: 200@200.
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
	
	pie view camera zoomToFit: 200@200.
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
	
	pie view camera zoomToFit: 200@200.
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
	pie view camera zoomToFit: 200@200.
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
