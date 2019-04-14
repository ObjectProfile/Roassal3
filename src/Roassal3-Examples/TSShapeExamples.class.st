"
I have the basic examples for shapes
"
Class {
	#name : #TSShapeExamples,
	#superclass : #TSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #'box and ellipses' }
TSShapeExamples >> example01BasicBoxes [
	<script: 'self new example01BasicBoxes'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		extent: 100@100;
		yourself).
	c addShape: (TSBox new
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
	c := TSCanvas new.
	c addShape: (TSEllipse new
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
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
	c := TSCanvas new.
	com := TSComposite new.
	com add: (TSBox new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	com add: (TSBox new
		position: 100@100;
		color: (Color red alpha: 0.4);
		extent: 100@100;
		yourself).
		
	c addShape: com.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.4);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
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
	c := TSCanvas new.
	com := TSComposite new.
	com add: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	com add: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
	com position: 100@100.
	
	c addShape: com.	
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example05BasicGroup [
	<script: 'self new example05BasicGroup'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		color: (Color yellow alpha: 0.5);
		position: -50 @ 0;
		extent: 50@100;
		yourself).
	c addShape: (TSBox new
		position: 0 @ 0;
		color: (Color red alpha: 0.5);
		extent: 50@100;
		yourself).
		
		
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 100@100;
		yourself).
	c addShape: (TSEllipse new
		color: (Color gray alpha: 0.5);
		extent: 20@20;
		yourself).
	c open
]

{ #category : #labels }
TSShapeExamples >> example06BasicLabels [
	<script: 'self new example06BasicLabels'>

	| c label |
	c := TSCanvas new.
	1 to: 12 do: [ :m | 
		| angle theta p|
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := TSLabel new
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
	c addShape: (TSEllipse new
		color: nil;
		border: TSBorder new;
		radius: 90).
	c open
	



]

{ #category : #events }
TSShapeExamples >> example07EventsMouseMoveDrag [
	<script: 'self new example07EventsMouseMoveDrag'>

	| c ellipse a b update anim |
	c := TSCanvas new.
	ellipse := TSEllipse new
		radius: 40;
		border: TSBorder new.
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
		when: TSMouseDragging do: [ :evt | update value: evt value: a ];
		when: TSMouseMove do: [ :evt | update value: evt value: b  ].
	c clearBackground: false.
	
	c open.
	
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example08EllipseBorder [
	<script: 'self new example08EllipseBorder'>

	| c y r |
	c := TSCanvas new.
	r := SharedRandom globalGenerator.
	c color: (Color colorFrom: '325A64').
	1 to: 500 do: [ :x|
		y := 255 + (x sin * 255).
		c addShape: (TSEllipse new
			color: Color transparent;
			border: (TSBorder new
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
	c := TSCanvas new.
	c color: Color black.
	e := TSEllipse new
		border: (TSBorder new color: Color white);
		radius: 0.
	c addShape: e.
	prev := 0.
	c when: TSMouseMove do: [ :evt | 
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
	c := TSCanvas new.
	c color: Color white.
	border := TSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c when: TSMouseMove do: [ :evt | 
		circleResolution := b.
		circleResolution isZero ifTrue: [ circleResolution := 1 ].
		angle := Float twoPi / circleResolution.
		a := 175 * evt position x / c extent x.
		b := 200 * evt position y / c extent y.
		c shapes copy do: #remove.
		0 to: circleResolution do: [ :i |
			c addShape: (TSEllipse new 
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
	c := TSCanvas new.
	c color: Color white.
	easing := 0@0.
	boxSize := 50.
	canvasExtent := 500 asPoint.
	maxDist := 0@0 dist: canvasExtent.
	scale := TSScale linear 
		domain: { 0. maxDist}; 
		rangeRound: #(80 0).
	border := TSBorder new.
	c when: TSExtentChangedEvent do: [ 
		c shapes copy do: #remove.
		canvasExtent := c extent.
		maxDist := 0@0 dist: canvasExtent.
		scale := TSScale linear 
			domain: { 0. maxDist}; 
			rangeRound: #(80 0).
		0 to: canvasExtent y/boxSize do: [ :y|
			0 to: canvasExtent x/boxSize do: [ :x| 
				c addShape: (TSBox new 
					color: Color white;
					position: ((x@y)*boxSize) - (canvasExtent/2);
					extent: 10@10;
					border: border )
				] ]
		].
	c when: TSMouseMove do: [ :evt | 
		easing := easing + ((evt position - easing)* 0.1).
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
	c := TSCanvas new.
	c addShape: TSLine new.
	c open.
]

{ #category : #bitmap }
TSShapeExamples >> example14BasicBitmap [
	<script: 'self new example14BasicBitmap'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBitmap new
		form: (self iconNamed: #eyedropper);
		extent: 200@350).
		
	c open
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example15BasicRoundBoxses [
	<script: 'self new example15BasicRoundBoxses'>

	| c |
	c := TSCanvas new.
	c addShape: (TSBox new
		cornerRadius: 5;
		extent: 100@50).
		
	c addShape: (TSBox new
		cornerRadius: (TSCornerRadius new top: 20);
		position: 100@100;
		extent: 100@50;
		border: TSBorder new).
		
	c open
]

{ #category : #lines }
TSShapeExamples >> example16BasicLinePath [
	<script: 'self new example16BasicLinePath'>
	| c b1 b2 translate l arrowWidth arrowHeight middle |
	c := TSCanvas new.
	b1 := TSBox new size: 100@100.
	b2 := TSBox new size: 100@100; color: Color blue; position: 100@100.
	c addShape: b1.
	c addShape: b2.
	
	l := TSSVGPathLine new
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
	b1 when: TSMouseDragging do: translate.
	b2 when: TSMouseDragging do: translate.
	c open
]

{ #category : #border }
TSShapeExamples >> example17Borders [
	<script: 'self new example17Borders'>
	| c border border2 a b ce d |
	c := TSCanvas new.
	border := [ :position :inner :outer :text |
		c addShape: (TSBox new
			color: Color lightGray;
			position: position;
			border: (TSBorder new
				capSquare;
				joinMiter;
				color: inner);"brighter"
			size: 100).
		c addShape: (TSBox new
			color: nil;
			position: position;
			border: (TSBorder new
				capSquare;
				dashArray: #(98 196);
				color: outer);"darker"
			size: 98).
		c addShape: (TSBox new
			color: nil;
			position: position;
			border: (TSBorder new
				capSquare;
				dashArray: #(0 102 102 0 102 0);
				color: outer);"darker"
			size: 102).
		c addShape: (TSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	border2 := [ :position :text |
		
		c addShape: (TSBox new
			color: Color lightGray;
			position: position;
			size: 100).
		c addShape: (TSLine new
			startPoint: position - 50;
			endPoint: position + (50 @ -50);
			color: a).
		c addShape: (TSLine new
			startPoint: position - 50;
			endPoint: position + (-50 @ 50);
			color: a).
		c addShape: (TSLine new
			startPoint: position - 49;
			endPoint: position + (49 @ -49);
			color: b).
		c addShape: (TSLine new
			startPoint: position - 49;
			endPoint: position + (-49 @ 49);
			color: b).
			
		c addShape: (TSLine new
			startPoint: position + (-49@49);
			endPoint: position + 49;
			color: ce ).
		c addShape: (TSLine new
			startPoint: position + (49@ -49) ;
			endPoint: position + (49 @ 49);
			color: ce).
			
		c addShape: (TSLine new
			startPoint: position + (-50@50);
			endPoint: position + 50;
			color: d).
		c addShape: (TSLine new
			startPoint: position + (50@ -50);
			endPoint: position + (50 @ 50);
			color: d).
		c addShape: (TSLabel new
			text: text;
			position: position;
			color: Color black).
		 ].
	
	"line border"
	c addShape: (TSBox new
		color: Color lightGray;
		border: TSBorder new;
		size: 100).
	c addShape: (TSLabel new
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
	RSDraggableView new onElement: c.
	RSZoomableView new onElement: c.
	c open.
]

{ #category : #arcs }
TSShapeExamples >> example18BasicPieSlice [
	<script: 'self new example18BasicPieSlice'>
	| c |
	c := TSCanvas new.
	"empty"
	c addShape: TSPieSlice new.
	"circle"
	c addShape: (TSPieSlice new
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
	c := TSCanvas new.
	"slice"
	c addShape: (TSPieSlice new
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
	c := TSCanvas new.
	"donut"
	c addShape: (TSPieSlice new
		border: TSBorder new;
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
	c := TSCanvas new.
	"corner radii"
	c addShape: (TSPieSlice new
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
	c := TSCanvas new.
	"slice"
	c addShape: (TSPieSlice new
		externalRadius: 100;
		alphaAngle: 30;
		betaAngle: 90).
	c open.
]

{ #category : #'box and ellipses' }
TSShapeExamples >> example23FixedShape [
	<script: 'self new example23FixedShape'>
	| c box |
	c := TSCanvas new.
	box := TSBox new
		extent: 100@100;
		position: 200 asPoint;
		color: Color blue;
		yourself.
	box isFixed: true.
	c addShape: box.
	
	box := TSBox new
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
	c := TSCanvas new.
	c addShape: (TSPolyline new
		controlPoints: { 5@30. 15@30. 15@20. 25@20. 25@10. 35@10}).
	c open.
]

{ #category : #labels }
TSShapeExamples >> example25LabelWithBorder [
	<script: 'self new example25LabelWithBorder'>
	| c |
	c := TSCanvas new.
	c addShape: (TSLabel new
		fontSize: 60;
		fontName: 'Source Sans Pro';
		"fontName: 'Brushcrazy DEMO';"
		border: (TSBorder new 
			color: Color red;
			dashArray: #(4) );
		text: 'Roassal Pharo').
	c open.
]

{ #category : #labels }
TSShapeExamples >> example26Polygon [
	<script: 'self new example26Polygon'>
	| c |
	c := TSCanvas new.
	c addShape: (TSPolygon new
		points: { 100@10. 40@198. 190@78. 10@78. 160@198 };
		yourself).
	c shapes first translateTo: 0@0.
	c showEncompassingRectangles.
	c shapes first when: TSMouseDragging do: [:evt |
		evt shape translateBy: evt step; signalUpdate].
	c open.
]

{ #category : #labels }
TSShapeExamples >> example27Markers [
	<script: 'self new example27Markers'>
	| c arrow axes circle dataLine |
	c := TSCanvas new.
	arrow := TSPolygon new 
		points: { -10@0. 0@ -10. 10@0 };
		color: Color black;
		size: 10.
	circle := TSEllipse new
		radius: 2.5;
		color: Color red.
	axes := TSPolyline new
		controlPoints: { 10@10. 10@90. 90@90 }.
	dataLine := TSPolyline new 
		controlPoints: { 15@80. 29@50. 43@60. 57@30. 71@40. 85@15 }.
	axes markerEnd: (axes markerStart: arrow).
	dataLine marker: circle.
	c addShape: axes.
	c addShape: dataLine.
	c camera zoomToFit: 250@250.
	c open.
]

{ #category : #labels }
TSShapeExamples >> example28SVGShape [
	<script: 'self new example28SVGShape'>
	| c |
	c := TSCanvas new.
	c addShape: (TSSVGPath new
		paint: nil;
		border: TSBorder new;
		svgPath: 'M 100 350 q 150 -300 300 0';
		yourself).
	c addShape: (TSSVGPath new
		paint: nil;
		border: (TSBorder new color: Color red);
		svgPath: 'M 100 350 l 150 -300';
		yourself).
	c addShape: (TSSVGPath new
		paint: nil;
		border: (TSBorder new color: Color red);
		svgPath: 'M 250 50 l 150 300';
		yourself).
	c addShape: (TSSVGPath new
		paint: nil;
		border: (TSBorder new color: Color green);
		svgPath: 'M 175 200 l 150 0';
		yourself).
	c showEncompassingRectangles.
	c zoomToFit.
	c open
]
