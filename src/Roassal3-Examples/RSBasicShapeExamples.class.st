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
		color: Color red;
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
		withBorder.
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
	c clearBackground: false.
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
	c clearBackground: false.
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
	c clearBackground: false.
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
	c nodes @ RSDraggableInteraction.
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
	s @ RSRotatedInteraction.
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
	com := RSComposite new
		addAll:
			{c1.
			c2};
		adjustToChildren;
		model: 'Draggable';
		popup;
		draggable;
		padding: 10;
		color: Color gray translucent;
		yourself.
	c1
		when: RSMouseClick
		do: [ :evt | 
			c1 remove.
			com removeInteractionIfPresent: RSDraggableInteraction.
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
RSBasicShapeExamples >> example40PopupAndMarkers [
	<script: 'self new example40PopupAndMarkers open'>
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
