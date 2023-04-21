Extension { #name : #RSChartExample }

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example13AreaPlot [
	<script: 'self new example13AreaPlot open'>
	| x y1 y2  c canvas charts |
	x := 0 to: 2 by: 0.01.
	y1 := (2 * Float pi * x) sin.
	y2 := 1.2 * (4 * Float pi * x) sin.

	canvas := RSCanvas new.
	charts := {'Between y1 and 0'-> (y1 -> 0).
	'Between y2 and 1'-> (y1 -> 1).
	'Between y1 and y2'-> (y1 -> y2)} collect: [ :assoc |
		c := RSChart new.
		c extent: 500@100.
		c addPlot: (RSAreaPlot new x: x y1: assoc value key y2: assoc value value).
		c addDecoration: (RSHorizontalTick new numberOfTicks: 10; asFloat).
		c addDecoration: (RSVerticalTick new numberOfTicks: 3; asFloat).
		c ylabel: assoc key.
		c asShape	].
	RSVerticalLineLayout on: charts.
	canvas addAll: charts.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example14AreaPlotWithError [
	<script: 'self new example14AreaPlotWithError open'>
	| x y polyfit res y_est y_err c |
	x := 0 to: 10.
	y := #(3.9 4.4 10.8 10.3 11.2 13.1 14.1 9.9 13.9 15.1 12.5).
	polyfit := [ :x1 :y1 :n |
		"TODO"
		"Need a real polyfit implementation for any n"
		"maybe not in roassal3 maybe in polymath"
		"https://en.wikipedia.org/wiki/Curve_fitting"
		0.9-> 6].
	res := polyfit value: x value: y value: 1.
	y_est := res key * x + res value.

	y_err := x stdev * ( (1/x size) +
		(( (x - x average) raisedTo: 2) /
		((x - x average) raisedTo: 2) sum) ) sqrt.


	c := RSChart new.
	c padding: 10@10.
	c addPlot: (RSAreaPlot new x: x y1: y_est + y_err y2: y_est - y_err; color: (Color blue alpha: 0.1) ).
	c addPlot: (RSLinePlot new x: x y: y_est; color: Color red).
	c addPlot: (RSScatterPlot new x: x y: y).
	c addDecoration: (RSHorizontalTick new numberOfTicks: 10; asFloat).
	c addDecoration: (RSVerticalTick new numberOfTicks: 3; asFloat).
	^ c
]

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example15AreaBox [
	<script: 'self new example15AreaBox open'>
	| x y1 y2 c |
	x := #(0 1 2 3).
	y1 := #(0.8 0.8 0.2 0.2).
	y2 := #(0 0 1 1).
	c := RSChart new.
	c extent: 150@50.
	c addPlot: (RSAreaPlot new x: x y1: y1 y2: y2).
	c addPlot: (RSLinePlot new x: x y: y1; color: Color red; fmt: 's--').
	c addPlot: (RSLinePlot new x: x y: y2; color: Color orange; fmt: 'o--').
	c addDecoration: (RSHorizontalTick new numberOfTicks: 7; asFloat).
	c addDecoration: (RSVerticalTick new asFloat).

	^ c
]

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example16Series [
	<script: 'self new example16Series open'>
	| x cumsum c b y error |
	x := 1 to: 100.
	cumsum := [:arr | | sum |
		sum := 0.
		arr collect: [ :v | sum := sum + v. sum ] ].

	c := RSChart new.
	c extent: 400@400.

	b := RSLegend new.
	b container: c canvas.
	b layout horizontal gapSize: 30.
	#(
	series1 red
	series2 blue) pairsDo: [ :label :color |
		y := (x collect: [ :i | 50 atRandom - 25 ]).
		y := cumsum value: y.
		error := x.

		c addPlot: (RSAreaPlot new
			x: x y1: y + error y2: y - error;
			color: (color value: Color) translucent).
		c addPlot: (RSLinePlot new x: x y: y; fmt: 'o';
			color: (color value: Color)).
		b text: label withBoxColor: (color value: Color)
		 ].
	c build.
	b build.

	^ c canvas
]

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example17CLPvsUSD [
	<script: 'self new example17CLPvsUSD open'>
	| dates y data x c plot paint horizontal |
	dates := OrderedCollection new.
	y := OrderedCollection new.
	data :=
	{'04-jun-2020'.	769.13.
	'03-jun-2020'.	782.86.
	'02-jun-2020'.	796.46.
	'01-jun-2020'.	806.32.
	'29-may-2020'.	812.74.
	'28-may-2020'.	816.47.
	'27-may-2020'.	802.10.
	'26-may-2020'.	803.74.
	'25-may-2020'.	805.75.
	'22-may-2020'.	806.17.
	'20-may-2020'.	819.08.
	'19-may-2020'.	820.65.
	'18-may-2020'.	823.86.
	'15-may-2020'.	822.93.
	'14-may-2020'.	820.38.
	'13-may-2020'.	821.88.
	'12-may-2020'.	826.05.
	'11-may-2020'.	827.65.
	'08-may-2020'.	836.27.
	'07-may-2020'.	839.08.
	'06-may-2020'.	832.84.
	'05-may-2020'.	838.74.
	'04-may-2020'.	837.92} reverse.
		data pairsDo: [ :f :d |
			dates add: d.
			y add: f ].
	x := 1 to: dates size.
	c := RSChart new.
	c extent: 300@200.
	plot := RSAreaPlot new x: x y1: y y2: 750.
	paint := LinearGradientPaint fromArray:
		{0-> (Color green alpha: 0.3).
		0.8 -> Color transparent}.
	paint start: 0@ -100; stop: 0@ 100.
	plot shape paint: paint.
	c addPlot: plot.
	plot := RSLinePlot new x: x y: y.
	plot color: Color green muchDarker.
	plot width: 2.
	plot joinRound.
	plot markerEnd: (RSEllipse new size: 10).
	c addPlot: plot.

	c addDecoration: (horizontal := RSHorizontalTick new fromNames: dates; yourself).
	horizontal configuration fontSize: 4.
	horizontal useDiagonalLabel.
	c addDecoration: (RSVerticalTick new numberOfTicks: 10; asFloat).
	c title: 'CLP vs USD'.
	^ c
]

{ #category : #'*Roassal3-SVG-Examples' }
RSChartExample >> example18Animation [
	<script: 'self new example18Animation inspect'>
	| c canvas line points current lineAnimation area paint afterline yticks xticks |
	c := self example17CLPvsUSD.
	c build.
	canvas := c canvas.

	"line"
	line := canvas shapes detect: [ :s | s class = RSPolyline ].
	points := line controlPoints.
	current := OrderedCollection new.
	current add: points first; add: points second.
	line controlPoints: current.
	lineAnimation := (2 to: points size) collect: [ :i |
		canvas transitionAnimation
			duration: 100 milliSeconds;
			from: (points at: i - 1);
			to: (points at: i);
			onStepDo: [ :t |
				current removeLast; add: t.
				line controlPoints: current.
				 ];
			when: RSAnimationEndEvent do: [current add: (points at: i) ].
	] as: OrderedCollection.
	"area"
	area := canvas shapes detect: [ :s | s class = RSSVGPath ].
	paint := area paint.
	area noPaint.
	afterline := canvas parallelAnimation.
	afterline add: (canvas transitionAnimation
		onStepDo: [ :t |
			area paint: (Color transparent interpolateTo: paint at: t).
		]).
	lineAnimation add: afterline.
	canvas animationFrom: lineAnimation.

	"ticks"
	yticks := canvas shapes select: [ :s | s class = RSLabel ].
	yticks do: [ :s |  s bold. ].
	yticks := yticks groupedBy: [ :s | s matrix sy ].
	xticks := yticks values first.
	yticks := yticks values second.
	xticks doWithIndex: [ :s :index |
		canvas newAnimation
			delay: ((index-1) * 100) milliSeconds;
			duration: 200 milliSeconds;
			from: Color transparent;
			to: s color;
			on: s set: #color:.
		s color: Color transparent ].
	yticks doWithIndex: [ :s :index |
		s noPaint.
		afterline add: (canvas transitionAnimation
			delay: (index * 300) milliSeconds;
			duration: 2 second;
			easing: RSEasingInterpolator elasticOut;
			from: -100@ s position y;
			to: s position;
			onStepDo: [:p |
				s color: Color black.
				s position: p]).
		].
	^ canvas
]
