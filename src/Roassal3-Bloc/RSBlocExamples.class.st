Class {
	#name : #RSBlocExamples,
	#superclass : #Object,
	#category : #'Roassal3-Bloc'
}

{ #category : #examples }
RSBlocExamples >> example01Boxes [
	<script: 'self new example01Boxes'>
	
	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSBox new
		extent: 100@100;
		yourself).
	c addShape: (RSBox new
		position: 100@100;
		color: Color red;
		extent: 100@100;
		yourself).

	c open.

]

{ #category : #examples }
RSBlocExamples >> example02Ellipse [
	<script: 'self new example02Ellipse'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSEllipse new
			 extent: 100 @ 100;
			 yourself).
	c addShape: (RSEllipse new
			 position: 100 @ 100;
			 color: Color red;
			 extent: 100 @ 100;
			 yourself).

	c open
]

{ #category : #examples }
RSBlocExamples >> example03RotatedBoxes [
	<script: 'self new example03RotatedBoxes'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	1 to: 12 do: [ :m |
		| angle theta p box |
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		box := RSBox new
			size: 90@45;
			yourself.
		angle := angle radiansToDegrees.
		angle := angle + ((angle between: 90 and: 270)
			ifTrue: [ 180 ]
			ifFalse: [ 0 ] ).

		box rotateByDegrees: angle.
		box position: p + ((box baseRectangle width/2) * theta).

		c addShape: box.
		].
	c addShape: (RSEllipse new
		color: nil;
		withBorder;
		radius: 90).

	c open.

]

{ #category : #examples }
RSBlocExamples >> example04RotatedLabels [
	<script: 'self new example04RotatedLabels'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

		1 to: 12 do: [ :m |
			| angle theta p label |
			angle := (m * 360 / 12) degreesToRadians.
			theta := angle cos @ angle sin.
			p := theta * 100.
			label := RSLabel new
				metricsProvider: RSBlocMetricProvider new;
				color: (Color purple alpha: 0.5);
				fontName: 'Arial';
				fontSize: 40;
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

	c open.

]

{ #category : #examples }
RSBlocExamples >> example05Ellipses [
	<script: 'self new example05Ellipses'>

	| c r y |
	c := RSCanvas new.
	c useBlocHost.

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


	c open.

]

{ #category : #examples }
RSBlocExamples >> example06Polyline [
	<script: 'self new example06Polyline'>

	| c |
	c := RSCanvas new.
	c useBlocHost.

	c addShape: (RSPolyline new
		width: 30;
		joinRound;"joinBevel; joinMiter"
		color: Color blue;
		controlPoints: { 50@300. 150@300. 150@200. 250@200. 250@100. 350@100};
		basicTranslateBy: -250 @ -250;
		yourself).


	c open.

]

{ #category : #examples }
RSBlocExamples >> example07MouseMove [
	<script: 'self new example07MouseMove'>

	| c size circles |
	c := RSCanvas new.
	c useBlocHost.

	size := 200.
	c addAll: (circles := #(magenta yellow red cyan) collect: [ :sel | 
	    c add: (RSEllipse new
	        size: size;
	        color: ((Color perform: sel) alpha: 0.4 );
	        yourself).
	    ]).
	c when: RSMouseMove do: [ :evt | 
		| posOffset negOffset |
	    posOffset := (evt position distanceTo: 0@0).
	    negOffset := posOffset negated.
	    circles first position: posOffset @ 0.
	    circles second position: 0 @ posOffset.
	    circles third position: negOffset @ 0.
	    circles fourth position: 0@negOffset.

		c signalUpdate ].
		
	c open.

]

{ #category : #examples }
RSBlocExamples >> example08ZoomToFitWhenExtentChangedEvent [
	<script: 'self new example08ZoomToFitWhenExtentChangedEvent'>

	| canvas |
	canvas := RSCanvas new.
	canvas useBlocHost.

	canvas add: (RSBox new
			 color: Color blue;
			 position: 100 asPoint;
			 size: 5000@3000;
			 yourself).

	canvas when: RSExtentChangedEvent do: [ :event |
		canvas zoomToFit.
		canvas signalUpdate ].
	
	canvas open
]

{ #category : #examples }
RSBlocExamples >> example09HierarchyWithCanvasController [
	<script: 'self new example09HierarchyWithCanvasController'>

	| canvas color shapes |
	canvas := RSCanvas new.
	canvas useBlocHost.

	color := NSScale linear
	    domain: { 1. 200. 400 };
	    range: #(white gray red).

	shapes := Collection withAllSubclasses collect: [ :cls |
	    RSBox new
	        model: cls;
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

	canvas addInteraction: RSCanvasController new.
	canvas open.


]

{ #category : #examples }
RSBlocExamples >> example10BasicComposite [
	<script: 'self new example10BasicComposite open'>

	| c com |
	c := RSCanvas new.
	c useBlocHost.
	
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

{ #category : #examples }
RSBlocExamples >> example11SimpleClassHierarchy [
	<script: 'self new example11SimpleClassHierarchy open'>

	| c methods |
	c := RSCanvas new.

	String withAllSubclassesDo: [ :cls |
		| composite |
		methods := cls methods collect: [ :m | RSBox new color: Color red; size: 5; model: m; yourself ] as: RSGroup.

		RSGridLayout on: methods.
		composite := RSComposite new.
		composite shapes:  methods.
		
		composite color: Color gray.
		composite model: cls.
		composite padding: 30.
		c add: composite ].

	RSLineBuilder line
		canvas: c;
		withVerticalAttachPoint;
		color: Color blue;
		connectFrom: #superclass.

	RSTreeLayout on: c nodes.

	"Making sure we have zooming"
	c @ RSCanvasController.
	
"	c open."
	c useBlocHost.
	^ c 
]

{ #category : #examples }
RSBlocExamples >> example12Donna [
    <script: 'self new example12Donna open'>

    | text canvas horizontal vertical groups count metricsProvider |
    text := 'La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensiero

Sempre un amabile
Leggiadro viso
In pianto o in riso
È menzognero

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier

È sempre misero
Chi a lei s''affida
Chi le confida
Mal cauto il core

Pur mai non sentesi
Felice appieno
Chi su quel seno
Non liba amore

La donna è mobile
Qual piuma al vento
Muta d''accento
E di pensier
E di pensier
E di pensier
'.
    count := 0.
    vertical := RSVerticalLineLayout new gapSize: 0.
    horizontal := RSHorizontalLineLayout new alignLabel.
    metricsProvider := RSBlocMetricProvider new.
    groups := (text splitOn: String cr,String cr) collect: [ :p | 
        | lines |
        lines := p lines collect: [ :line |
            | words |
            words := (line splitOn: ' ') collect: [ :word | 
                RSLabel new
                    text: word;
						  metricsProvider: metricsProvider;
                    ifNotNil: [ :lbl |
                        word = 'donna' 
                            ifTrue: [ lbl bold; fontSize: 14 ].
                        word = 'misero' 
                            ifTrue: [ lbl fontSize: 20; color: 'red' ].
                        word = 'pensier'
                            ifTrue: [ 
                                lbl italic; underline; color: 'blue'; fontSize: (count*4)+10.
                                count := count+1.  ]
                         ];
                    yourself
                ].
            horizontal on: words.
            words asGroup asShape
             ].
        vertical on: lines.
        
        lines asGroup asShape.
        ].

    canvas := RSCanvas new.
    canvas addAll: groups.
    RSHorizontalFlowLayout new
        gapSize: 30;
        on: groups.
    canvas @ RSCanvasController.
	canvas useBlocHost.
    ^ canvas
]

{ #category : #examples }
RSBlocExamples >> example13Cluster [
	<script: 'self new example13Cluster open'>

	| canvas shapes |
	canvas := RSCanvas new.

	canvas addAll: (#(linear sqrt log) collect: [ :scale | 
		| group |
		group := RSGroup new.
		shapes :=  GLMBrickedMorph withAllSubclasses collect: [ :cls |
			RSEllipse new 
				size: 5;
				draggable;
				color: Color red;
				model: cls;
				yourself ].
		group addAll: shapes.
		RSLineBuilder line
			color: Color blue translucent;
			canvas: group;
			shapes: shapes;
			connectFrom: #superclass.
		
		RSNormalizer size
			scale: (NSScale perform: scale);
			from: 1;
			to: 30;
			shapes: shapes;
			normalize: #numberOfMethods.
		RSNormalizer color
			scale: (NSScale perform: scale);
			from: Color blue;
			to: Color red;
			shapes: shapes;
			normalize: #numberOfMethods.
		RSClusterLayout on: shapes.
		RSComposite new
			color: Color veryLightGray translucent;
			model: scale;
			labeled;
			draggable;
			shapes: group;
			yourself.
		]).
	RSGridLayout new gapSize: 20; on: canvas nodes.
	canvas @ RSCanvasController.

	canvas useBlocHost.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example14LabelExtent [
	<script: 'self new example14LabelExtent open'>

	| canvas aString metricsProvider |
	canvas := RSCanvas new.
	canvas useBlocHost.
	metricsProvider := RSBlocMetricProvider new.
	aString := (String loremIpsum: 40) trimBoth.

	10 to: 100 by: 5 do: [ :each |
		| aLabel |
		aLabel := RSLabel new
			fontName: 'Courier';
			fontSize: each;
			text: aString;
			color: Color black;
			metricsProvider: metricsProvider;
			yourself.
		canvas addShape: (RSComposite new 
			color: Color cyan translucent;
			extent: aLabel extent;
			addShape: aLabel;
			yourself).

	].

	RSVerticalLineLayout on: canvas shapes.
	canvas @ RSCanvasController.

	^ canvas

]

{ #category : #examples }
RSBlocExamples >> example15BarPlot [
	<script: 'self new example15BarPlot open'>

	| c p x y |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSBarPlot new x: x y: y.

	c addPlot: p.
	
	c addDecoration: (RSHorizontalTick new 
		doNotUseNiceLabel;
		numberOfTicks: x size - 1;
		asFloat).
	c xlabel: 'X Axis'.
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c ylabel: 'Y Axis'.
	c title: 'Histogram'.

	c canvas useBlocHost.
	^ c
]

{ #category : #examples }
RSBlocExamples >> example16Histogram [
	<script: 'self new example16Histogram open'>

	| x y canvas shapes |
	"Do we need a binning strat?"
	x := 1 to: 100.
	canvas := RSCanvas new.
	
	shapes := { 
		RSDefaultBinning new.
		RSRiceBinning new.
		RSSturgesBinning new.
	 } collect: [ :strat | | g c plot |
		g := RSGroup new.
		c := RSChart new.
		c container: g.
		y := x collect: [ :v | strat computeSizeFor: (Array new: v) ].
		plot := RSLinePlot new x: x y: y.
		c addPlot: plot.
		c addDecoration: RSVerticalTick new doNotUseNiceLabel.
		c addDecoration: RSHorizontalTick new.
		c title: strat class name. 
		c build.
		g asShapeFor: strat.
		].
	canvas addAll: shapes.
	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.

	canvas useBlocHost.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example17MouseMoveEllipse [
	<script: 'self new example17MouseMoveEllipse open'>
	| c border circleResolution angle a b radius p |
	c := RSCanvas new.
	c useBlocHost.
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

{ #category : #examples }
RSBlocExamples >> example18MouseMoveLine [
	<script: 'self new example18MouseMoveLine open'>
 	| c rotate size angle |
	c := RSCanvas new.
	c useBlocHost.
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

{ #category : #examples }
RSBlocExamples >> example19Animation [
	<script: 'self new example19Animation open'>
	| c b |
	c := RSCanvas new.
	c useBlocHost.
	b := RSBox new
		extent: 100@100;
		withBorder.
	c addShape: b.
	
	c newAnimation
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (200@0)};
		on: b set: #position:.
	
	c 
		when:RSMouseClick
		do: [ c animations do: #pause ];
		when: RSMouseDoubleClick 
		do: [ c animations do: #continue ].
	^ c
]

{ #category : #examples }
RSBlocExamples >> example20BoxWindmill [
	<script: 'self new example20BoxWindmill open'>
	| canvas shapes extent points frameCount border |
	canvas := RSCanvas new.
	canvas useBlocHost.
	canvas color: Color black.
	extent := 1920@1080.
	points := (0 to: extent x by: 50) flatCollect: [ :x |
		(0 to: extent y by: 50) collect: [ :y | (x@y)- (extent/2) ] ].
	border := RSBorder new
		color: (Color gray alpha: 0.5);
		yourself.
		
	shapes := points collect: [ :p | 
		RSBox new
			extent: 140@40;
			model: p;
			color: Color white;
			border: border;
			yourself  ].
	canvas addAll: shapes.
	frameCount := 0.
	canvas newAnimation repeat;
		onStepDo: [ :t |
			shapes do: [ :s | 
				s matrix 
					loadIdentity;
					translateBy: s model;
					rotateByRadians: (s model x + s model y + frameCount) degreesToRadians * 1.95  ].
			frameCount := frameCount + 1. ].
	canvas @ RSGraphCanvasMonitor.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example21BoxesLineCircles [
	<script: 'self new example21BoxesLineCircles open'>
	| c extent r shapes position alpha update updateLine lineX line |
	c := RSCanvas new.
	c useBlocHost.
	r := Random new.
	shapes := (1 to: 12) collect: [ :i | 
		RSBox new
			model: r next;
			noPaint;
			border: (RSBorder new width: 4; color: Color black);
			yourself].
	c addAll: shapes.
	RSNormalizer size
		from: 30;
		to: 100;
		shapes: shapes;
		normalize: #yourself.
	lineX := 0.
	line := RSLine new
		color: Color red;
		width: 8;
		yourself;
		startPoint: 1@0;
		endPoint: 0@0;
		yourself.
	c add: line. 
	position := nil.
	updateLine := [
		line 
			startPoint: lineX@position from y;
			endPoint: lineX@position to y. ].
	c when: RSMouseMove do: [ :ev | 
		lineX := ev position x.
		updateLine value ].
	update := [ 
		extent := c extent.
		position := NSScale linear
			range: { extent / -2. extent /2 }.
		updateLine value.
		shapes do: [ :e | e translateTo: (position scale: r next@ r next) ].
	].
	update value.
	c when: RSExtentChangedEvent do: update.
	
	"shadow"
	alpha := NSScale linear domain: #(1 4); range: #(0.4 0.05).
	shapes do: [ :e | | ant |
		ant := e.
		1 to: 4 do: [:i | | s |
			s := RSBox new 
				noPaint;
				position: e position;
				extent: e extent;
				border: (RSBorder new
					width: 6;
					color: (e border color alpha: (alpha scale: i)));
				yourself.
			ant when: RSPositionChangedEvent do: [ :evt | 
				s translateTo: evt oldPosition ].
			ant := s.
			c add: s
			] ] .
	c newAnimation repeat; 
		onStepDo: [ :t | 
			| round empty |
			round := RSCornerRadius new radius: 100.
			empty := RSCornerRadius new.
			shapes do: [ :shape |
				| delta newX |
				delta := shape propertyAt: #delta ifAbsentPut: [ 5 ].
				newX := shape position x + delta.
				(newX 
					between: position from x 
					and: position to x) ifFalse: [ 
					delta := delta negated.
					newX := shape position x + delta.
					 ].
				shape translateTo: newX@shape position y.
				shape propertyAt: #delta put: delta
				].
			c nodes copy do: [ :shape | | corner |
				corner := shape position x > lineX 
					ifTrue: [ round ]
					ifFalse: [ empty ].
				shape cornerRadius: corner.
				 ].
		c signalUpdate
	].
	^ c
	
]

{ #category : #examples }
RSBlocExamples >> example22ElasticEllipses [
	<script: 'self new example22ElasticEllipses open'>
	| canvas random mouseClick |
	canvas := RSCanvas new.
	canvas useBlocHost.
	random := Random new.
	
	mouseClick := [ | c1 c2 color  |
		canvas nodes copy do: #remove.
		c1 := Color r: random next g: random next b: random next.
		c2 := Color r: random next g: random next b: random next.
		color := NSScale linear range: { c1. c2 }.
		1 to: 10000 do: [ :i | | shape radius ang overlapped |
			shape := RSEllipse new.
			shape radius: random next * 30 + 2.
			radius := random next * 250.
			ang := random next * Float pi * 2.
			shape position: radius * (ang cos @ ang sin).
			overlapped := canvas nodes anySatisfy: [ :other |
				(other position distanceTo: shape position) < 
					((shape radius + other radius) * 1.4)  ].
			overlapped ifFalse: [ 
				canvas add: shape.
				shape propertyAt: #radius put: shape radius.
				shape color: (color scale: (shape position distanceTo: 0@0)/250 ) ].
		].
		canvas newAnimation
			easing: RSEasing elasticOut;
			onStepDo: [ :t |
				canvas nodes do: [ :shape | | scale |
					scale := NSScale linear range: { 1. shape propertyAt: #radius }.
					shape radius: (scale scale: t)
					 ].
				canvas signalUpdate.
				]
	].
	mouseClick value.
	
	canvas 
		when: RSExtentChangedEvent do: [ :evt | canvas zoomToFit ];
		when: RSMouseClick do: mouseClick.
	^ canvas

]

{ #category : #examples }
RSBlocExamples >> example23Flor [
	<script: 'self new example23Flor open'>
	| c frame angleSp alphaS hueS dia1 dia2 |
	c := RSCanvas new.
	c useBlocHost.
	frame := 0.
	angleSp := 0.
	hueS := NSScale linear domain: #(50 200); range: #(250 360).
	alphaS := NSScale linear domain: #(50 200); range: #(0.3 1).
	dia1 := NSScale linear domain: #(50 180); range: #(90 1).
	dia2 := NSScale linear domain: #(-1 1); range: #(5 20).
	(0 to: 350 by: 60) do: [ :i | 
		(50 to: 170 by: 10) do: [ :m |  | color |
			color := Color 
				h: (hueS scale: m)
				s: 0.8 
				v: 1 
				alpha: (alphaS scale: m).
			c addShape: (RSEllipse new
				color: color;
				model: i -> m;
				yourself).
			 ].
		 ].
	c newAnimation repeat onStepDo: [ :t | 
		frame := frame + 1.
		angleSp := frame / 250.0 * (Float pi * 2).
		c shapes do: [ :s | 
			| angle i m dist diameter |
			i := s model key.
			m := s model value.
			angle := (i + (angleSp sin * m)) degreesToRadians.
			s position: m * (angle cos @ angle sin).
			dist := s position distanceTo: 0@0.
			diameter := dia2 scale: (dia1 scale: dist) sin.
			s extent: diameter asPoint.
	 	].
		c signalUpdate.
		].
	c when: RSExtentChangedEvent do: [ 
		c camera zoomToFit: c extent extent: 500 asPoint ].
	^ c
	
]

{ #category : #examples }
RSBlocExamples >> example24AnimationLinesInComposite [
	<script: 'self new example24AnimationLinesInComposite open'>
	| canvas frame radius hueOffset angleSp shapes soffset size mult shape |
	canvas := RSCanvas new.
	canvas useBlocHost.
	canvas color: Color black.
	frame := 0.
	radius := 200.
	hueOffset := 0.
	angleSp := 0.
	"<globals>"
	soffset := nil. size := nil. mult := 0.
	"</globals>"
	shape := [ :array |
		array collect: [ :m | | com ang a line |
			com := RSComposite new.
			com model: m + soffset.
			ang := m degreesToRadians.
			a := Float halfPi + ang.
			com propertyAt: #offset put: a * size.
			line := RSLine new
				width: 1.5;
				yourself.
				
			com add: line.
			com translateTo: ang cos @ ang sin * radius * mult.
			com matrix rotateByRadians: a.
			com ] ].
	
	soffset := 0. size := 12. mult := 1.
	shapes := shape value: (0 to: 359 by: 12).
	canvas addAll: shapes.
	
	soffset := 180. size := 8. mult := 0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.
	
	soffset := 120. size := 4. mult := 0.5@0.75.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes."
	
	"soffset := 240. size := 4. mult := 0.75@0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.
	shapes := canvas nodes.
	canvas addShape: (RSLabel new 
		text: 'Roassal';
		fontSize: 30;
		border: (RSBorder new color: Color white);
		color: nil).
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame + 1. 
		angleSp := frame / 300 * Float twoPi.
		hueOffset := hueOffset + 1.
		shapes do: [ :s | | pos line |
			pos := (angleSp negated + (s propertyAt: #offset)) cos * 30.
			line := s shapes first.
			line color: (Color h: s model + hueOffset s: 0.6 v: 1).
			line endPoint: 0@ pos ].
		 ].
	canvas when: RSExtentChangedEvent do: [ canvas camera zoomToFit: canvas extent extent: 500 asPoint ].
	^ canvas
]
