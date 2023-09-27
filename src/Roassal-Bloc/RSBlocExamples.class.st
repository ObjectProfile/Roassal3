Class {
	#name : #RSBlocExamples,
	#superclass : #Object,
	#category : #'Roassal-Bloc-Examples'
}

{ #category : #accessing }
RSBlocExamples class >> allExampleSelectors [

	^ (self selectors select: [ :each | each beginsWith: 'example' ])
		  sorted
]

{ #category : #examples }
RSBlocExamples >> example01Boxes [
	<script: 'self new example01Boxes open'>
	
	| c |
	c := self newCanvas.

	c addShape: (RSBox new
		color: Color blue translucent;
		extent: 200 asPoint;
		yourself).
	c addShape: (RSBox new
		position: 100 asPoint;
		color: Color red translucent;
		extent: 200 asPoint;
		yourself).

	^ c
]

{ #category : #examples }
RSBlocExamples >> example02EllipseAndCircle [
	<script: 'self new example02EllipseAndCircle open'>

	| c |
	c := self newCanvas.

	c addShape: (RSEllipse new
			 color: Color green translucent;
			 extent: 100 asPoint;
			 position: -25 asPoint;
			 yourself).
	c addShape: (RSCircle new
			 color: Color red translucent;
			 extent: 100 asPoint;
			 position: 25 asPoint;
			 yourself).

	^ c
]

{ #category : #examples }
RSBlocExamples >> example03RotatedBoxes [
	<script: 'self new example03RotatedBoxes open'>

	| c |
	c := self newCanvas.

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

	^ c

]

{ #category : #examples }
RSBlocExamples >> example04RotatedLabels [
	<script: 'self new example04RotatedLabels open'>

	| c metricsProvider |
	c := self newCanvas.
	metricsProvider := RSBlocMetricProvider new.
	1 to: 12 do: [ :m |
		| angle theta p label |
		angle := (m * 360 / 12) degreesToRadians.
		theta := angle cos @ angle sin.
		p := theta * 100.
		label := RSLabel new
			metricsProvider: metricsProvider;
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

	^ c
]

{ #category : #examples }
RSBlocExamples >> example05Ellipses [
	<script: 'self new example05Ellipses open'>

	| c r y |
	c := self newCanvas.

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
	^ c
]

{ #category : #examples }
RSBlocExamples >> example06Polyline [
	<script: 'self new example06Polyline open'>

	| c |
	c := self newCanvas.
	c addShape: (RSPolyline new
		width: 30;
		joinRound;"joinBevel; joinMiter"
		color: Color blue;
		paint: Color green translucent;
		controlPoints: { 50@300. 150@300. 150@200. 250@200. 250@100. 350@100};
		basicTranslateBy: -250 @ -250;
		yourself).
	^ c

]

{ #category : #examples }
RSBlocExamples >> example07MouseMove [ 
	< script:	'self new example07MouseMove open' >

	| canvas size circles box |
	canvas := self newCanvas.
	box := RSBox new size: 200.
	canvas add: box.
	size := 200.
	canvas addAll: (circles := #( magenta yellow red cyan ) collect: [ :sel | 
			            canvas add: (RSEllipse new
					             size: size;
					             color: ((Color perform: sel) alpha: 0.4);
					             yourself) ]).
	box 
		when: RSMouseEnter 
		do: [ :evt | box color: Color random. canvas signalUpdate ]
		for: self.
	canvas
		when: RSMouseMove
		do: [ :evt | 
			| posOffset negOffset |
			posOffset := evt position distanceTo: 0 @ 0.
			negOffset := posOffset negated.
			circles first position: posOffset @ 0.
			circles second position: 0 @ posOffset.
			circles third position: negOffset @ 0.
			circles fourth position: 0 @ negOffset.
			canvas signalUpdate ]
		for: self.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example08ZoomToFitWhenExtentChangedEvent [
<script: 'self new example08ZoomToFitWhenExtentChangedEvent open' >
	| canvas |
	canvas := self newCanvas.

	canvas add: (RSBox new
			 color: Color blue;
			 position: 100 asPoint;
			 size: 5000 @ 3000;
			 yourself).

	canvas
		when: RSExtentChangedEvent
		do: [ :event |
			canvas zoomToFit.
			canvas signalUpdate ]
		for: self.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example09HierarchyWithCanvasController [
	<script: 'self new example09HierarchyWithCanvasController open'>

	| canvas color shapes |
	canvas := self newCanvas.

	color := NSScale linear
	    domain: { 1. 200. 400 };
	    range: #(white gray red).

	shapes := Collection withAllSubclasses collect: [ :cls |
	    RSBox new
	        model: cls;
	        color:( color scale: cls numberOfMethods );
			  draggable;
	        size: cls linesOfCode sqrt + 10;
				borderColor: Color black;
	        yourself
	     ].
	canvas addAll: shapes.

	RSLineBuilder orthoVertical
	    withVerticalAttachPoint;
	    shapes: shapes;
	    connectFrom: #superclass.

	RSTreeLayout on: shapes.

	canvas addInteraction: RSCanvasController new.
	^ canvas


]

{ #category : #examples }
RSBlocExamples >> example10BasicComposite [
	<script: 'self new example10BasicComposite open'>

	| c com |
	c := self newCanvas.
	
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
	c := self newCanvas.

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

    canvas := self newCanvas.
    canvas addAll: groups.
    RSHorizontalFlowLayout new
        gapSize: 30;
        on: groups.
    canvas @ RSCanvasController.
    ^ canvas
]

{ #category : #examples }
RSBlocExamples >> example13Cluster [
	<script: 'self new example13Cluster open'>

	| canvas shapes |
	canvas := self newCanvas.

	canvas addAll: (#(linear sqrt) collect: [ :scale | 
		| group |
		group := RSGroup new.
		shapes :=  Collection withAllSubclasses collect: [ :cls |
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
		RSClusterTreeLayout on: shapes.
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

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example14LabelExtent [
	<script: 'self new example14LabelExtent open'>

	| canvas aString metricsProvider |
	canvas := self newCanvas.
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
	c := RSCompositeChart new.
	p := RSBarPlot new x: x y: y.

	c add: p.
	
	c horizontalTick
		doNotUseNiceLabel;
		numberOfTicks: x size - 1;
		asFloat.
	c xlabel: 'X Axis'.
	c verticalTick
		numberOfTicks: 10;
		asFloat.
	c ylabel: 'Y Axis'.
	c title: 'Histogram'.
	c build.
	c canvas useBlocHost.
	^ c canvas
]

{ #category : #examples }
RSBlocExamples >> example16Histogram [
	<script: 'self new example16Histogram open'>

	| x y canvas shapes |
	"Do we need a binning strat?"
	x := 1 to: 100.
	canvas := self newCanvas.
	
	shapes := { 
		RSDefaultBinning new.
		RSRiceBinning new.
		RSSturgesBinning new.
	 } collect: [ :strat | | g c plot |
		g := RSGroup new.
		c := RSCompositeChart new.
		c container: g.
		y := x collect: [ :v | strat computeNumberOfBinsFor: (Array new: v) ].
		plot := RSLinePlot new x: x y: y.
		c add: plot.
		c verticalTick doNotUseNiceLabel.
		c title: strat class name. 
		c build.
		g asShapeFor: strat.
		].
	canvas addAll: shapes.
	RSGridLayout on: canvas shapes.
	canvas @ RSCanvasController.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example17MouseMoveEllipse [ 
	<script: 'self new example17MouseMoveEllipse open' > 
	
	| c border circleResolution angle a b radius p |
	c := self newCanvas.
"	c useMorphicHost."
	border := RSBorder new color: (Color colorFrom: '002800').
	b := 1.
	radius := 200.
	c
		when: RSMouseMove
		do: [ :evt | 
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
						 extent: (angle * i) cos @ (angle * i) sin * radius + a) ].

			c signalUpdate ]
		for: self.
	^ c
]

{ #category : #examples }
RSBlocExamples >> example18MouseMoveLine [
	<script: 'self new example18MouseMoveLine open'>
 	| c rotate size angle |
	c := self newCanvas.
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
	] for: self.
	
	^ c
]

{ #category : #examples }
RSBlocExamples >> example19Animation [
	<script: 'self new example19Animation open'>

	| canvas label continueMessage pauseMessage |
	continueMessage := 'Click to pause'.
	pauseMessage := 'Double-click to continue'.

	canvas := self newCanvas.

	label := RSLabel new
		text: continueMessage;
		fontSize: 40;
		withBorder.
	canvas addShape: label.
	
	canvas newAnimation
		repeat;
		ramp: { 
		 	0 -> (0@0).
			0.25 -> (200@180).
			0.75 -> (-200@ -80).
			1 -> (0@0)};
		on: label set: #position:.
	
	canvas 
		when: RSMouseClick
		do: [
			canvas animations do: #pause.
			label
				text: pauseMessage.
			canvas signalUpdate ]
		for: self;
		when: RSMouseDoubleClick
		do: [
			canvas animations do: #continue.
			label text: continueMessage.
			canvas signalUpdate ]
		for: self.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example20BoxWindmill [
	<script: 'self new example20BoxWindmill open'>
	| canvas shapes extent points frameCount border |
	canvas := self newCanvas.
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
			frameCount := frameCount + 1.
			canvas signalUpdate ].

	canvas @ RSSimpleCanvasMonitorInteraction.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example21BoxesLineCircles [
	<script: 'self new example21BoxesLineCircles open'>

	| canvas extent r movingShapes position alpha update updateLine lineX verticalLine |
	canvas := self newCanvas.
	r := Random new.
	movingShapes := (1 to: 12) collect: [ :i | 
		RSBox new
			model: r next;
			noPaint;
			border: (RSBorder new width: 4; color: Color black; yourself);
			yourself].
	canvas addAll: movingShapes.
	RSNormalizer size
		from: 30;
		to: 100;
		shapes: movingShapes;
		normalize: #yourself.

	"Vertical line"
	lineX := 0.
	verticalLine := RSLine new
		color: Color red;
		width: 8;
		yourself;
		startPoint: 1@0;
		endPoint: 0@0;
		yourself.
	canvas add: verticalLine. 
	position := nil.
	updateLine := [
		verticalLine 
			startPoint: lineX@position from y;
			endPoint: lineX@position to y.
			
			Time now trace.
			#updateLine traceCr.

			"TODO"
			canvas signalUpdate.
			 ].
	canvas when: RSMouseMove do: [ :evt | 
		lineX := evt position x.
		updateLine value ] for: self.
	update := [ 
		extent := canvas extent.
		position := NSScale linear
			range: { extent / -2. extent /2 }.
		updateLine value.
		movingShapes do: [ :each |
			each translateTo: (position scale: r next @ r next) ].
	].
	update value.
	canvas when: RSExtentChangedEvent do: update for: self.
	
	"Shadows"
	alpha := NSScale linear domain: #(1 4); range: #(0.4 0.05); yourself.
	movingShapes do: [ :each | | ant |
		ant := each.
		1 to: 4 do: [ :i | | s |
			s := RSBox new 
				noPaint;
				position: each position;
				extent: each extent;
				border: (RSBorder new
					width: 6;
					color: (each border color alpha: (alpha scale: i));
					yourself);
				yourself.
			ant
				when: RSPositionChangedEvent
				do: [ :evt | 
					s translateTo: evt oldPosition ]
				for: canvas.
			ant := s.
			canvas add: s ] ].

	"Move horizontally the shapes"
	canvas newAnimation repeat; onStepDo: [ :t | 
		| round empty |
		round := RSCornerRadius new radius: 100; yourself.
		empty := RSCornerRadius new.

		movingShapes do: [ :each |
			| delta newX |
			delta := each propertyAt: #delta ifAbsentPut: [ 5 ].
			newX := each position x + delta.
			(newX between: position from x and: position to x) 
				ifFalse: [ 
					delta := delta negated.
					newX := each position x + delta ].
			each translateTo: newX@each position y.
			each propertyAt: #delta put: delta ].

		canvas nodes copy do: [ :each | | corner |
			corner := each position x > lineX 
				ifTrue: [ round ]
				ifFalse: [ empty ].
			each cornerRadius: corner ].

		canvas signalUpdate ].

	^ canvas

]

{ #category : #examples }
RSBlocExamples >> example22AnimationOnRightClick [

	         <script: 'self new example22AnimationOnRightClick open'>
	         | canvas random mouseClick |
	         canvas := self newCanvas.
	         random := Random new.

	         mouseClick := [
	                       | c1 c2 color |
	                       canvas nodes copy do: #remove.
	                       c1 := Color
		                             r: random next
		                             g: random next
		                             b: random next.
	                       c2 := Color
		                             r: random next
		                             g: random next
		                             b: random next.
	                       color := NSScale linear range: {
			                                c1.
			                                c2 }.
	                       1 to: 10000 do: [ :i |
		                       | shape radius ang overlapped |
		                       shape := RSEllipse new.
		                       shape radius: random next * 30 + 2.
		                       radius := random next * 250.
		                       ang := random next * Float pi * 2.
		                       shape position: radius * (ang cos @ ang sin).
		                       overlapped := canvas nodes anySatisfy: [
			                                     :other |
			                                     (other position distanceTo:
				                                      shape position)
			                                     <
			                                     (shape radius + other radius
			                                      * 1.4) ].
		                       overlapped ifFalse: [
			                       canvas add: shape.
			                       shape propertyAt: #radius put: shape radius.
			                       shape color:
				                       (color scale:
					                        (shape position distanceTo: 0 @ 0) / 250) ] ].
	                       canvas newAnimation
		                       easing: RSEasingInterpolator elasticOut;
		                       onStepDo: [ :t |
			                       canvas nodes do: [ :shape |
					                       | scale |
					                       scale := NSScale linear range: {
								                                1.
								                                (shape propertyAt: #radius) }.
					                       shape radius: (scale scale: t) ].
			                       canvas signalUpdate ] ].
	         mouseClick value.

	         canvas
		         when: RSExtentChangedEvent
		         do: [ :evt | canvas zoomToFit ]
		         for: self;
		         when: RSMouseRightClick do: mouseClick for: self.
	         ^ canvas
]

{ #category : #examples }
RSBlocExamples >> example23Flor [
	<script: 'self new example23Flor open'>

	| canvas frame angleSp alphaS hueS dia1 dia2 |
	canvas := self newCanvas.
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
			canvas addShape: (RSEllipse new
				color: color;
				model: i -> m;
				yourself).
			 ].
		 ].
	canvas newAnimation repeat onStepDo: [ :t | 
		frame := frame + 1.
		angleSp := frame / 250.0 * (Float pi * 2).
		canvas shapes do: [ :s | 
			| angle i m dist diameter |
			i := s model key.
			m := s model value.
			angle := (i + (angleSp sin * m)) degreesToRadians.
			s position: m * (angle cos @ angle sin).
			dist := s position distanceTo: 0@0.
			diameter := dia2 scale: (dia1 scale: dist) sin.
			s extent: diameter asPoint.
	 	].
		canvas signalUpdate.
		].
	canvas
		when: RSExtentChangedEvent
		do: [ 
			canvas camera zoomToFit: canvas extent extent: 500 asPoint ]
		for: self.
	^ canvas
	
]

{ #category : #examples }
RSBlocExamples >> example24AnimationLinesInComposite [
	<script: 'self new example24AnimationLinesInComposite open'>

	| canvas frame radius hueOffset angleSp shapes soffset size mult shape |
	canvas := self newCanvas.
	canvas color: Color black.
	frame := 0.
	radius := 200.
	hueOffset := 0.
	angleSp := 0.
	"<globals>"
	soffset := nil.
	size := nil.
	mult := 0.
	"</globals>"
	shape := [ :array |
	         array collect: [ :m |
		         | com ang a line |
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

	soffset := 0.
	size := 12.
	mult := 1.
	shapes := shape value: (0 to: 359 by: 12).
	canvas addAll: shapes.

	soffset := 180.
	size := 8.
	mult := 0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.

	soffset := 120.
	size := 4.
	mult := 0.5 @ 0.75.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes. "
	
	"
	soffset := 240.
	size := 4.
	mult := 0.75 @ 0.5.
	shapes := shape value: (0 to: 359 by: 5).
	canvas addAll: shapes.
	shapes := canvas nodes.
	canvas addShape: (RSLabel new
			 position: 0 @ -15;
			 text: 'Roassal';
			 fontSize: 30;
			 color: Color white).
	canvas addShape: (RSLabel new
			 position: 0 @ 15;
			 text: 'on Bloc';
			 fontSize: 30;
			 color: Color white).
	canvas newAnimation repeat onStepDo: [ :t |
		frame := frame + 1.
		angleSp := frame / 300 * Float twoPi.
		hueOffset := hueOffset + 1.
		shapes do: [ :s |
			| pos line |
			pos := (angleSp negated + (s propertyAt: #offset)) cos * 30.
			line := s shapes first.
			line color: (Color h: s model + hueOffset s: 0.6 v: 1).
			line endPoint: 0 @ pos ].
		canvas signalUpdate ].
	canvas
		when: RSExtentChangedEvent
		do: [ canvas camera zoomToFit: canvas extent extent: 500 asPoint ]
		for: self.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example25Bitmap [
	<script: 'self new example25Bitmap open'>

	| canvas shapes iconAssociations |
	iconAssociations := Smalltalk ui icons icons associations sorted: [:a :b | a key < b key ].
	canvas := self newCanvas.

	shapes := iconAssociations collect: [ :each |
		RSBitmap new
			form: each value;
			model: each;
			rotateByDegrees: 45;
			popupText: #key;
			when: RSMouseClick
				do: [ :evt |
					Clipboard clipboardText: evt shape model key.
					self inform: 'Copied icon name' ]
				for: canvas ].

	canvas addAll: shapes.
	RSGridLayout on: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example26Bezier [
	<script: 'self new example26Bezier open'>

	| canvas |
	canvas := self newCanvas.
	
	canvas addShape: (RSBezier new
		color: Color red;
		paint: Color blue translucent;
		controlPoints:
			{(0 @ 0).
			(50 @ 50).
			(150 @ 0).
			(150 @ 50)};
		yourself).
	
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example27BezierAttachPoints [
	<script: 'self new example27BezierAttachPoints open'>

	| canvas box1 box2 line |
	canvas := self newCanvas.
	
	canvas addShape: (RSBezier new
		color: Color red;
		controlPoints:
			{(0 @ 0).
			(100 @ 100).
			(200 @ 0).
			(300 @ 100)};
		yourself).
	box1 := RSBox new 
		draggable; 
		size: 100; 
		color: Color blue;
		translateTo: 100@ -200; 
		yourself.
	box2 := RSBox new
		draggable;
		size: 100;
		yourself.
	canvas
		add: box1;
		add: box2.
		
	line := RSBezier new
		withVerticalAttachPoint;
		from: box1;
		controlPointsController: RSVerticalCPAPController new;
		to: box2;
		yourself.
	canvas add: line.
	
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example28BezierWithAnimation [
	<script: 'self new example28BezierWithAnimation open'>

	| canvas size theta sc borderWhite cpController |
	canvas := self newCanvas.

	size := 50.
	theta := 0.
	canvas color: Color black.
	sc := NSScale linear domain: #(-1 1); range: #(0 80).
	cpController := RSBlockCPController new
		block: [ :line | 
			| x1 |
			x1 := sc scale: (theta + (line model * 5)) sin.
			Array
				with: x1 @ 0
				with: 100 @ -100
				with: 100 @ 50
				with: 200 @ -120 ];
		yourself.
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	canvas addAll: ((1 to: size) collectWithIndex: [ :m :index | 
		| com offset edge |
		com := RSComposite new.
		offset := Float twoPi / size * index.
		com matrix rotateByRadians: offset.
		edge := RSBezier new
			color: Color white;
			model: offset;
			width: 2;
			controlPointsController: cpController;
			paint: (Color h: 360 / size * index s: 1 v: 1 alpha: 0.5);
			yourself.
		edge 
			markerEnd: ((RSShapeFactory triangle
					extent: 10@20;
					color: edge paint;
					border: borderWhite;
					yourself) asMarker 
				offset: -10;
				yourself).
		com add: edge.
		com ]).
	canvas newAnimation repeat onStepDo: [ :t | 
		theta := theta + 0.0523.
		canvas nodes do: [ :com | com shapes first update ].
		canvas signalUpdate ].
	canvas
		when: RSExtentChangedEvent
		do: [ canvas camera zoomToFit: canvas extent extent: 500 @ 500 ]
		for: canvas.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example29Polygon [
	<script: 'self new example29Polygon open'>

	| canvas |
	canvas := self newCanvas.

	canvas add: (RSBox new
			 position: 0 @ 0;
			 size: 200;
			 color: Color green muchDarker;
			 yourself).

	canvas add: (RSPolygon new
			 points: { 
					 (100 @ 0).
					 (200 @ 100).
					 (160 @ 100).
					 (160 @ 250).
					 (40 @ 250).
					 (40 @ 100).
					 (0 @ 100) };
			 cornerRadii: 7;
			 position: 0 @ 0;
			 color: Color blue;
			 yourself).

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example30EllipseWithLinearGradient [
	<script: 'self new example30EllipseWithLinearGradient open'>

	| canvas gradient |
	canvas := self newCanvas.

	gradient := (LinearGradientPaint fromArray:
			{0 -> Color red muchDarker.
			1 -> Color red muchLighter })
		start: -100 asPoint;
		stop: 100 asPoint;
		yourself.
		
	canvas add: (RSEllipse new "RSShapeFactory square"
			 position: 0 @ 0;
			 size: 200;
			 paint: gradient;
			 yourself).

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example31PolygonWithLinearGradient [
	<script: 'self new example31PolygonWithLinearGradient open'>

	| canvas polygon labels paint |
	canvas := self newCanvas.

	paint := (LinearGradientPaint fromArray:
			{0 -> 'CC2A49'.
			0.25 -> 'F99E4C'.
			0.50 -> 'F36F38'.
			0.75 -> 'EF4648'.
			1 -> '582841'})
		start: -125 asPoint;
		stop: 125 asPoint;
		yourself.
	
	polygon := RSPolygon new
		points: 
			{100@0. 200@100. 
			160@100. 160@ 250.
			40@ 250. 40@100.
			0@ 100
			};
		cornerRadii: 7.77;
		paint: paint;
		yourself.
	canvas add: polygon.
	
	labels := #('Keep' 'calm' 'and' 'roassal' 'on') collectWithIndex: [ :t :index |
		RSLabel new
			fontSize: (index = 3 ifTrue: 10 ifFalse: [ 20 ]);
			bold;
			color: Color white;
			text: t asUppercase;
			yourself
		].
	canvas addAll: labels.

	RSVerticalLineLayout new alignCenter on: labels.

	labels asGroup translateBy: 50@50.
	canvas @ RSCanvasController.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example32FixedShape [
	<script: 'self new example32FixedShape open'>

	| canvas box |
	canvas := self newCanvas.
	
	box := RSBox new
		extent: 100 asPoint;
		position: 100 asPoint;
		color: Color blue;
		isFixed: true;
		yourself.
	canvas addShape: box.
	
	box := RSBox new
		extent: 100 asPoint;
		yourself.
	canvas addShape: box.

	canvas camera scale: 2.

	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example33AnimatedLayout [
	<script: 'self new example33AnimatedLayout open'>

	| canvas objects layout update labels shapes color |
	canvas := self newCanvas.

	objects := 1 to: 100.
	
	color := RSColorPalette sequential ylorrd9.
	shapes := objects collect: [ :m |
		RSBox new
			border: RSBorder new;
			color: (color scale: m);
			size: 10;
			model: m;
		yourself ].
	canvas addAll: shapes.
	RSLineBuilder line 
		canvas: canvas;
		objects: objects;
		connectFrom: [ :value | value //2 ] to: #yourself.
	layout := RSLayoutBuilder new.
	update := [ :sel | 
		layout perform: sel asSymbol.
		layout on: shapes.
		 ].
	update value: #tree.
	RSZoomToFitCanvasInteraction new animatedZoomToFit: canvas.

	labels := #('grid' 'tree' 'cell' 'horizontalTree' 'cluster' 'circle' 'radial' 'sugiyama').
	labels := labels collect: [ :sel |
		RSLabel new
			isFixed: true;
			text: sel capitalized;
			when: RSMouseClick
				do: [ :evt | | pos1 pos2 |
					pos1 := shapes collect: #position.
					update value: sel.
					pos2 := shapes collect: #position.
					canvas newAnimation onStepDo: [ :t |
						shapes doWithIndex: [ :e :i |
							e translateTo: ((pos1 at: i) 
								interpolateTo: (pos2 at: i) at: t) ].
						canvas zoomToFit; signalUpdate ] ]
				for: canvas ].
	canvas addAll: labels.
	RSHorizontalLineLayout on: labels.

	^ canvas

]

{ #category : #examples }
RSBlocExamples >> example34RSLocateWithMouseEvents [
	<script: 'self new example34RSLocateWithMouseEvents open'>

	| canvas newBox updateText fixedElement movableElement buttons labeled locate label grad1 grad2 color |
	canvas := self newCanvas.
	locate := RSLocation new.
	color := RSColorPalette qualitative paired3.
	newBox := [ :m | RSBox new
			size: 200;
			color: (color scale: m);
			yourself. ].

	label := RSLabel new.
	updateText := [ 
		label text: 'Offset:', 
			(locate offset x printShowingDecimalPlaces: 1),'@',
			(locate offset y printShowingDecimalPlaces: 1) ].
	updateText value.
	fixedElement := newBox value: 1.
	"movableElement := newBox value: 2."
	movableElement := RSComposite new
		add: (RSLabel new 
			text: 'foo';
			rotateByDegrees: -45;
			yourself);
		adjustToChildren;
		color: (color scale: 2);
		yourself.
	"movableElement size: 40."
	movableElement when: RSMouseClick do: [ 
		canvas newAnimation
			scale: (NSScale linear 
				domain: #(0 0.5 1); 
				range: { 0@0. 20@20. 0@0});
			onStepDo: [ :t | 
				locate offset: t.
				locate move: movableElement on: fixedElement.
				updateText value.
				label signalUpdate ] ] for: canvas.
	
	canvas add: fixedElement; add: movableElement; add: label.
	grad2 := (LinearGradientPaint fromArray: 
		{0->'white'.
		0.25->'black'.
		1 ->'lightGray'})
		start: 0@ -15;
		stop: 0@ 15.
	grad1 := (LinearGradientPaint fromArray:
		{0->'lightGray'.
		0.25->'black'.
		1 ->'gray'})
		start: 0@ -15;
		stop: 0@ 15.
	labeled := RSLabeled new.
	labeled shapeBuilder: [ :m | RSLabel new text: m asString; color: Color white ].
	labeled location middle.
	buttons :=  #(outer border inner left center right top middle bottom) collect: [ :t |
		RSBox new
			border: (RSBorder new color: Color lightGray; yourself);
			cornerRadius: 5;
			extent: 60@30;
			paint: grad1;
			model: t;
			addInteraction: labeled;
			when: RSMouseEnter
				do: [:evt | evt traceCr. evt shape paint: grad2; signalUpdate ]
				for: canvas;
			when: RSMouseLeave
				do: [:evt | evt traceCr. evt shape paint: grad1; signalUpdate ]
				for: canvas;
			when: RSMouseClick do: [:evt |
				| p |
				evt shape model value: locate.
				p := movableElement position.
				locate move: movableElement on: fixedElement.
"				movableElement shape position: p.
				canvas signalUpdate"
				canvas newAnimation
					from: p;
					duration: 200 milliSeconds;
					to: movableElement position;
					on: movableElement shape set: #position: ] for: canvas
			] as: RSGroup.

	RSGridLayout new lineItemsCount: 3; on: buttons.
	RSVerticalLineLayout new alignCenter; gapSize: 30; on: (RSGroup with: canvas nodes with: buttons).
	canvas addAll: buttons.

	canvas
		when: RSExtentChangedEvent
		do: [ 
			canvas camera zoomToFit: canvas extent * 0.7.
			canvas signalUpdate ]
		for: canvas.
	
	^ canvas
]

{ #category : #examples }
RSBlocExamples >> example35MouseEnterMouseLeave [
	"Open Transcript to see the traced events. 
	- Blue ellipse is over the box. 
	- Red circle does not listen, so mouse events should reach either the other shapes or the canvas."
	<script: 'self new example35MouseEnterMouseLeave open'>

	| canvas |
	canvas := self newCanvas.
	canvas addShape: (RSBox new
			model: #orange;
			color: Color orange translucent;
			extent: 100 asPoint;
			yourself).
	canvas addShape: (RSEllipse new
			model: #blue;
			position: 25 asPoint;
			color: Color blue translucent;
			extent: 100 asPoint;
			yourself).

	(canvas shapes, { canvas }) asGroup
		when: RSMouseClick
			do: [:evt | evt trace. ' to ' trace. evt shape traceCr ]
			for: canvas;
		when: RSMouseMove
			do: [:evt | evt trace. ' to ' trace. evt shape traceCr ]
			for: canvas;
		when: RSMouseDoubleClick
			do: [:evt | evt trace. ' to ' trace. evt shape traceCr ]
			for: canvas;
		when: RSMouseEnter
			do: [:evt | evt trace. ' to ' trace. evt shape traceCr ]
			for: canvas;
		when: RSMouseLeave
			do: [:evt | evt trace. ' to ' trace. evt shape traceCr ]
			for: canvas.

	canvas addShape: (RSCircle new
			model: #red;
			position: 50 @ -25;
			color: Color red translucent;
			extent: 100 asPoint;
			yourself).

	^ canvas
]

{ #category : #private }
RSBlocExamples >> newCanvas [

	^ RSCanvas new
		useBlocHost;
		yourself
]
