"
I have the basic examples for shapes
"
Class {
	#name : #RSShapeBasicExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example01BasicBoxes [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example02BasicEllipses [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example03BasicComposite [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example04BasicComposite [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example05BasicGroup [
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
RSShapeBasicExamples >> example06BasicLabels [
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
		
		label rotateByDegrees: angle..
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
RSShapeBasicExamples >> example07EventsMouseMoveDrag [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example08EllipseBorder [
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
RSShapeBasicExamples >> example09MouseStep [
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
RSShapeBasicExamples >> example10EllipseMouseMove [
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
RSShapeBasicExamples >> example11ScaleMouseDistance [
	<script: 'self new example11ScaleMouseDistance open'>
	| c easing canvasExtent boxSize zindex maxDist scale border |
	c := RSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 dist: canvasExtent.
	scale := NSScale linear 
		domain: { 0. maxDist}; 
		rangeRound: #(80 0).
	border := RSBorder new.
	c when: RSExtentChangedEvent do: [ 
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 dist: canvasExtent.
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
			zindex := scale scale: (easing dist: s position).
			s extent: boxSize * (zindex /100) asPoint ].
		c signalUpdate.
	].
	c clearBackground: false.
	^ c
]

{ #category : #lines }
RSShapeBasicExamples >> example12BasicLine [
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
RSShapeBasicExamples >> example14BasicBitmap [
	<script: 'self new example14BasicBitmap open'>

	| c |
	c := RSCanvas new.
	c addShape: (RSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).
		
	^ c
]

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example15BasicRoundBoxses [
	<script: 'self new example15BasicRoundBoxses open'>

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

{ #category : #lines }
RSShapeBasicExamples >> example16BasicLinePath [
	<script: 'self new example16BasicLinePath open'>
	| c b1 b2 translate l arrowWidth arrowHeight middle |
	c := RSCanvas new.
	b1 := RSBox new size: 100@100.
	b2 := RSBox new size: 100@100; color: Color blue; position: 100@100.
	c addShape: b1.
	c addShape: b2.
	
	l := RSSVGPathLine new
		svgPath: [ :aLine |
			[ :canvas | | vector u unit left right left1 right1 a b |
			a := aLine startPoint.
			b := aLine endPoint.
			arrowWidth := 50.
			arrowHeight := 30.
			vector := a-b.
			u := vector normal.
			unit := vector / (vector r max: 1).
			middle := b + (unit* arrowHeight).
			left := middle - (u * arrowWidth / 4).
			right := middle + (u * arrowWidth / 4).
			left1 := middle - (u * arrowWidth / 2).
			right1 := middle + (u * arrowWidth / 2).
			
			canvas
				absolute;
				moveTo: a;
				lineTo: left;
				lineTo: left1;
				lineTo: b;
				lineTo: right1;
				lineTo: right;
				close.
			 ]
			 ];
		width: 5;
		paint: Color yellow;
		dashArray: { 10. 2 };
		joinMiter;
		startPoint: 0@0;
		endPoint: 100@100.
	c addShape: l.
	
	translate := [ :evt |
		l 
			startPoint: b1 position;
			endPoint: b2 position.
		evt shape translateBy: evt step.
		evt signalUpdate ].
	b1 when: RSMouseDragging do: translate.
	b2 when: RSMouseDragging do: translate.
	^ c
]

{ #category : #border }
RSShapeBasicExamples >> example17Borders [
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
RSShapeBasicExamples >> example18BasicPieSlice [
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
RSShapeBasicExamples >> example19PieSlice [
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
RSShapeBasicExamples >> example20Donut [
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
RSShapeBasicExamples >> example21CornerRadii [
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
RSShapeBasicExamples >> example22BasicPieSlice [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example23FixedShape [
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
RSShapeBasicExamples >> example24Polyline [
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
RSShapeBasicExamples >> example25LabelWithBorder [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example26Polygon [
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
RSShapeBasicExamples >> example27Markers [
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
	c addShape: axes.
	c addShape: dataLine.
	c camera zoomToFit: 250@250.
	^ c
]

{ #category : #svg }
RSShapeBasicExamples >> example28SVGShape [
	<script: 'self new example28SVGShape open'>
	| c |
	c := RSCanvas new.
	c addShape: (RSSVGPath new
		paint: nil;
		withBorder;
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color red);
		svgPath: 'M 100 350 l 150 -300';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color red);
		svgPath: 'M 250 50 l 150 300';
		yourself).
	c addShape: (RSSVGPath new
		paint: nil;
		border: (RSBorder new color: Color green);
		svgPath: 'M 175 200 l 150 0';
		yourself).
	c showEncompassingRectangles.
	c zoomToFit.
	^ c
]

{ #category : #lines }
RSShapeBasicExamples >> example29PolylineRadius [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example30PolygonWithRadius [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example31BorderAttachPointWithOffset [
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

{ #category : #'box and ellipses' }
RSShapeBasicExamples >> example32RotateShapeByMouse [
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
RSShapeBasicExamples >> example33EdgesBetweenChildren [
	<script: 'self new example33EdgesBetweenChildren open'>
	| c b1 b2 e1 com1 com2 |
	c := RSCanvas new.
	com1 := RSComposite new.
	com1 paint: Color blue trans.
	b1 := RSBox new size: 10.
	com1 add: b1.
	com1 adjustToChildren.
	b1 position: 20@20.
	com1 position: 200@0.
	
	com2 := RSComposite new.
	com2 paint: Color blue trans.
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

{ #category : #lines }
RSShapeBasicExamples >> example34PaletteVisualization [
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
RSShapeBasicExamples >> example35KeyEvents [
	<script: 'self new example35KeyEvents open'>
	| c print down up |
	c := RSCanvas new.
	down := RSLabel new model: 'DOWN'; text: ''.
	up := RSLabel new model: 'UP'; text: ''.
	c addAll: { down. up }.
	RSVerticalLineLayout on: c shapes.
	print := [ :evt :s | 
		s text: (s model, ': ' , evt keyName,', value: ', evt keyValue asString).
		evt signalUpdate  ].
	c 
		when: RSKeyDown do: [ :evt | print value: evt value: down ];
		when: RSKeyUp do: [ :evt | print value: evt value: up ].

	^ c
]
