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

	| canvas aString aLabel |
	canvas := RSCanvas new.

	aString := (String loremIpsum: 40) trimBoth.

	aLabel := RSLabel new
		fontName: 'Courier';
		text: aString;
		color: Color black;
		metricsProvider: RSBlocMetricProvider new;
		yourself.
	canvas addShape: (RSComposite new 
		color: Color cyan translucent;
		extent: aLabel extent;
		addShape: aLabel;
		yourself).

	canvas @ RSCanvasController.
	canvas useBlocHost.

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

"	canvas useBlocHost."
	^ canvas
]
