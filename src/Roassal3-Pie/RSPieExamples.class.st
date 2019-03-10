"
I have examples for RSPieBuilder
"
Class {
	#name : #RSPieExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Pie-Examples'
}

{ #category : #examples }
RSPieExamples >> example01 [ 
	<script: 'self new example01'>
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
RSPieExamples >> example02 [
	<script: 'self new example02'>
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
RSPieExamples >> example03 [
	<script: 'self new example03'>
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
RSPieExamples >> example04 [
	<script: 'self new example04'>
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
RSPieExamples >> example05 [
	<script: 'self new example05'>
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
RSPieExamples >> example06 [
	<script: 'self new example06'>
	| pie |
	pie := RSPieBuilder new
		objects: (1 to: 360);
		yourself.
	pie shape 
		removeCommandsBySelector: #alphaAngle:;
		removeCommandsBySelector: #betaAngle:.
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
RSPieExamples >> example07 [
	<script: 'self new example07'>
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
RSPieExamples >> example08 [
	<script: 'self new example08'>
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
RSPieExamples >> example09 [
	<script: 'self new example09'>
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
RSPieExamples >> example10 [
	<script: 'self new example10'>
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
RSPieExamples >> example11 [
	<script: 'self new example11'>
	| pie colors |
	pie := RSPieBuilder new.
	pie objects: #(1 1 2 3 4 8 14 21) reverse.
	colors := TSScale category20.
	pie shape 
		onElement;
		color: colors;
		segmentSpacing: 1;
		border: (TSBorder new width: 1.5; color: Color gray);
		externalRadius: 220;
		innerRadius: 70.
	pie build.
	"pie view animationFrom: (pie elements collect: [:e | | b |
		b := e betaAngle.
		e betaAngle: e alphaAngle.
		pie view tAnimation duration: 200 milliSeconds;
			from: e alphaAngle; 
			to: b;
			on: e trachelShape set: #betaAngle:
		])."
	pie elements do: [ :e|
		e attributes 
			at: #beta 
			put: e betaAngle.
		e betaAngle: e alphaAngle. ].
	pie view animation from: 0; to: 360; 
		easing: TSEasing bounceOut;
		onStepDo: [ :t | 
		pie elements do: [ :e | | beta |
			beta := e attributes at: #beta.
			(t between: e alphaAngle and: beta)
				ifTrue: [ e betaAngle: t ].
			t >= beta ifTrue: [ e betaAngle: beta ].
			t < e alphaAngle ifTrue: [ e betaAngle: e alphaAngle ]
			 ] ].
	
	pie open.


]

{ #category : #examples }
RSPieExamples >> example12 [
	<script: 'self new example12'>
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
	pie view when: TSResizeCanvasEvent do: [ :evt | pie view zoomToFit ].
	w := pie view open.
	w setLabel: 'Roassal :V'.
]

{ #category : #examples }
RSPieExamples >> example13 [
	<script: 'self new example13'>
	| classes pie  |
	classes :=TSEvent withAllSubclasses.
	pie := RSPieBuilder new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	
	pie shape 
		segmentSpacing: 5;
		innerRadius: 30;
		externalRadius: 120.
	pie build.
	RSNormalizer color
		from: Color green;
		to: Color red;
		elements: pie elements;
		normalize: #numberOfMethods.
	pie view camera zoomToFit: 200@200.
	pie open.
]
