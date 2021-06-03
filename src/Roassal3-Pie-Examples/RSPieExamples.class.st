"
I have examples for RSPieBuilder load the package Roassal3-Pie
"
Class {
	#name : #RSPieExamples,
	#superclass : #RSAbstractExamples,
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
	<script: 'self new example01Basic open'>
	| classes pie |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPie new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	pie build.
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example02Emphasize [
	<script: 'self new example02Emphasize open'>
	| classes pie |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPie new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	pie build.
	pie shapes 
		select: [ :s | s model numberOfMethods > 100 ]
		thenDo: [ :s | s emphasizeWith: 20 ].
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example03BasicColors [
	<script: 'self new example03BasicColors open'>
	| classes pie |
	classes :={Dictionary. OrderedCollection. String. Set. Array}.
	pie := RSPie new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
		
	pie sliceShape
		segmentSpacing: 5;
		externalRadius: 120.
	pie 
		sliceColor: NSScale category10;
		build.
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example04SegmentSpacingAnimation [
	<script: 'self new example04SegmentSpacingAnimation open'>
	| pie |
	pie := RSPie new
		objects: #(3 3 2 2 5 8 14);
		yourself.
	pie sliceShape
		segmentSpacing: 5;
		innerRadius: 50;
		externalRadius: 200;
		withBorder.
	pie
		sliceColor: NSScale google20;
		build.
	pie canvas newAnimation 
		repeat;
		easing: RSEasing sinIn;
		duration: 5 seconds;
		from: 0; 
		to: 180;
		onStepDo: [ :t | 
			pie canvas nodes do: [ :s | | op |
				op := 125 - (t degreesToRadians sin abs * 125).
				s segmentSpacing: op. ] ].
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example05Smash [
	<script: 'self new example05Smash open'>
	| pie r |
	r := Random new.
	pie := RSPie new
		objects: ((1 to: 10) collect: [:e | r next]) sort;
		yourself.
	pie sliceShape
		border: (RSBorder new width: 1.5);
		innerRadius: 0;
		externalRadius: 200.
	pie
		sliceColor: NSScale category10;
		build.
	pie shapes doWithIndex: [ :shape :index | | a b |
		a := shape alphaAngle.
		b := shape betaAngle.
		pie canvas animationFrom: { 
			(pie canvas transitionAnimation 
				duration: 2 seconds;
				easing: RSEasing bounceOut;
				onStepDo: [ :t |
					shape 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie canvas transitionAnimation 
				delay: (50 * index) milliSeconds;
				duration: 750 milliSecond;
				easing: RSEasing elasticOut;
				from: 0;
				to: 120;
				on: shape shape set: #innerRadius: ) }. ].
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example06SmashHSL [
	<script: 'self new example06SmashHSL open'>
	| pie |
	pie := RSPie new
		objects: (1 to: 360);
		yourself.
	pie sliceShape
		innerRadius: 0;
		externalRadius: 200.
	pie
		sliceColor: [ :shape |  Color h: shape index s: 1 l: 0.5 ];
		build.
	pie shapes doWithIndex: [ :shape :index | | a b |
		shape
			alphaAngle: (a := shape model - 1);
			betaAngle: (b := shape model + 1).
		pie canvas animationFrom: { 
			(pie canvas transitionAnimation 
				duration: 2 seconds;
				easing: RSEasing bounceOut;
				onStepDo: [ :t |
					shape 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie canvas transitionAnimation 
				delay: (10 * index) milliSeconds;
				duration: 2 seconds;
				easing: (RSEasing elasticOut period: 0.30; amplitude: 0.8) ;
				from: 0;
				to: 120;
				on: shape shape set: #innerRadius: ) }. ].
	
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example07Dendi [
	<script: 'self new example07Dendi open'>
	| pie r |
	r := Random new.
	pie := RSPie new
		objects: ((1 to: 10) collect: [:e | r next]) sort;
		yourself.
	pie sliceShape
		border: (RSBorder new width: 1.5);
		externalRadius: 200.
	pie
		sliceColor: NSScale category20b;
		build.
	pie shapes do: [ :shape | | a b |
		a := shape alphaAngle.
		b := shape betaAngle.
		pie canvas animationFrom: { 
			(pie canvas transitionAnimation 
				easing: RSEasing bounce;
				onStepDo: [ :t |
					shape 
						alphaAngle: a * t;
						betaAngle: b * t ]).
			(pie canvas transitionAnimation 
				delay: 3 seconds;
				easing: RSEasing  bounce;
				onStepDo: [:t | 
					shape
						alphaAngle: a + ((360 - a) * t);
						betaAngle: b + ((360 - b) * t) ] ) }. ].
	
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example08CornerRadii [
	<script: 'self new example08CornerRadii open'>
	| pie |
	pie := RSPie new
		objects: #(1 1 2 3 4 8 14 21);
		yourself.
	pie sliceShape
		border: (RSBorder new width: 1.5);
		externalRadius: 220;
		innerRadius: 220/3;
		cornerRadii: 30.
	pie
		sliceColor: NSScale category20c;
		build.
	
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example09TickAnimation [
	<script: 'self new example09TickAnimation open'>
	| pie |
	pie := RSPie new.
	pie objects: (0 to: 360).
	pie sliceShape
		externalRadius: 200;
		innerRadius: 150.
	pie build.
	pie shapes do: [ :s | s 
		alphaAngle: s model;
		betaAngle: s model + 2 ].
	pie canvas newAnimation 
		repeat; 
		from: 0; 
		to: 500;
		easing: RSEasing elasticOut;
		onStepDo: [ :t |
			pie shapes do: [ :s |
				s color: (Color h: s model  + t s: 1 l: 0.5) ] ].
	
	^ pie canvas.
]

{ #category : #examples }
RSPieExamples >> example10CornerRadiiAnimation [
	<script: 'self new example10CornerRadiiAnimation open'>
	| pie |
	pie := RSPie new.
	pie objects: #(1 1 2 3 4 8 14 21).
	
	pie sliceShape
		segmentSpacing: 1;
		border: (RSBorder new width: 1.5; color: Color gray);
		externalRadius: 220;
		innerRadius: 70.
	pie 
		sliceColor: nil;
		build.
	pie
		sliceColor: NSScale paired12;
		build.
	pie canvas newAnimation repeat
		onStepDo: [ :k |
			pie shapes do: [ :shape | 
				| t |
				t := 1 - ((k - 0.5) abs * 2).
				shape cornerRadii: (220-70)/2 * t ]
			 ].
	
	^ pie canvas


]

{ #category : #examples }
RSPieExamples >> example11OpenningAnimation [
	<script: 'self new example11OpenningAnimation open'>
	| pie bounce inout outin reset colors |
	pie := RSPie new.
	pie objects: #(1 1 2 3 4 8 14 21) reverse.
	pie sliceShape

		segmentSpacing: 1;
		border: (RSBorder new width: 1.5; color: Color gray);
		externalRadius: 220;
		innerRadius: 70.
	colors := NSScale category20.
	pie
		sliceColor: [:slice | colors scale: slice model ];
		build.
	reset := [ pie shapes do: #remove. pie build. pie canvas signalUpdate ].
	
	bounce := pie canvas transitionAnimation from: 0; to: 360; 
		easing: RSEasing bounceOut;
		onStepDo: [ :t | 
		pie shapes do: [ :shape | | beta |
			beta := shape propertyAt: #beta.
			(t between: shape alphaAngle and: beta)
				ifTrue: [ shape betaAngle: t ].
			t >= beta ifTrue: [ shape betaAngle: beta ].
			t < shape alphaAngle ifTrue: [ shape betaAngle: shape alphaAngle ]
			 ] ].
	bounce when: RSAnimationStartEvent do: [ 
		pie shapes do: [ :shape |
			shape propertyAt: #beta put: shape betaAngle.
			shape betaAngle: shape alphaAngle.
			 ] ].
	bounce when: RSAnimationEndEvent do: reset.
	
	inout := pie canvas transitionAnimation 
		delay: 1 second;
		easing: RSEasing backOut;
		onStepDo: [ :t |
			pie shapes do: [ :shape |
				shape innerRadius: 70 * t.
				shape externalRadius: 220 * t ]
			 ].
	inout when: RSAnimationEndEvent do: reset.
	
	outin := pie canvas transitionAnimation
		delay: 1 second;
		easing: RSEasing elasticOut;
		onStepDo: [ :t |
			pie shapes do: [ :shape | | p a b att |
				att := shape properties.
				p := att at: #position ifAbsentPut: [ 
					| angle |
					angle := (shape alphaAngle + shape betaAngle)/2 + 180.
					angle := angle degreesToRadians.
					NSScale linear range: {300*(angle cos@angle sin negated). 0@0 } ].
				a := att at: #alpha ifAbsentPut: [ 
					NSScale linear range: { shape alphaAngle + 180. shape alphaAngle } ].
				b := att at: #beta ifAbsentPut: [ 
					NSScale linear from: shape betaAngle + 180; to: shape betaAngle; yourself ].
				shape position: (p scale: t).
				shape alphaAngle: (a scale: t).
				shape betaAngle: (b scale: t).
				 ] ].
	"It is not necessary rebuild all the arc, you can reuse them
	but I did not try this animation event, for that reason I use it"
	outin when: RSAnimationEndEvent do: reset.
	(pie canvas animationFrom: { bounce. inout. outin }) repeat.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example12RainbowPie [
	<script: 'self new example12RainbowPie open setLabel: ''Roassal3 :V'' '>
	| pie frame n d update |
	n := 48.
	d := 100.
	frame := 0.
	pie := RSPie new
		objects: (1 to: n);
		slice: [:v | 1 ].
	pie sliceShape
		innerRadius: 75;
		segmentSpacing: 1.
	pie
		sliceColor: [ :slice | | f r g b i |
			i := slice model.
			f := (i / n) * Float pi * 2.
			r := (f + 0) sin * 127 + 128.
			g := (f + 2) sin * 127 + 128.
			b := (f + 4) sin * 127 + 128.
			Color r: r g: g b: b range: 256 ];
		build.
	update := [ :tran | 
		frame := frame + 1.
		pie shapes do:[ :shape | | t |
			t := frame / 50.0.
			shape externalRadius: 300 + ( (t +  ((shape model /n) * Float pi * 4)) sin * d ).
			shape arcRadiusAuto.
			] ].
	update value: 0.
	pie canvas newAnimation repeat onStepDo: update.
	pie canvas when: RSExtentChangedEvent do: [ :evt | pie canvas zoomToFit ].
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example13BasicColorNormalize [
	<script: 'self new example13BasicColorNormalize open'>
	| classes pie  |
	classes :=RSEvent withAllSubclasses.
	pie := RSPie new
		objects: classes;
		slice: #numberOfMethods;
		yourself.
	pie sliceShape
		segmentSpacing: 1;
		innerRadius: 30;
		externalRadius: 120.
	pie build.
	RSNormalizer color
		from: Color cyan;
		to: Color red;
		shapes: pie shapes;
		normalize: #numberOfMethods.
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example14Pyramid [
	<script: 'self new example14Pyramid open setLabel: ''Pyramid'''>
	| b data |
	data := {
	{ 0.7. 'Sky'. Color lightBlue }.
	{0.2. 'Sunny side of pyramid'. Color yellow darker }.
	{ 0.05. 'Shady side of pyramid'. Color yellow muchDarker} }.
	b := RSPie new.
	b
		objects: data;
		slice: #first.
	b sliceShape externalRadius: 200.
	b sliceColor: [:slice | slice model third];
		build.
	b shapes @ (RSPopup text: #second).
	b shapes do: [ :shape | shape shiftAngles: -40 ].
	
	^ b canvas
]

{ #category : #examples }
RSPieExamples >> example15Clockwise [
	<script: 'self new example15Clockwise open'>
	| b r  |
	b := RSPie new.
	r := Random new.
	b objects: ((1 to: 10) collect: [:e | r next]) sort.
	b sliceShape externalRadius: 200.
	b
		sliceColor: NSScale sky8;
		build.
	b shapes do: [ :shape | 
		shape
			alphaAngle: (b betaAngleFor: shape) negated + 90;
			betaAngle: (b alphaAngleFor: shape) negated + 90.
		 ].
	^ b canvas
]

{ #category : #examples }
RSPieExamples >> example16MyDay [
	<script: 'self new example16MyDay open'>
	| pie data color canvas pieLabel pieTitle |
	data := { 
		{ 'sleep'. 'I dream with my gf 8hrs'. 8 }.
		{ 'eat'. 'Sometimes I cook for 4hrs'. 3 }.
		{ 'work with smalltalk'. 'with Roassal & Carlone 8hrs'. 8 }.
		{ 'draw and play dota'. 'I draw with manga style and play dota in leyend level 4hrs'. 5} }.
	color := NSScale ordinal
		rangeFrom: { 'ae579c'. 'f28d1b'. 'e21454'. '4cbcec' }.
	canvas := RSCanvas new.
	pie := RSPie new
		container: canvas;
		objects: data;
		slice: #third.
	canvas color: '1a1b3a'.
	pie sliceShape
		externalRadius: 200;
		innerRadius: 140;
		segmentSpacing: 1.
	pie sliceColor: color.
		
	pieLabel := RSPieLabeled new.
	pieLabel labelShape
		fontSize: 16;
		fontName: 'Source Code Pro'.
	pieLabel
		labelColor: color;
		labelText: [ :obj | (obj third * 100 / pie totalSum) rounded asString, '%' ];
		rotated;
		offset: 60.
	pieTitle := RSPieTitle new.
	pieTitle labelShape
		fontSize: 30;
		color: Color white.
	pieTitle labelText: 'Milton''s', String cr, 'Day'.
	pie build.
	
	pie shapes @ (RSPopup text: [ :obj |
		obj first capitalized, '. ', obj third asString, ' hrs' ] ).
	pie shapes @ pieLabel.
	pie canvas @ pieTitle.
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example17PieLabels [
	<script: 'self new example17PieLabels open setLabel: ''Bolivia population by age'''>
	| data pie pieLabel |
	"source https://www.indexmundi.com/bolivia/age_structure.html"
	data := { 
		'<=14'->3547498.
		'15-24'->2168047. 
		'25-54'->4174931. 
		'55-64'->657007. 
		'>=65'->590751}.
	pie := RSPie new 
		objects: data;
		slice: #value.
	pie sliceShape
		externalRadius: 240;
		innerRadius: 170;
		segmentSpacing: 0.4.
	pie sliceColor: NSScale category20.
		
	pieLabel := RSPieLabeled new.
	pieLabel labelShape fontSize: 13.
	pieLabel labelText: [ :obj |
		obj key, (obj value * 100 / pie totalSum) rounded asString, ' %' ].
	
	pie build.
	pie canvas when: RSExtentChangedEvent do: [ pie canvas zoomToFit ].
	pie shapes @ pieLabel.
	^ pie canvas.
]

{ #category : #examples }
RSPieExamples >> example18ManyPies [
	<script: 'self new example18ManyPies open setLabel: ''Prizepool in esports :V'''>
	| data pie color canvas shapes pieLabel pieTitle |
	data := self esportPrizepool.
	color := NSScale google20.
	pie := RSPie new.
	canvas := pie container.
	pie sliceShape
		externalRadius: 200;
		innerRadius: 100;
		segmentSpacing: 0.5.
	pie sliceColor: [ :shape | color scale: shape index ].
		
	pieLabel := RSPieLabeled new.
	pieLabel
		labelText: #key;
		rotated.
	pieTitle := RSPieTitle new.
	pieTitle labelShape
		bold;
		fontSize: 20.
	shapes := data keys collect: [ :key | 
		| composite sum |
		composite := RSComposite new.
		pie
			objects: (data at: key);
			slice: #value.
		
		pie container: composite; build.
		sum := pie totalSum.
		pie shapes @ (RSPopup text: [ :obj |
			obj value asStringWithCommas , '$, ' ,
				(obj value * 100 / sum) rounded asString, '%'  ]).
		pie shapes @ pieLabel.
		
		pieTitle labelText: key.
		composite @ pieTitle.
		composite adjustToChildren.
		composite  ] as: RSGroup.
	shapes do: [ :e | e scaleBy: 0.5@1.
		e matrix shy: 0.25 ].
	canvas addAll: shapes.
	shapes @ RSDraggableInteraction.
	canvas showEncompassingRectangles.
	RSGridLayout on: canvas nodes.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example19Buttons [
	<script: 'self new example19Buttons open setLabel: ''Arc buttons'''>
	| canvas shapes pie move |
	canvas := RSCanvas new.
	shapes := Collection withAllSubclasses collect: [ :cls | 
		RSBox new
			size: cls numberOfMethods;
			draggable;
			popup;
			model: cls;
			yourself ].
	RSNormalizer color
		shapes: shapes;
		normalize: #numberOfMethods.

	canvas addAll: shapes.
	RSGridLayout on: shapes.

	canvas camera position: canvas shapes encompassingRectangle center.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit; signalUpdate ].
	canvas @ RSCanvasController.
	
	pie := RSPie new.
	pie 
		container: canvas;
		objects: { 1@0. 1@ -1. 0@ -1. -1@ -1. -1@0. -1@1. 0@1. 1@1 };
		slice: [:ob | 1 ].
	pie sliceShape
		innerRadius:10;
		externalRadius: 40;
		border: (RSBorder new color: Color lightGray).
	pie
		sliceColor: ((RadialGradientPaint fromArray: 
				{0 -> 'E5EFF0'.
				0.6->'D9D9D9'.
				1 ->'A0ABAD'})
			center: 0 asPoint;
			focalPoint: 0 asPoint;
			radius: 40);
		build.
	move := 0@0.
	pie canvas newAnimation repeat;
		onStepDo: [ :t | 
			canvas camera translateBy: move. ].

	pie shapes do: [:shape | 
		shape 
			position: 50 asPoint;
			shiftAngles: 45/ -2;
			setAsFixed;
			when: RSMouseEnter do: [ 
				move := shape model.
				canvas newAnimation 
					duration: 1 second;
					easing: RSEasing backOut;
					from: 40; to: 50;
					on: shape shape set: #externalRadius:. ];
			when: RSMouseLeave do: [ 
				move := 0@0.
				canvas newAnimation 
					duration: 1 second;
					easing: RSEasing backOut;
					from: 50; to: 40;
					on: shape shape set: #externalRadius:. ] ] .
	^ canvas
	



]

{ #category : #examples }
RSPieExamples >> example20AddingRemoving [
	<script: 'self new example20AddingRemoving open setLabel: ''Click in arcs or labels'''>
	| pie objects canvas color shapes updatePie labels removed updateLabel update pieClick |
	objects := String withAllSubclasses.
	removed := OrderedCollection new.
	pie := RSPie new.
	canvas := pie canvas.
	pie objects: objects;
		slice: #linesOfCode.
	color := NSScale category10.
	labels := RSGroup new.
	shapes := nil.
	updatePie := nil.
	updateLabel := nil.
	update := nil.
	canvas addShape: (RSBox new
		extent: 100@200;
		noPaint;
		withBorder;
		position: 300@100;
		yourself).
	pie sliceShape
		innerRadius: 70;
		externalRadius: 220.
	pie
		sliceColor: [:slice | color scale: slice model ];
		build.
	pieClick := [ pie shapes when: RSMouseClick do: [ :evt |
		objects remove: evt shape model.
		removed add: evt shape model.
		update value.
	] ].
	pieClick value.
	updatePie := [ 
		shapes := pie shapes.
		shapes do: #remove.
		pie slice: #linesOfCode; build.
		pieClick value.
		pie shapes do: [:shape | | x y |
			x := shape alphaAngle.
			y := shape betaAngle.
			shapes 
				detect: [ :e1 | e1 model = shape model ]
				ifFound: [ :e1|
					canvas newAnimation 
						easing: RSEasing quad;
						onStepDo: [:t |
							shape 
								alphaAngle: (e1 alphaAngle interpolateTo: x at: t);
								betaAngle: (e1 betaAngle interpolateTo: y at: t);
						 		signalUpdate.
						] 
				].
		].
		pie shapes size > shapes size ifTrue: [ 
			| shape x |
			shape := pie shapes last.
			x := shape alphaAngle.
			canvas newAnimation
				easing: RSEasing quad;
				onStepDo: [ :t |
					shape 
						alphaAngle: (shape betaAngle interpolateTo: x at: t);
						signalUpdate. ]
		].
	].
	updateLabel := [ 
		labels do: #remove.
		canvas addAll: (labels := removed collectWithIndex: [ :m :index | 
			RSLabel new
				fontName: 'Source Sans Pro';
				model: m;
				text: m;
				position: index * (0@30) +  (300@0);
				when: RSMouseClick do: [ :evt | | model |
					model := evt shape model.
					objects add: model.
					removed remove: model.
					update value ];
				yourself ]).
		 ].
	update := [ updatePie value. updateLabel value ].
	canvas zoomToFit.
	canvas when: RSExtentChangedEvent do: [ canvas zoomToFit ].
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example21ProgressLabel [
	<script: 'self new example21ProgressLabel open setLabel: ''Roassal3 packages by linesOfCode'''>
	| data org pie scale |
	org := RPackage organizer.
	data := (org packageNames 
		select: [ :s | 'Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode < b linesOfCode ].
	pie := RSPie new
		objects: data;
		slice: #linesOfCode.
	scale := NSScale eva10.
	pie sliceShape 
		innerRadius: 50;
		segmentSpacing: 0.5;
		externalRadius: 100.
	pie 
		sliceColor: scale;
		build. 
	RSShowProgressLabelDecorator on: pie.
	pie shapes @ (RSPopup text: #name).
	pie canvas zoomToFit.
	^ pie canvas
]

{ #category : #examples }
RSPieExamples >> example22RotatedAnimation [
	<script: 'self new example22RotatedAnimation open setLabel: ''Roassal3 packages by #linesOfCode'''>
	| data org pie pieLabel animation canvas |
	org := RPackage organizer.
	data := (org packageNames 
		select: [ :s | '*Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode < b linesOfCode ].
	pie := RSPie new
		objects: data;
		slice: #linesOfCode.
	canvas := pie canvas.
	animation := nil.
	pie sliceColor: NSScale category20b.
	pie sliceShape
		innerRadius: 70;
		segmentSpacing: 0.5;
		externalRadius: 220;
		when: RSMouseClick do: [ [ animation toggle ] ].
	pieLabel := RSPieLabeled new.
	pieLabel labelText: #name.
	pie build.
	pie shapes @ (RSPopup text: [:obj | obj linesOfCode asString, 'LOC']).
	pie shapes @ pieLabel.
	animation := canvas newAnimation
		from: 0; to: 360; repeat; duration: 15 seconds;
		onStepDo: [ :t | 
			pie shapes do: [ :shape | | att a b l ext ang |
				att := shape properties.
				a := att at: #a ifAbsentPut: [ shape alphaAngle ].
				b := att at: #b ifAbsentPut: [ shape betaAngle ].
				shape alphaAngle: a + t.
				shape betaAngle: b + t.
				l := shape propertyAt: pieLabel labelKey.
				ang := ((shape alphaAngle + shape betaAngle)/2) %360.
				ext := l extent x/2 @ 0.
				(ang between: 90 and: 270) ifFalse: [ ext := ext negated ].
				l position: (shape centroid: 80) - ext .
			]
		].
	canvas add:(RSLabel new text: pie totalSum asString, ' LOC').
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example23RotatedAnimation [
	<script: 'self new example23RotatedAnimation open setLabel: ''Roassal3 packages by size in the file system'''>
	<noTest>
	| data pie pieLabel animation canvas lines directorySize |
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
	data := data sort: [ :a :b |
		(directorySize value: a) > (directorySize value: b) ].
	pie := RSPie new
		objects: data;
		slice: [:dir | (directorySize value: dir) sqrt ].
	canvas := pie canvas.
	animation := nil.
	pie sliceShape
		innerRadius: 70;
		segmentSpacing: 0.5;
		externalRadius: 220.
	pie
		sliceColor: NSScale category20b.
	pieLabel := RSPieLabeled new.
	pieLabel labelText: #basename.
	pie build.
	pie shapes 
		@ (RSPopup text: [ :obj|
			obj basename, String cr,
			(directorySize value: obj) humanReadableSIByteSize ]);
		@ pieLabel;
		when: RSMouseClick do: [ animation toggle ].
	
	lines := pie shapes collect: [:s | RSPolyline new
		border: (RSBorder new dashArray: #(3));
		yourself ].
	canvas addAll: lines.
	canvas add: (RSLabel new
		text: (directorySize value: data first parent) humanReadableSIByteSize;
		yourself).
	animation := canvas newAnimation
		from: 0; to: 360; repeat; duration: 15 seconds;
		onStepDo: [ :t | 
			pie shapes do: [ :shape | | att a b label ext ang x p1 p2 p3 line |
				att := shape properties.
				a := att at: #a ifAbsentPut: [ shape alphaAngle ].
				b := att at: #b ifAbsentPut: [ shape betaAngle ].
				shape alphaAngle: a + t.
				shape betaAngle: b + t.
				label := shape propertyAt: pieLabel labelKey.
				ang := ((shape alphaAngle + shape betaAngle)/2) %360.
				ext := label extent x/2 @ 0.
				x := -250.
				(ang between: 90 and: 270) ifFalse: [ 
					ext := ext negated.
					x := x negated ].
				p1 := shape centroid: 0.
				p2 := shape centroid: 80.
				p3 := x @ p2 y.
				line := lines at: shape index.
				line shape 
					controlPoints: { p1. p2. p3 }.
				label position: p3-ext.
			]
		].
	canvas camera zoomToFit: 270 asPoint.
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera 
			zoomToFit: canvas extent * 0.9
			extent: 800@600 ].
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example24ManyPies [
	<script: 'self new example24ManyPies open setLabel: ''Usa population by State'''>
	| data labels maxSum radius color canvas pie format |
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
	radius := NSScale sqrt domain: { 0. maxSum }; range: #(0 220).
	color := NSScale eva10.
	canvas := RSCanvas new.
	pie := RSPie new.
	pie sliceShape segmentSpacing: 0.5.
	pie sliceColor: [ :slice | color scale: slice index ].

	format := [ :n | 
		n < 1000000 
			ifTrue: [ (n / 1000) asInteger asString,'K' ]
			ifFalse: [ (n / 1000000) asInteger asString,'M'  ] ].
	
	canvas addAll: (data collect: [:m | | g x |
		g := RSGroup new.
		x := radius scale: m first value.
		pie sliceShape
			innerRadius: x * 0.6;
			externalRadius: x.
		pie 
			container: g;
			objects: m allButFirst;
			slice: #yourself;
			build.
		pie shapes do: [:s | 
			s @ (RSPopup text: [ :obj | (labels at: s index+1),': ',obj asString ] )].
		g add: (RSLabel new
			fontSize: 12;
			bold;
			position: 0@ -6;
			text: m first key;
			yourself).
		g add: (RSLabel new
			fontSize: 11;
			position: 0@5;
			text: (format value: m first value);
			yourself).
		RSComposite new
			shapes: g;
			yourself.
		]).
	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSPieExamples >> example25Massiva [
	<script: 'self new example25Massiva open'>
	| pie canvas triangles icons |
	pie := RSPie new.
	canvas := pie container.
	canvas color: '1E2D72'.
	pie objects: #( 
		announcement github class pharo komitterSqueakSourceRemote
		calendar database remove smallFind remote).
	pie slice: [:m | 1].
	pie sliceShape 
		innerRadius: 130;
		externalRadius: 200;
		segmentSpacing: 2.
	pie sliceColor: (NSScale ordinal
		range: #('ECCD36' '9BCC3E' '218E4D' '365EA6' '64ACDC'
			'6058A4' '202056' 'EA2230' 'ED6B2F' 'DC417A')).
		
	pie build.
	triangles := pie shapes collect: [ :s | 
		RSShapeFactory triangle
			color: s color;
			extent: 25@20;
			yourself.
		 ].
	icons := pie shapes collect: [ :s |
		RSBitmap new
			form: (self iconNamed: s model);
			scaleBy: 2;
			yourself].
	canvas addAll: triangles.
	canvas addAll: icons.
	canvas newAnimation
		repeat;
		duration: 10 seconds;
		from: 0;
		to: 360;
		onStepDo: [ :t | 
			pie shapes doWithIndex: [ :s :i|
				| a b triangle icon |
				a := s propertyAt: #a ifAbsentPut: [ s alphaAngle ].
				b := s propertyAt: #b ifAbsentPut: [ s betaAngle ].
				s 
					alphaAngle: a +t;
					betaAngle: b + t.
				triangle := triangles at: i.
				a := s middleAngle degreesToRadians.
				triangle matrix
					loadIdentity;
					rotateByRadians: a negated - Float halfPi.
				triangle position: (a cos @ a sin negated) * (s innerRadius-8).
				
				icon := icons at: i.
				icon position: (s centroid: 0) ] ].
	canvas add:(RSPolygon new
		noPaint;
		border: (RSBorder new width: 5; color: Color white; yourself);
		points: 
			{-80 @ -50. 
			80@ -50. 
			80@50.
			0@50.
			-60@80.
			-30@50.
			-80@ 50};
		position: 0@ 15;
		cornerRadii: 20;
		yourself).
	canvas add: (RSLabel new 
		text: 'Roassal3';
		fontSize: 30;
		color: Color white).
	^ canvas
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
