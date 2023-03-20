"
I have the basic examples for shapes
"
Class {
	#name : #RSBasicShapeExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example01BasicBoxes [
	<script: 'self new example01BasicBoxes open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSBox new
		extent: 100@100;
		yourself).
	c addShape: (RSBox new
		position: 100@100;
		color: Color blue;
		extent: 100@100;
		yourself).
	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example02BasicEllipses [
	<script: 'self new example02BasicEllipses open'>

	| c |
	c := RSCanvas new.
	c addShape: (RSEllipse new
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).
	^ c
]

{ #category : #composite }
RSBasicShapeExamples >> example03BasicComposite [
	<script: 'self new example03BasicComposite open'>
	| c com |
	c := RSCanvas new.
	com := RSComposite new.
	com add: (RSBox new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	com add: (RSBox new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).

	c addShape: com.
	c addShape: (RSEllipse new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
	^ c
]

{ #category : #composite }
RSBasicShapeExamples >> example04BasicComposite [
	<script: 'self new example04BasicComposite open'>
	| c com |
	c := RSCanvas new.
	com := RSComposite new.
	com add: (RSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	com add: (RSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).

	com position: 100@100.

	c addShape: com.
	c addShape: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example05BasicGroup [
	<script: 'self new example05BasicGroup inspect'>
	| g |
	g := RSGroup new.
	g add: (RSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	g add: (RSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).

	g add: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	g add: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	^ g
]

{ #category : #labels }
RSBasicShapeExamples >> example06BasicLabels [
	<script: 'self new example06BasicLabels open'>
	| c label |
	c := RSCanvas new.
	1 to: 12 do: [ :m |
		| angle theta p|
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := RSLabel new
			color: (Color purple alpha: 0.5);
			fontName: 'Source Sans Pro';
			fontSize: 20;
			text: (Month nameOfMonth: m);
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270)
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).

		label rotateByDegrees: angle.
		label position: p + ((label textWidth/2) * theta).
		m even
			ifTrue: [ label bold ]
			ifFalse: [ label italic ].
		c addShape: label.
		].
	c addShape: (RSEllipse new
		color: nil;
		withBorder;
		radius: 90).
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example07EventsMouseMoveDrag [
	<script: 'self new example07EventsMouseMoveDrag open'>
	| c ellipse update |
	c := RSCanvas new.
	ellipse := RSEllipse new
		radius: 40;
		border: (RSBorder new color: 'black');
		yourself.
	c addShape: ellipse.
	update := [ :evt :color |
		ellipse
			color: color;
			position: evt position;
			signalUpdate].
	c
		when: RSMouseDragging do: [ :evt |
			update value: evt value: (Color colorFrom: '12A288')];
		when: RSMouseMove do: [ :evt |
			update value: evt value: (Color colorFrom: 'AB2567') ].
	c shouldClearBackground: false.
	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example08EllipseBorder [
	<script: 'self new example08EllipseBorder open'>
	| c y r |
	c := RSCanvas new.
	r := Random new.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (RSEllipse new
			color: Color transparent;
			border: (RSBorder new
				width: x/ 50;
				color: (Color
					r: r next * 255
					g: r next * 200
					b: 255
					range: y) );
			position: (x*2@y)-250;
			extent: (y/10)@( x * 75/ 499 ) ).
		 ].
	"m := c morph.
	PolymorphSystemSettings setDesktopLogoWith: m.
	m position: 0@World menubar height.
	m extent: World extent- (0@World menubar height)."
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example09MouseStep [
	<script: 'self new example09MouseStep open'>
	|  c e prev dif |
	c := RSCanvas new.
	c color: Color black.
	e := RSEllipse new
		border: (RSBorder new color: Color white);
		radius: 0.
	c addShape: e.
	prev := 0.
	c when: RSMouseMove do: [ :evt |
		dif := (evt position x - prev) abs.
		prev := evt position x.
		e
			color: (Color r: 0 g: dif b: 0 range: 255);
			position: evt position;
			size: dif.
		c signalUpdate.
		 ].
	c shouldClearBackground: false.
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example10EllipseMouseMove [
	<script: 'self new example10EllipseMouseMove open'>
	| c border circleResolution angle a b radius p |
	c := RSCanvas new.
	c color: Color white.
	border := RSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c when: RSMouseMove do: [ :evt |
		circleResolution := b.
		circleResolution isZero ifTrue: [ circleResolution := 0.1 ].
		angle := Float twoPi / circleResolution.
		p := evt position abs.
		a := 175 * p x / c extent x.
		b := 200 * p y / c extent y.
		c shapes copy do: #remove.
		0 to: circleResolution do: [ :i |
			c addShape: (RSEllipse new
				color: Color transparent;
				rotateByDegrees: 45;
				border: border;
				extent: ((angle * i) cos @ (angle * i) sin) * radius + a
			)].

		c signalUpdate.
		 ].
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example11ScaleMouseDistance [
	<script: 'self new example11ScaleMouseDistance open'>
	| c easing canvasExtent boxSize zindex maxDist scale border |
	c := RSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 distanceTo: canvasExtent.
	scale := NSScale linear
		domain: { 0. maxDist};
		rangeRound: #(80 0).
	border := RSBorder new.
	c when: RSExtentChangedEvent do: [
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 distanceTo: canvasExtent.
		scale := NSScale linear
			domain: { 0. maxDist};
			rangeRound: #(80 0).
		0 to: canvasExtent y/boxSize do: [ :y|
			0 to: canvasExtent x/boxSize do: [ :x|
				c addShape: (RSBox new
					color: Color white;
					position: ((x@y)*boxSize) - (canvasExtent/2);
					extent: 10@10;
					border: border )
				] ]
		].
	c when: RSMouseMove do: [ :evt |
		easing := easing + ((evt position - easing)* 1).
		c shapes copy do: [ :s |
			zindex := scale scale: (easing distanceTo: s position).
			s extent: boxSize * (zindex /100) asPoint ].
		c signalUpdate.
	].
	c shouldClearBackground: false.
	^ c
]

{ #category : #lines }
RSBasicShapeExamples >> example12BasicLine [
	<script: 'self new example12BasicLine open'>
	| c rotate size angle |
	c := RSCanvas new.
	angle := 0.
	size := 0.
	rotate := [ :point | | cos sin p |
		cos := angle cos.
		sin := angle sin.
		"origin"
		p := point - ((size @ size)/2).
		"rotated"
		((p x * cos) - (p y * sin))@((p y * cos) + (p x * sin))
	].
	c when: RSMouseMove do: [ :evt |
		size := evt position distanceTo: 0@0.
		angle := evt position angle + 135 degreesToRadians.
		c shapes copy do: #remove.
		size := size asInteger.
		(0 to: size by: 3) do: [ :k |
			| a b |
			a := rotate value: k @ 0.
			b := rotate value: 0 @ (size - k).
			c addShape: (RSLine new
				startPoint: a;
				endPoint: b;
				yourself).
		 ].
		c signalUpdate.
	].

	^ c
]

{ #category : #bitmap }
RSBasicShapeExamples >> example14BasicBitmap [
	<script: 'self new example14BasicBitmap open'>

	| c |
	c := RSCanvas new.
	c addShape: (RSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).

	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example15BasicRoundBoxes [
	<script: 'self new example15BasicRoundBoxes open'>

	| c |
	c := RSCanvas new.
	c addShape: (RSBox new
		cornerRadius: 5;
		extent: 100@50).

	c addShape: (RSBox new
		cornerRadius: (RSCornerRadius new top: 20);
		position: 100@100;
		extent: 100@50;
		withBorder).

	^ c
]

{ #category : #border }
RSBasicShapeExamples >> example17Borders [
	<script: 'self new example17Borders open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSLine new
		startPoint: -100@ -100;
		endPoint: 100@ -100;
		width: 50;
		capRound;
		yourself).
	c addShape: (RSLine new
		startPoint: -100@ 0;
		endPoint: 100@ 0;
		width: 50;
		capButt;
		yourself).
	c addShape: (RSLine new
		startPoint: -100@ 100;
		endPoint: 100@ 100;
		width: 50;
		capSquare;
		yourself).
	^ c
]

{ #category : #arcs }
RSBasicShapeExamples >> example18BasicPieSlice [
	<script: 'self new example18BasicPieSlice open'>
	| c |
	c := RSCanvas new.
	"empty"
	c addShape: RSPieSlice new.
	"circle"
	c addShape: (RSPieSlice new
		innerRadius: 0;
		externalRadius: 100;
		alphaAngle: 0;
		betaAngle: 360).
	^ c
]

{ #category : #arcs }
RSBasicShapeExamples >> example19PieSlice [
	<script: 'self new example19PieSlice open'>
	| c |
	c := RSCanvas new.
	"slice"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 30;
		betaAngle: 90;
		segmentSpacing: 5).
	^ c
]

{ #category : #arcs }
RSBasicShapeExamples >> example20Donut [
	<script: 'self new example20Donut open'>
	| c |
	c := RSCanvas new.
	"donut"
	c addShape: (RSPieSlice new
		withBorder;
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 360).
	^ c
]

{ #category : #arcs }
RSBasicShapeExamples >> example21CornerRadii [
	<script: 'self new example21CornerRadii open'>
	| c |
	c := RSCanvas new.
	"corner radii"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 90;
		cornerRadii: 20).
	^ c
]

{ #category : #arcs }
RSBasicShapeExamples >> example22BasicPieSlice [
	<script: 'self new example22BasicPieSlice open'>
	| c |
	c := RSCanvas new.
	"slice"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		alphaAngle: 30;
		betaAngle: 90).
	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example23FixedShape [
	<script: 'self new example23FixedShape open'>
	| c box |
	c := RSCanvas new.
	box := RSBox new
		extent: 100@100;
		position: 200 asPoint;
		color: Color blue;
		yourself.
	box isFixed: true.
	c addShape: box.

	box := RSBox new
		extent: 100@100;
		yourself.
	c addShape: box.
	box setAsFixed.
	^ c
]

{ #category : #lines }
RSBasicShapeExamples >> example24Polyline [
	<script: 'self new example24Polyline open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolyline new
		width: 30;
		joinRound;"joinBevel; joinMiter"
		color: Color blue;
		controlPoints: { 50@300. 150@300. 150@200. 250@200. 250@100. 350@100};
		basicTranslateBy: -150 @ -150;
		yourself).
	^ c
]

{ #category : #labels }
RSBasicShapeExamples >> example25LabelWithBorder [
	<script: 'self new example25LabelWithBorder open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSLabel new
		fontSize: 60;
		fontName: 'Source Sans Pro';
		"fontName: 'Brushcrazy DEMO';"
		border: (RSBorder new
			color: Color red;
			dashArray: #(4) );
		text: 'Roassal Pharo').
	^ c
]

{ #category : #polygons }
RSBasicShapeExamples >> example26Polygon [
	<script: 'self new example26Polygon open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolygon new
		points: { 100@10. 40@198. 190@78. 10@78. 160@198 };
		yourself).
	c shapes first translateTo: 0@0.
	c showEncompassingRectangles.
	c shapes first when: RSMouseDragging do: [:evt |
		evt shape translateBy: evt step; signalUpdate].
	^ c
]

{ #category : #lines }
RSBasicShapeExamples >> example27Markers [
	<script: 'self new example27Markers open'>
	| c arrow axes circle dataLine |
	c := RSCanvas new.
	arrow := RSPolygon new
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	circle := RSEllipse new
		radius: 2.5;
		color: Color red.
	axes := RSPolyline new
		controlPoints: { 10@10. 10@90. 90@90 }.
	dataLine := RSPolyline new
		controlPoints: { 15@80. 29@50. 43@60. 57@30. 71@40. 85@15 }.
	axes markerEnd: (axes markerStart: arrow).
	dataLine marker: circle.
	axes model: 'Axes'.
	axes popup.
	dataLine model: 'Series'.
	dataLine popup.
	c addShape: axes.
	c addShape: dataLine.
	c camera zoomToFit: 250@250.
	^ c
]

{ #category : #lines }
RSBasicShapeExamples >> example29PolylineRadius [
	<script: 'self new example29PolylineRadius open '>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolyline new
		border: (RSBorder new width: 10);
		cornerRadii: 50;
		controlPoints: { 5@30. 15@30. 15@20. 25@20. 25@10. 35@10} * 50).
	c zoomToFit.
	^ c
]

{ #category : #polygons }
RSBasicShapeExamples >> example30PolygonWithRadius [
	<script: 'self new example30PolygonWithRadius open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolygon new
		cornerRadii: 10;
		points: { 100@10. 40@198. 190@78. 10@78. 160@198 };
		yourself).
	c shapes first translateTo: 0@0.
	c showEncompassingRectangles.
	c shapes first when: RSMouseDragging do: [:evt |
		evt shape translateBy: evt step; signalUpdate].
	^ c
]

{ #category : #'boxes and ellipses' }
RSBasicShapeExamples >> example31BorderAttachPointWithOffset [
	<script: 'self new example31BorderAttachPointWithOffset open'>
	| c s1 s2|
	c := RSCanvas new.
	s1 := RSEllipse new
		size: 30;
		yourself.
	s2 := RSBox new
		size: 50;
		yourself.
	s2 translateTo: 200@200.
	c add: s1; add: s2.
	c add: (RSLine new
		attachPoint: (RSBorderAttachPoint new
			startOffset: 5;
			endOffset: 10;
			yourself);
		from: s1;
		to: s2;
		yourself).
	c nodes @ RSDraggable.
	c @ RSCanvasController.
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example32RotateShapeByMouse [
	<script: 'self new example32RotateShapeByMouse open'>
	| c s |
	c := RSCanvas new.
	s := RSLabel new
		text: 'Dehaka';
		draggable;
		yourself.
	c add: s.
	s @ RSRotated.
	^ c
]

{ #category : #lines }
RSBasicShapeExamples >> example33EdgesBetweenChildren [
	<script: 'self new example33EdgesBetweenChildren open'>
	| c b1 b2 e1 com1 com2 |
	c := RSCanvas new.
	com1 := RSComposite new.
	com1 paint: Color blue translucent.
	b1 := RSBox new size: 10.
	com1 add: b1.
	com1 adjustToChildren.
	b1 position: 20@20.
	com1 position: 200@0.

	com2 := RSComposite new.
	com2 paint: Color blue translucent.
	b2 := RSBox new size: 10.
	com2 add: b2.
	com2 adjustToChildren.
	b2 position: 50@0.
	com2 position: -100@0.

	com1 draggable.
	com2 draggable.

	e1 := RSLine new from: b1; to: b2.
	c addAll: { com1. com2. e1 }.
	^ c
]

{ #category : #composite }
RSBasicShapeExamples >> example34PaletteVisualization [
	<script: 'self new example34PaletteVisualization open'>
	| c colors shapes compo label composites paletteObject |
	"Try
		RSColorPalette qualitative
		RSColorPalette sequential
	"
	paletteObject := RSColorPalette diverging.

	c := RSCanvas new.
	composites := OrderedCollection new.
	paletteObject class selectors do: [ :selector |
		colors := paletteObject perform: selector.

		shapes := RSGroup new.
		shapes addAll: (colors range collect: [ :aColor | RSBox new size: 20; color: aColor ]).

		RSHorizontalLineLayout on: shapes.

		compo := RSComposite new.
		compo shapes: shapes.
		c add: compo.
		composites add: compo.

		label := RSLabel new text: selector.
		c add: label.
		RSLocation new
			left; outer; stick: label on: compo.
	].
	RSVerticalLineLayout on: composites.
	c @ RSCanvasController.
	^ c
]

{ #category : #events }
RSBasicShapeExamples >> example35KeyEvents [
	<script: 'self new example35KeyEvents open setLabel: ''Use the keyboard'''>
	| c print down up |
	c := RSCanvas new.
	down := RSLabel new model: 'DOWN'; text: ''.
	up := RSLabel new model: 'UP'; text: ''; position: 0@ 30.
	c addAll: { down. up }.
	print := [ :evt :s |
		s text: (s model, ': ' , evt keyName,', value: ', evt keyValue asString).
		evt signalUpdate  ].
	c
		when: RSKeyDown do: [ :evt | print value: evt value: down ];
		when: RSKeyUp do: [ :evt | print value: evt value: up ].

	^ c
]

{ #category : #polygons }
RSBasicShapeExamples >> example36PolygonAndCanvas [
	<script: 'self new example36PolygonAndCanvas open setLabel: ''Zoom in or Zoom out'''>
	| coords canvas int |
	coords := {(13.3540698 @ 52.5346676).
	(13.3531445 @ 52.5339734).
	(13.347075 @ 52.530959).
	(13.343642 @ 52.531777).
	(13.3392352 @ 52.5329414).
	(13.33869 @ 52.531065).
	(13.337552 @ 52.526725).
	(13.3278908 @ 52.5276262).
	(13.327312 @ 52.524392).
	(13.3268118 @ 52.5234332).
	(13.326025 @ 52.523974).
	(13.31646 @ 52.499445).
	(13.330889 @ 52.500452).
	(13.331878 @ 52.500556).
	(13.33527 @ 52.499405).
	(13.334371 @ 52.498542).
	(13.335189 @ 52.498098).
	(13.33451 @ 52.497572).
	(13.33469 @ 52.495098).
	(13.336883 @ 52.494522).
	(13.33899 @ 52.494246).
	(13.345728 @ 52.494409).
	(13.345127 @ 52.492168).
	(13.3453118 @ 52.4866845).
	(13.3497232 @ 52.4870749).
	(13.3507406 @ 52.4862916).
	(13.3527267 @ 52.4846656).
	(13.3529346 @ 52.4841626).
	(13.381439 @ 52.4848815).
	(13.3846565 @ 52.4848903).
	(13.3860099 @ 52.4846622).
	(13.386044 @ 52.483165).
	(13.386408 @ 52.483036).
	(13.386736 @ 52.483048).
	(13.386892 @ 52.483063).
	(13.3540698 @ 52.5346676)}.
	canvas := RSCanvas new.
	canvas addShape: (RSPolygon new
		points: coords;
		color: Color black).
	int := RSCanvasController new.
	int configuration
		minScale: 1000;
		maxScale: 10000.
	canvas @ int.
	^ canvas
]

{ #category : #polygons }
RSBasicShapeExamples >> example37AngleDirection [
	<script: 'self new example37AngleDirection open setLabel: ''Angle direction in RSPieSlice'''>
	| canvas slice magic |
	canvas := RSCanvas new.
	slice := RSPieSlice new.
	slice
		innerRadius: 100;
		externalRadius: 150;
		alphaAngle: 15;
		betaAngle: 180.
	canvas add: slice.

	canvas add: (RSLine new
		startPoint: 0@ -200;
		endPoint: 0 @ 200;
		dashed;
		markerStartEnd: (RSShapeFactory arrow
			size: 10);
		yourself).
	canvas add: (RSLine new
		startPoint: -200@ 0;
		endPoint: 200 @ 0;
		dashed;
		markerStartEnd: (RSShapeFactory arrow
			size: 10);
		yourself).
	canvas add: (RSLabel new
		text: '0@0';
		position: 20@10;
		yourself).
	magic := 160*0.551784.
	canvas add: (RSBezier new
		width: 3;
		dashed;
		markerEnd: (RSShapeFactory arrow
			size: 20;
			color: Color black);
		controlPoints:
			{160@0.
			160@ magic negated.
			magic@ -160.
			0@ -160  };
		yourself
		).
	canvas add: (RSLabel new
		text: 'Angle direction';
		color: 'blue';
		position: 180@ -130;
		yourself).

	^ canvas
]

{ #category : #shapes }
RSBasicShapeExamples >> example38Interaction [
	<script: 'self new example38Interaction open'>
	| c1 c2 com canvas |
	c1 := RSEllipse new
		extent: 100 @ 50;
		withBorder;
		model: 'Click to remove';
		popup;
		color: Color red translucent;
		yourself.
	c2 := RSEllipse new
		extent: 50 @ 100;
		withBorder;
		color: Color blue translucent;
		yourself.
	com := {c1. c2} asShape
		model: 'Draggable';
		popup;
		@ (RSDraggable new noValidateChildrenEvents);
		padding: 10;
		color: Color gray translucent;
		yourself.
	c1
		when: RSMouseClick
		do: [ :evt |
			c1 remove.
			com removeInteractionIfPresent: RSDraggable.
			com model: 'Not draggable anymore'.
			evt signalUpdate ].
	canvas := RSCanvas new.
	canvas
		add:
			(RSEllipse new
				color: Color red;
				model: 'Reference';
				popup;
				size: 10;
				yourself).
	canvas add: com.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #shapes }
RSBasicShapeExamples >> example39YikigeiAnimated [
	<script: 'self new example39YikigeiAnimated open'>
	| c size circles posOffset negOffset |
	c := RSCanvas new.
	size := 200.
	c addAll: (circles := #(magenta yellow red cyan) collect: [ :sel |
	    c add: (RSEllipse new
	        size: size;
	        color: ((Color perform: sel) alpha: 0.4 );
	        yourself).
	    ]).
	c when: RSMouseMove do: [ :evt |
	    posOffset := (evt position distanceTo: 0@0).
	    negOffset := posOffset negated.
	    circles first position: posOffset @ 0.
	    circles second position: 0 @ posOffset.
	    circles third position: negOffset @ 0.
	    circles fourth position: 0@negOffset.
	    c signalUpdate.
	     ].
	^ c
]

{ #category : #shapes }
RSBasicShapeExamples >> example40ColorScale [
	<script: 'self new example40ColorScale open'>
	| color canvas popup shapes |
	color := NSScale linear
	    domain: { 1. 200. 400 };
	    range: #(white gray red).

	canvas := RSCanvas new.
	popup := RSPopup text: [ :cls |
	    cls name, String crlf,
	    'Nro Methods: ', cls numberOfMethods asString, String crlf,
	    'Lines of Code: ', cls linesOfCode asString ].
	shapes := Collection withAllSubclasses collect: [ :cls |
	    RSBox new
	        model: cls;
	        @ popup;
	        draggable;
	        color:( color scale: cls numberOfMethods );
	        size: cls linesOfCode sqrt + 10;
	        yourself
	     ].
	canvas addAll: shapes.
	RSLineBuilder orthoVertical
	    withVerticalAttachPoint;
	    shapes: shapes;
	    connectFrom: #superclass.
	RSTreeLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #lines }
RSBasicShapeExamples >> example41PopupAndMarkers [
	<script: 'self new example41PopupAndMarkers open'>
	| line marker canvas |
	line := RSLine new.
	line startPoint: 300@300; endPoint: 500@300.
	marker := RSShapeFactory star size: 40.
	line markerEnd: marker.
	line @ RSPopup new.
	line model: 'foo'.
	canvas := RSCanvas new add: line; yourself.
	canvas zoomToFit.
	^ canvas
]

{ #category : #lines }
RSBasicShapeExamples >> example42GhostDraggable [
	<script: 'self new example42GhostDraggable open'>
	| canvas b1 b2 |
	canvas := RSCanvas new.
	canvas add: (b1:=RSBox new
		color: Color green translucent;
		size: 100;
		yourself).
	canvas add: (b2:=RSBox new
		size: 100;
		position: 150 asPoint;
		color: Color purple translucent;
		yourself).
	canvas shapes addInteraction: RSGhostDraggable new.
	canvas add: (RSLine new
		from: b1;
		to: b2;
		yourself).
	^ canvas
]

{ #category : #lines }
RSBasicShapeExamples >> example43ShortestAttachPoint [
	<script: 'self new example43ShortestAttachPoint open'>
	| canvas numbers marker |
	canvas := RSCanvas new.
	numbers := (1 to: 10) shuffled collect: [ :n |
		({ RSLabel text: n } asGroup asShapeFor: n)
			color: Color white;
			withBorder;
			padding: 10;
			yourself ] as: RSGroup.
	numbers @ RSDraggable new.
	canvas addAll: numbers.
	marker := (RSShapeFactory arrow
		size: 10;
		asMarker)
		offset: 5;
		yourself.
	RSLineBuilder line
		attachPoint: (RSShortestVerticalAttachPoint new
			"endOffset: 5;"
			yourself);
		canvas: canvas;
		markerEnd: marker;
		color: Color gray translucent;
		fromShapes: (numbers select: [:each | each model even]);
		toShapes: numbers;
		connectTo: [ :n | n + 1 ].
	RSLineBuilder line
		attachPoint: (RSShortestHorizontalAttachPoint new
			"endOffset: 5;"
			yourself);
		canvas: canvas;
		markerEnd: marker;
		color: Color gray translucent;
		fromShapes: (numbers select: [:each | each model odd]);
		toShapes: numbers;
		connectTo: [ :n | n + 1 ].
	RSSimpleForceBasedLayout on: numbers.
	^ canvas @ RSCanvasController simple
]

{ #category : #'as yet unclassified' }
RSBasicShapeExamples >> example44AA [
	<script: 'self new example44AA open'>
	| canvas |
	canvas := RSCanvas new.
	canvas
		add: (RSBox new size: 30; color: 'blue'; yourself);
		add: (RSLine new width: 0.5; startPoint: 0@0; endPoint: 50 asPoint; color: 'black'; yourself);
		add: (RSEllipse new extent: 40@50; color: 'gray'; yourself);
		add: (RSLabel new text: 'AA enabled'; color: 'black'; yourself).
	RSGridLayout on: canvas shapes.
	canvas zoomToFit.
	canvas newAnimation
		repeat;
		onStepDo: [ :t | 
			canvas shapes last text: (canvas hasAntialiasing
				ifTrue: ['AA enabled']
				ifFalse: [ 'AA disabled' ] ).
			canvas signalUpdate ];
		when: RSAnimationLoopEvent do: [ :evt | 
			canvas hasAntialiasing
				ifTrue: [ canvas disableAntialiasing ]
				ifFalse: [ canvas enableAntialiasing ].
			canvas signalUpdate.
			 ].
	^ canvas
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLine [

	<script: 'self new example44deCasteljauLine open'>
	| points |
	points := { 
		          (1 @ 0).
		          (1.66575 @ -0.49197).
		          (3.07038 @ -0.1196).
		          (3 @ 1) } collect: [ :each | each * 100 ].

	^ RSCanvas new
		  addAll: (RSdeCasteljauLine new
				   samplesLinspace: 50;
				   controlPoints: points;
				   asGroupWithControlNet);
		  addShape: (RSBezier new
				   color: Color red;
				   controlPoints: points;
				   yourself);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineAsBeziers [

	<script: 'self new example44deCasteljauLineAsBeziers open'>
	| points bezier |
	points := { 
		          (1 @ 0).
		          (1.66575 @ -0.49197).
		          (3.07038 @ -0.1196).
		          (3 @ 1) } collect: [ :each | each * 100 ].

	bezier := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: points;
		          yourself.

	^ RSCanvas new
		  addAll: (bezier asGroupWithControlNetColoured: Color red);
		  addAll: bezier asBeziersGroup;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineBernsteinBase [

	<script: 'self new example44deCasteljauLineBernsteinBase open'>
	| points |
	points := { 
		          (1 @ 1).
		          (3 @ 4).
		          (5 @ 6).
		          (7 @ 8).
		          (10 @ 2).
		          (1 @ 1) }.

	^ RSCanvas new
		  addAll: (RSdeCasteljauLine new
				   samplesLinspace: 50;
				   controlPoints: points;
				   asGroupBernsteinBase);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineClosedControlPoints [

	<script: 'self new example44deCasteljauLineClosedControlPoints open'>
	^ RSCanvas new
		  addAll:
			  self lineDeCasteljauLineClosedControlPoints asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineClosedControlPointsArcLengthParameterized [

	<script:
	'self new example44deCasteljauLineClosedControlPointsArcLengthParameterized open'>
	^ RSCanvas new
		  addAll:
			  self lineDeCasteljauLineClosedControlPoints
				  arcLengthParameterization asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineDegreeElevation [

	<script: 'self new example44deCasteljauLineDegreeElevation open'>
	^ self linesDeCasteljauLineDegreeElevation bind: [ 
		  :bspline1 
		  :bspline2 
		  :bspline3 
		  :bspline4 | 
		  RSCanvas new
			  addAll: (bspline1 asGroupWithControlNetColoured: Color gray);
			  addAll: (bspline2 asGroupWithControlNetColoured: Color red);
			  addAll: (bspline3 asGroupWithControlNetColoured: Color blue);
			  addAll: (bspline4 asGroupWithControlNetColoured: Color brown);
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineDerivative [

	<script: 'self new example44deCasteljauLineDerivative open'>
	| points bezier |
	points := { 
		          (1 @ 1).
		          (3 @ 4).
		          (5 @ 6).
		          (7 @ 8).
		          (10 @ 2).
		          (1 @ 1) }.

	bezier := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: points;
		          scale: 100.

	^ RSCanvas new
		  addAll: (bezier asGroupWithControlNetColoured: Color red);
		  addAll:
			  (bezier difference derivative asGroupWithControlNetColoured:
					   Color blue);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineDifference [

	<script: 'self new example44deCasteljauLineDifference open'>
	| points bezier |
	points := { 
		          (1 @ 1).
		          (3 @ 4).
		          (5 @ 6).
		          (7 @ 8).
		          (10 @ 2).
		          (1 @ 1) }.

	bezier := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: points;
		          scale: 100.

	^ RSCanvas new
		  addAll: (bezier asGroupWithControlNetColoured: Color blue);
		  addAll:
			  (bezier difference asGroupWithControlNetColoured: Color red);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineJunctionLeft [

	<script: 'self new example44deCasteljauLineJunctionLeft open'>
	| line anotherLine |
	line := RSdeCasteljauLine new
		        samplesLinspace: 50;
		        controlPoints: { 
				        (10 @ 12).
				        (13 @ 8.5).
				        (16 @ -2).
				        (26 @ 0) };
		        scale: 100.

	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: { 
				               (0 @ 3).
				               (1 @ -4).
				               (5 @ 0) };
		               scale: 100.

	^ line junction: anotherLine left: [ :lineC0 :lineC1 :lineC2 | 
		  RSCanvas new
			  addAll: (line asGroupWithControlNetColoured: Color gray);
			  addAll: (anotherLine asGroupWithControlNetColoured: Color brown);
			  addAll: (lineC0 asGroupWithControlNetColoured: Color red);
			  addAll: (lineC1 asGroupWithControlNetColoured: Color blue);
			  addAll: (lineC2 asGroupWithControlNetColoured: Color green);
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineJunctionRight [

	<script: 'self new example44deCasteljauLineJunctionRight open'>
	| aLine anotherLine |
	aLine := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: { 
				         (0 @ 0).
				         (1 @ 2).
				         (3 @ 2).
				         (6 @ -1) };
		         scale: 100.

	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: { 
				               (15 @ 3).
				               (15 @ 3).
				               (15 @ 3).
				               (15 @ 3).
				               (17 @ -4).
				               (17 @ 0) };
		               scale: 100.

	^ aLine junction: anotherLine right: [ :lineC0 :lineC1 :lineC2 | 
		  RSCanvas new
			  addAll: (aLine asGroupWithControlNetColoured: Color gray);
			  addAll: (anotherLine asGroupWithControlNetColoured: Color brown);
			  addAll: (lineC0 asGroupWithControlNetColoured: Color red);
			  addAll: (lineC1 asGroupWithControlNetColoured: Color blue);
			  addAll: (lineC2 asGroupWithControlNetColoured: Color green);
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineJunctionRightLongVerticalLine [

	<script:
	'self new example44deCasteljauLineJunctionRightLongVerticalLine open'>
	| aLine anotherLine random |
	random := RandomBoxMullerBivariateGaussian seed: 541.

	aLine := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: { 
				         (0 @ 0 + random next).
				         (0 @ 50 + random next).
				         (0 @ 100 + random next).
				         (0 @ 200 + random next) };
		         yourself.

	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: { 
				               (10 @ 200 + random next).
				               (50 @ 200 + random next).
				               (100 @ 200 + random next) };
		               yourself.

	^ aLine junction: anotherLine right: [ :lineC0 :lineC1 :lineC2 | 
		  RSCanvas new
			  addAll: (aLine asGroupWithControlNetColoured: Color gray);
			  addAll: (anotherLine asGroupWithControlNetColoured: Color brown);
			  addAll: (lineC0 asGroupWithControlNetColoured: Color red);
			  addAll: (lineC1 asGroupWithControlNetColoured: Color blue);
			  addAll: (lineC2 asGroupWithControlNetColoured: Color green);
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineNoteBox [

	<script: 'self new example44deCasteljauLineNoteBox open'>
	| line |
	line := self lineDeCasteljauLineNoteBox.

	self assert: (Rectangle encompassing: line controlPoints)
		= (-4.520638537331172 @ -7.975723858025306 corner:
				 218.56668027942536 @ 189.46698343689167).

	^ RSCanvas new
		  addAll: line asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineNoteBoxDegreeElevation [

	<script:
	'self new example44deCasteljauLineNoteBoxDegreeElevation open'>
	^ (self lineDeCasteljauLineNoteBox elevate: 100) in: [ :whole | 
		  RSCanvas new
			  addAll: whole arcLengthParameterization asGroupWithControlNet;
			  zoomToFit;
			  addInteraction: RSCanvasController new;
			  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineNoteBoxJunctionOfFourBeziers [

	<script: 'self new example44deCasteljauLineNoteBoxJunctionOfFourBeziers open'>
	| left bottom right top leftBottom rightTop bottomRight topLeft |
	left := RSdeCasteljauLine new
		        samplesLinspace: 50;
		        controlPoints: { 
				       " (0 @ 0)."
				        (-1.143 @ 17).
				        (0 @ 39.19).
				        (0.429 @ 59.429).
				        (-1.143 @ 70.095).
				        (-2.597 @ 86.21).
				        (0 @ 100) };
		        yourself.

	bottom := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: { 
				          "(0 @ 100)".
				          (33.024 @ 105.286).
				          (51.077 @ 90.71).
				          (81.187 @ 102.83).
				          (113.583 @ 105.57).
				          (137.6 @ 103.85).
				          (Float goldenRatio @ 1 * 100) };
		          yourself.

	leftBottom := left junction: bottom right: [ :c0 :c1 :c2 | c1 ].

	right := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: ({ 
				          (0 @ 0).
				          (-1.143 @ 17).
				          (0 @ 39.19).
				          (0.429 @ 59.429).
				          (-1.143 @ 70.095).
				          (-2.597 @ 86.21).
				          (0 @ 100) } reversed collect: [ :each | 
					          each x + (Float goldenRatio * 100) @ each y ]);
		         yourself.

	bottomRight := leftBottom junction: right right: [ :c0 :c1 :c2 | c1 ].

	top := RSdeCasteljauLine new
		       samplesLinspace: 50;
		       controlPoints: ({ 
				        (0 @ 100).
				        (33.024 @ 105.286).
				        (51.077 @ 90.71).
				        (81.187 @ 102.83).
				        (113.583 @ 105.57).
				        (137.6 @ 103.85).
				       " (Float goldenRatio * 100 @ 100)" } reversed collect: [ 
					        :each | each x @ (each y - 100) ]);
		       yourself.

	rightTop := bottomRight junction: top right: [ :c0 :c1 :c2 | c1 ].

	topLeft := rightTop junction: left right: [ :c0 :c1 :c2 | c1 ].

	self assert: topLeft designPoints , leftBottom designPoints
		, bottomRight designPoints , rightTop designPoints = { 
			(0 @ 0).
			(-33.024 @ -5.286000000000001).
			(0 @ 0).
			(-1.143 @ 17).
			(0 @ 39.19).
			(0.429 @ 59.429).
			(-1.143 @ 70.095).
			(-2.597 @ 86.21).
			(0 @ 100).
			(0 @ 100).
			(2.597 @ 113.79).
			(0 @ 100).
			(33.024 @ 105.286).
			(51.077 @ 90.71).
			(81.187 @ 102.83).
			(113.583 @ 105.57).
			(137.6 @ 103.85).
			(161.80339887498948 @ 100).
			(161.80339887498948 @ 100).
			(186.00679774997897 @ 96.15).
			(161.80339887498948 @ 100).
			(159.20639887498947 @ 86.21).
			(160.66039887498948 @ 70.095).
			(162.23239887498949 @ 59.429).
			(161.80339887498948 @ 39.19).
			(160.66039887498948 @ 17).
			(161.80339887498948 @ 0).
			(161.80339887498948 @ 0).
			(162.94639887498948 @ -17).
			(161.80339887498948 @ 0).
			(137.6 @ 3.8499999999999943).
			(113.583 @ 5.569999999999993).
			(81.187 @ 2.8299999999999983).
			(51.077 @ -9.290000000000006).
			(33.024 @ 5.286000000000001).
			(0 @ 0) }.


	^ RSCanvas new
		  addAll: (topLeft asGroupWithControlNetColoured: Color red);
		  addAll: (leftBottom asGroupWithControlNetColoured: Color blue);
		  addAll: (bottomRight asGroupWithControlNetColoured: Color magenta);
		  addAll: (rightTop asGroupWithControlNetColoured: Color green);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineNoteBoxTopLeftCornerJunction [

	<script: 'self new example44deCasteljauLineNoteBoxTopLeftCornerJunction open'>
	| aLine anotherLine random juncted offsetPoint |
	random := RandomBoxMullerBivariateGaussian new.

	offsetPoint := 5 @ -5 * 5.

	aLine := RSdeCasteljauLine new
		         samplesLinspace: 50;
		         controlPoints: { 
				         (0 @ 0 - offsetPoint).
				         (0 @ 300) };
		         elevate: 5.


	anotherLine := RSdeCasteljauLine new
		               samplesLinspace: 50;
		               controlPoints: { 
				               (300 @ 0).
				               (0 @ 0 + offsetPoint) };
		               elevate: 5.

	juncted := anotherLine junction: aLine right: [ :c0 :c1 :c2 | c1 ].

	^ RSCanvas new
		  addAll: (aLine asGroupWithControlNetColoured: Color red);
		  addAll: (anotherLine asGroupWithControlNetColoured: Color blue);
		  addAll: (juncted asGroupWithControlNetColoured: Color green);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenC [

	<script: 'self new example44deCasteljauLinePenC open'>
	| b1 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 25 @ 50;
				      addPoint: 150 @ 50 via: 25 @ 100 via: 150 @ 100 ].

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenOrthogonalHorizontalLine [

	<script:
	'self new example44deCasteljauLinePenOrthogonalHorizontalLine open'>
	| b1 random |
	random := RandomBoxMullerBivariateGaussian seed: 541.

	b1 := RSdeCasteljauLine new
		      samplesLinspace: 100;
		      pen: [ :aBezier | 
			      | a  c |
			      a := 100.
			      c := a + 100.
			      aBezier
				      addPoint: 0 @ 0 + random next;
				      addPoint: a @ 0 + random next;"
				      addPoint: b @ 0 + random next;"
				      addBezierPoint: c @ 100 + random next;
				      addPoint: c @ 200 + random next;
				      addBezierPoint: c + 100 @ 300 + random next;
				      addPoint: c + 200 @ 300 + random next";
				      addPoint: c + 300 @ 300 + random next" ];
		      yourself.

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenQ [

	<script: 'self new example44deCasteljauLinePenQ open'>
	| b1 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 25 @ 75;
				      addPoint: 75 @ 100 via: 50 @ 150 ].

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenQuote [

	<script: 'self new example44deCasteljauLinePenQuote open'>
	| b1 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 100;
		      pen: [ :aBezier | 
			      | base |
			      base := 300 @ 419.7.
			      aBezier addPoint: base.
			      aBezier
				      addPoint: 0 @ -290
				      via: 0 @ 0
				      via: 224.2 @ -246.7
				      relativeTo: base.
			      aBezier
				      addBezierPoint: 300 @ 262.4 via: 197 @ 338;
				      addBezierPoint: 300 @ 419.7 via: 242 @ 498.2 ];
		      yourself.

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenS [

	<script: 'self new example44deCasteljauLinePenS open'>
	| b1 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 25 @ 50;
				      addPoint: 150 @ 50 via: 25 @ 100 via: 150 @ 100;
				      addBezierPoint: 300 @ 25 via: 175 @ -50 ].

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenT [

	<script: 'self new example44deCasteljauLinePenT open'>
	| b1 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 25 @ 75;
				      addPoint: 75 @ 100 via: 50 @ 150;
				      addBezierPoint: 150 @ 150 ].

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePenTwoLines [

	<script: 'self new example44deCasteljauLinePenTwoLines open'>
	| b1 b2 b3 |
	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 25 @ 50;
				      addPoint: 150 @ 50 via: 25 @ 100 via: 150 @ 100 ].

	b2 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: b1 designPoints last;
				      addPoint: 250 @ 25
				      via:
					      (b1 designPoints lastButOne reflectedAbout:
							       b1 designPoints last)
				      via: 200 @ 0 ].

	b3 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      pen: [ :aBezier | 
			      aBezier
				      addPoint: 200 @ 0;
				      addPoint: 250 @ 25 ].

	^ RSCanvas new
		  addAll: b1 asGroupWithControlNet;
		  addAll: (b2 asGroupWithControlNetColoured: Color red);
		  addAll: ((b1 junction: b3 right: [ :c0 :c1 :c2 | c1 ]) 
				   asGroupWithControlNetColoured: Color blue);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLinePolar [

	<script: 'self new example44deCasteljauLinePolar open'>
	| points bezier |
	points := { 
		          (0 @ 0).
		          (0 @ 4).
		          (2 @ 4).
		          (1 @ 2) }.

	bezier := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: points;
		          scale: 100.

	^ RSCanvas new
		  addAll: (bezier asGroupWithControlNetColoured: Color red);
		  addAll:
			  ((bezier polar: 1 / 2) asGroupWithControlNetColoured: Color blue);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineReflection [

	<script: 'self new example44deCasteljauLineReflection open'>
	| b1 p1 p2 p3 p4 p5 p6 |
	p1 := 200 @ 100.
	p2 := 0 @ 200.
	p3 := p2 reflectedAbout: p1.

	p4 := 600 @ 300.
	p5 := 800 @ 100.
	p6 := p5 reflectedAbout: p4.

	b1 := RSdeCasteljauLine new
		      samplesLinspace: 50;
		      controlPoints: { 
				      p1.
				      p2.
				      p3.
				      p4.
				      p5.
				      p6 };
		      yourself.

	^ RSCanvas new
		  addAll: (b1 asGroupWithControlNetColoured: Color green);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  " addAll: (b1 asGroupWithControlNetColoured: Color red);
		  addAll: (b2 asGroupWithControlNetColoured: Color blue);"
			  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineRepeatedControlPoint [

	<script: 'self new example44deCasteljauLineRepeatedControlPoint open'>
	| simpleControlPoints repetitionControlPoints aPoint |
	aPoint := 10 @ 1.

	simpleControlPoints := { 
		                       (2 @ 4).
		                       (6 @ 12).
		                       aPoint.
		                       (12 @ 12) } collect: [ :each | each * 100 ].

	repetitionControlPoints := { 
		                           (2 @ 4).
		                           (6 @ 12).
		                           aPoint.
		                           aPoint.
		                           aPoint.
		                           aPoint.
		                           (12 @ 12) } collect: [ :each | 
		                           each * 100 ].

	^ RSCanvas new
		  addAll: (RSdeCasteljauLine new
				   samplesLinspace: 50;
				   controlPoints: simpleControlPoints;
				   asGroupWithControlNetColoured: Color red);
		  addAll: (RSdeCasteljauLine new
				   samplesLinspace: 50;
				   controlPoints: repetitionControlPoints;
				   asGroupWithControlNetColoured: Color blue);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineReversed [

	<script: 'self new example44deCasteljauLineReversed open'>
	| points line |
	points := { 
		          (1 @ 0).
		          (1.66575 @ -0.49197).
		          (3.07038 @ -0.1196).
		          (3 @ 1) } collect: [ :each | each * 100 ].

	line := RSdeCasteljauLine new
		        samplesLinspace: 50;
		        controlPoints: points;
		        yourself.

	^ RSCanvas new
		  addAll: (line asGroupWithControlNetColoured: Color red);
		  addAll:
			  (line reversed asGroupWithControlNetColoured: Color blue);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauLineSplitAt [

	<script: 'self new example44deCasteljauLineSplitAt open'>
	| points |
	points := { 
		          (0 @ 0).
		          (1 @ 3).
		          (2.5 @ 4).
		          (5 @ 4.5).
		          (4.5 @ 2.5).
		          (6 @ 1) }.

	^ (RSdeCasteljauLine new
		   samplesLinspace: 50;
		   controlPoints: points;
		   scale: 100)
		  splitAt: 1 / 4
		  in: [ :leftSpline :rightSpline :bspline | 
			  RSCanvas new
				  addAll: (bspline asGroupWithControlNetColoured: Color gray);
				  addAll: (leftSpline asGroupWithControlNetColoured: Color red);
				  addAll: (rightSpline asGroupWithControlNetColoured: Color blue);
				  zoomToFit;
				  addInteraction: RSCanvasController new;
				  yourself ]
]

{ #category : #lines }
RSBasicShapeExamples >> example44deCasteljauRationalLineClosedControlPoints [

	<script:
	'self new example44deCasteljauRationalLineClosedControlPoints open'>
	| points bezier |
	points := { 
		          (0 @ 0).
		          (1 / 2 @ 2).
		          (3 @ 2).
		          (3 / 2 @ 1) }.

	bezier := RSdeCasteljauLine new
		          samplesLinspace: 50;
		          controlPoints: points;
		          scale: 100.

	^ RSCanvas new
		  addAll:
			  ((bezier weighted: #( 1 1 0 1 )) asGroupWithControlNetColoured:
					   Color red);
		  addAll:
			  ((bezier weighted: #( 1 1 0.5 1 )) 
				   asGroupWithControlNetColoured: Color blue);
		  addAll:
			  ((bezier weighted: #( 1 1 1 1 )) asGroupWithControlNetColoured:
					   Color brown);
		  addAll:
			  ((bezier weighted: #( 1 1 2 1 )) asGroupWithControlNetColoured:
					   Color magenta);
		  addAll:
			  ((bezier weighted: #( 1 1 5 1 )) asGroupWithControlNetColoured:
					   Color pink);
		  addAll:
			  ((bezier weighted: #( 1 1 10 1 )) asGroupWithControlNetColoured:
					   Color orange);
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example46NoteInteger [

	<script: 'self new example46NoteInteger open'>
	^ RSCanvas new
		  add: self noteInteger;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> example46NoteLoremIpsum [

	<script: 'self new example46NoteLoremIpsum open'>
	^ RSCanvas new
		  add: self noteLoremIpsum;
		  zoomToFit;
		  addInteraction: RSCanvasController new;
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> lineDeCasteljauLineClosedControlPoints [

	| points |
	points := { 
		          (1 @ 1).
		          (3 @ 4).
		          (5 @ 6).
		          (7 @ 8).
		          (10 @ 2).
		          (1 @ 1) }.

	^ RSdeCasteljauLine new
		  samplesLinspace: 100;
		  controlPoints: points;
		  scale: 100
]

{ #category : #lines }
RSBasicShapeExamples >> lineDeCasteljauLineNoteBox [

	^ RSdeCasteljauLine new
		  samplesLinspace: 10;
		  controlPoints: { 
				  (0 @ 0).
				  (8.461 @ 36.411).
				  (0.6 @ 129.887).
				  (25.3 @ 195.304).
				  (-67.3 @ 222.719).
				  (16.72 @ 245.576).
				  (-55.8 @ 178.406).
				  (60 @ 136.3).
				  (136 @ 136).
				  (142.2 @ 222.332).
				  (393.292 @ 192.739).
				  (247.8 @ 244.8).
				  (179.5 @ 201.105).
				  (221.9 @ 163.04).
				  (200 @ 125.8).
				  (204.4 @ 101.697).
				  (210.405 @ 85.124).
				  (217.89 @ 18.03).
				  (151.73 @ 29.54).
				  (244.5 @ -26.58).
				  (318.633 @ -42.131).
				  (145.27 @ 1.9).
				  (52.05 @ 8.718).
				  (0 @ 0) };
		  yourself
]

{ #category : #lines }
RSBasicShapeExamples >> linesDeCasteljauLineDegreeElevation [

	| points bspline1 bspline2 bspline3 bspline4 |
	points := { 
		          (1 @ 1).
		          (3 @ 4).
		          (5 @ 6).
		          (7 @ (3 / 2)).
		          (10 @ 2) }.

	bspline1 := RSdeCasteljauLine new
		            controlPoints: points;
		            scale: 100.

	bspline2 := bspline1 increment.
	bspline3 := bspline2 increment.
	bspline4 := bspline3 increment.

	^ RSGroup
		  with: bspline1
		  with: bspline2
		  with: bspline3
		  with: bspline4
]

{ #category : #lines }
RSBasicShapeExamples >> noteInteger [

	^ RSLabel new
		  model: 541;
		  useDefaultCodeFont;
		  notedWithPad: Float goldenPlatinumRatio
]

{ #category : #lines }
RSBasicShapeExamples >> noteLoremIpsum [

	^ RSLabel new
		  text: (String loremIpsum: 50);
		  useDefaultCodeFont;
		  padded: Float goldenPlatinumRatio
		  withNoteDo: [ :aBox | aBox color: Color yellow translucent ]
]

{ #category : #accessing }
RSBasicShapeExamples >> order [
	^ 0
]
