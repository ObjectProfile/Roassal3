"
I have the basic examples for shapes
"
Class {
	#name : #TSShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-UML-Examples'
}

{ #category : #'box and ellipses' }
TSShapeExamples >> example01BasicBoxes [
	<script: 'self new example01BasicBoxes'>

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
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example02BasicEllipses [
	<script: 'self new example02BasicEllipses'>

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
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example03BasicComposite [
	<script: 'self new example03BasicComposite'>

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
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example04BasicComposite [
	<script: 'self new example04BasicComposite'>

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
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example05BasicGroup [
	<script: 'self new example05BasicGroup'>

	| c |
	c := RSCanvas new.
	c addShape: (RSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	c addShape: (RSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
		
	c addShape: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (RSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #labels }
TSShapeExamples >> example06BasicLabels [
	<script: 'self new example06BasicLabels'>

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
	c open
	



]

{ #category : #events }
TSShapeExamples >> example07EventsMouseMoveDrag [
	<script: 'self new example07EventsMouseMoveDrag'>

	| c ellipse a b update anim |
	c := RSCanvas new.
	ellipse := RSEllipse new
		radius: 40;
		withBorder.
	c addShape: ellipse.
	a := Color colorFrom: '12A288'.
	b := Color colorFrom: 'AB2567'.
	update := [ :evt :color |
		ellipse 
			color: color;
			position: evt position;
			signalUpdate].
	anim := nil.
	c
		when: RSMouseDragging do: [ :evt | update value: evt value: a ];
		when: RSMouseMove do: [ :evt | update value: evt value: b  ].
	c clearBackground: false.
	
	c open.
	
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example08EllipseBorder [
	<script: 'self new example08EllipseBorder'>

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
	c open
]

{ #category : #events }
TSShapeExamples >> example09MouseStep [
	<script: 'self new example09MouseStep'>

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
	c open.
]

{ #category : #events }
TSShapeExamples >> example10EllipseMouseMove [
	<script: 'self new example10EllipseMouseMove'>

	| c border circleResolution angle a b radius |
	c := RSCanvas new.
	c color: Color white.
	border := RSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c when: RSMouseMove do: [ :evt | 
		circleResolution := b.
		circleResolution isZero ifTrue: [ circleResolution := 0.1 ].
		angle := Float twoPi / circleResolution.
		a := 175 * evt position x / c extent x.
		b := 200 * evt position y / c extent y.
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
	c open.
]

{ #category : #events }
TSShapeExamples >> example11ScaleMouseDistance [
	<script: 'self new example11ScaleMouseDistance'>

	| c easing canvasExtent boxSize zindex maxDist scale border |
	c := RSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 dist: canvasExtent.
	scale := TSScale linear 
		domain: { 0. maxDist}; 
		rangeRound: #(80 0).
	border := RSBorder new.
	c when: RSExtentChangedEvent do: [ 
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 dist: canvasExtent.
		scale := TSScale linear 
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
	c open.
]

{ #category : #lines }
TSShapeExamples >> example12BasicLine [
	<script: 'self new example12BasicLine'>

	| c |
	c := RSCanvas new.
	c addShape: RSLine new.
	c open.
]

{ #category : #bitmap }
TSShapeExamples >> example14BasicBitmap [
	<script: 'self new example14BasicBitmap'>

	| c |
	c := RSCanvas new.
	c addShape: (RSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).
		
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example15BasicRoundBoxses [
	<script: 'self new example15BasicRoundBoxses'>

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
		
	c open
]

{ #category : #lines }
TSShapeExamples >> example16BasicLinePath [
	<script: 'self new example16BasicLinePath'>
	| c b1 b2 translate l arrowWidth arrowHeight middle |
	c := RSCanvas new.
	b1 := RSBox new size: 100@100.
	b2 := RSBox new size: 100@100; color: Color blue; position: 100@100.
	c addShape: b1.
	c addShape: b2.
	
	l := RSSVGPathLine new
		svgPath: [ :a :b |
			[ :canvas | | vector u unit left right left1 right1 |
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
	c open
]

{ #category : #border }
TSShapeExamples >> example17Borders [
	<script: 'self new example17Borders'>
	| c border border2 a b ce d |
	c := RSCanvas new.
	border := [ :position :inner :outer :text |
		c addShape: (RSBox new
			color: Color lightGray;
			position: position;
			border: (RSBorder new
				capSquare;
				joinMiter;
				color: inner);"brighter"
			size: 100).
		c addShape: (RSBox new
			color: nil;
			position: position;
			border: (RSBorder new
				capSquare;
				dashArray: #(98 196);
				color: outer);"darker"
			size: 98).
		c addShape: (RSBox new
			color: nil;
			position: position;
			border: (RSBorder new
				capSquare;
				dashArray: #(0 102 102 0 102 0);
				color: outer);"darker"
			size: 102).
		c addShape: (RSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	border2 := [ :position :text |
		
		c addShape: (RSBox new
			color: Color lightGray;
			position: position;
			size: 100).
		c addShape: (RSLine new
			startPoint: position - 50;
			endPoint: position + (50 @ -50);
			color: a).
		c addShape: (RSLine new
			startPoint: position - 50;
			endPoint: position + (-50 @ 50);
			color: a).
		c addShape: (RSLine new
			startPoint: position - 49;
			endPoint: position + (49 @ -49);
			color: b).
		c addShape: (RSLine new
			startPoint: position - 49;
			endPoint: position + (-49 @ 49);
			color: b).
			
		c addShape: (RSLine new
			startPoint: position + (-49@49);
			endPoint: position + 49;
			color: ce ).
		c addShape: (RSLine new
			startPoint: position + (49@ -49) ;
			endPoint: position + (49 @ 49);
			color: ce).
			
		c addShape: (RSLine new
			startPoint: position + (-50@50);
			endPoint: position + 50;
			color: d).
		c addShape: (RSLine new
			startPoint: position + (50@ -50);
			endPoint: position + (50 @ 50);
			color: d).
		c addShape: (RSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	
	"line border"
	c addShape: (RSBox new
		color: Color lightGray;
		border: RSBorder new;
		size: 100).
	c addShape: (RSLabel new
		text: 'Line border';
		color: Color black).
	"raised etched"
	border 
		value: 120@0
		value: (Color lightGray adjustBrightness: 0.08)
		value: (Color lightGray adjustBrightness: -0.08)
		value: 'Raised etched'.
	
	"lowered etched"
	border 
		value: -120@0
		value: (Color lightGray adjustBrightness: -0.08)
		value: (Color lightGray adjustBrightness: 0.08)
		value: 'Lowered etch'.
	"Raised bevel"
	b := Color lightGray adjustBrightness: 0.08.
	a := b adjustBrightness: 0.08.
	ce := Color lightGray adjustBrightness: -0.08.
	d := ce adjustBrightness: -0.08.
	border2
		value: 0@ -120
		value: 'Raised bevel'.
	"Lowered bevel"
	b := Color lightGray adjustBrightness: -0.08.
	a := b adjustBrightness: -0.08.
	ce := Color lightGray adjustBrightness: 0.08.
	d := ce adjustBrightness: 0.08.
	border2 
		value: 0@ 120
		value: 'Lowered bevel'.
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example18BasicPieSlice [
	<script: 'self new example18BasicPieSlice'>
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
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example19PieSlice [
	<script: 'self new example19PieSlice'>
	| c |
	c := RSCanvas new.
	"slice"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 30;
		betaAngle: 90;
		segmentSpacing: 5).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example20Donut [
	<script: 'self new example20Donut'>
	| c |
	c := RSCanvas new.
	"donut"
	c addShape: (RSPieSlice new
		withBorder;
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 360).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example21CornerRadii [
	<script: 'self new example21CornerRadii'>
	| c |
	c := RSCanvas new.
	"corner radii"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		innerRadius: 50;
		alphaAngle: 0;
		betaAngle: 45;
		cornerRadii: 20).
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example22BasicPieSlice [
	<script: 'self new example22BasicPieSlice'>
	| c |
	c := RSCanvas new.
	"slice"
	c addShape: (RSPieSlice new
		externalRadius: 100;
		alphaAngle: 30;
		betaAngle: 90).
	c open.
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example23FixedShape [
	<script: 'self new example23FixedShape'>
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
	c open.
]

{ #category : #lines }
TSShapeExamples >> example24Polyline [
	<script: 'self new example24Polyline'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolyline new
		controlPoints: { 5@30. 15@30. 15@20. 25@20. 25@10. 35@10}).
	c open.
]

{ #category : #labels }
TSShapeExamples >> example25LabelWithBorder [
	<script: 'self new example25LabelWithBorder'>
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
	c open.
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example26Polygon [
	<script: 'self new example26Polygon'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolygon new
		points: { 100@10. 40@198. 190@78. 10@78. 160@198 };
		yourself).
	c shapes first translateTo: 0@0.
	c showEncompassingRectangles.
	c shapes first when: RSMouseDragging do: [:evt |
		evt shape translateBy: evt step; signalUpdate].
	c open.
]

{ #category : #lines }
TSShapeExamples >> example27Markers [
	<script: 'self new example27Markers'>
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
	c open.
]

{ #category : #svg }
TSShapeExamples >> example28SVGShape [
	<script: 'self new example28SVGShape'>
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
	c open
]

{ #category : #lines }
TSShapeExamples >> example29PolylineRadius [
	<script: 'self new example29PolylineRadius'>
	| c |
	c := RSCanvas new.
	c addShape: (RSPolyline new
		border: (RSBorder new width: 10);
		cornerRadii: 50;
		controlPoints: { 5@30. 15@30. 15@20. 25@20. 25@10. 35@10} * 50).
	c zoomToFit.
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example30PolygonWithRadius [
	<script: 'self new example30PolygonWithRadius'>
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
	c open.
]
