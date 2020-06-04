"
I have basic examples for RSChart and some of their decorators
"
Class {
	#name : #RSChartExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
RSChartExample >> example01Markers [
	<script: 'self new example01Markers open'>
	| x c p |
	x := -3.14 to: 3.14 by: 0.01.
	c := RSChart new.
	p := RSLinePlot new.
	p x: x y: x sin * 0.22 + 0.5.
	c addPlot: p.
	c addDecoration: RSHorizontalTick new.
	c addDecoration: RSVerticalTick new asFloat.
	c addDecoration: RSYMarkerDecoration new average.
	c addDecoration: RSYMarkerDecoration new min.
	c addDecoration: RSYMarkerDecoration new max.
	c addDecoration: RSXMarkerDecoration new max.
	c addDecoration: RSXMarkerDecoration new min.
	c addDecoration: (RSXMarkerDecoration new value: 0).
	^ c
]

{ #category : #examples }
RSChartExample >> example02ScatterPlot [
	<script: 'self new example02ScatterPlot show'>

	| classes c p |
	classes := Collection withAllSubclasses.
	c := RSChart new.
	p := RSScatterPlot new x: (classes collect: #numberOfMethods) y: (classes collect: #linesOfCode).
	c addPlot: p.
	
	c xlabel: 'X Axis'.
	c ylabel: 'Y Axis'.
	c title: 'Hello World'.
	^ c
]

{ #category : #examples }
RSChartExample >> example03Plot [
	<script: 'self new example03Plot show'>

	| plt p x |
	x := 0.0 to: 2 count: 100.
	plt := RSChart new.
	p := RSLinePlot new x: x y: (x raisedTo: 2).
	plt addPlot: p.

	p := RSLinePlot new x: x y: (x raisedTo: 3).
	plt addPlot: p.

	p := RSLinePlot new x: x y: (x raisedTo: 4).
	plt addPlot: p.

	plt xlabel: 'X Axis'.
	plt ylabel: 'Y Axis'.
	plt title: 'Hello World'.
	^ plt
]

{ #category : #examples }
RSChartExample >> example04WithTick [
	<script: 'self new example04WithTick show'>
	| x |
	x := -10.0 to: 20.0 count: 100.
	^ RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		addDecoration: RSHorizontalTick new integer;
		addDecoration: RSVerticalTick new integer;
		yourself
]

{ #category : #examples }
RSChartExample >> example05WithTick [
	<script: 'self new example05WithTick show'>
	| x c |
	x := 0.0 to: 14 count: 100.
	c := RSChart new.
	1 to: 7 do: [ :i |
		c addPlot: (RSLinePlot new x: x y: (i * 0.3 + x) sin * (7 - i))
	].
	c addDecoration: RSVerticalTick new integer.
	c addDecoration: RSHorizontalTick new integer.
	^ c
]

{ #category : #examples }
RSChartExample >> example06CustomNumberOfTicks [
	<script: 'self new example06CustomNumberOfTicks show'>
	| x |
	x := -10.0 to: 20.0 count: 100.
	^ RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		addDecoration: (RSHorizontalTick new 
			numberOfTicks: 20;
			integer);
		addDecoration: (RSVerticalTick new integer 
			numberOfTicks: 2;
			doNotUseNiceLabel);
		yourself
	
]

{ #category : #examples }
RSChartExample >> example07AdjustingFontSize [
	<script: 'self new example07AdjustingFontSize open'>
	| x y c |
	x := -3.14 to: 3.14 by: 0.1.
	y := x sin.

	c := RSChart new.
	c addPlot: (RSLinePlot new x: x y: y).
	c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
	c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; horizontal).
	^ c
]

{ #category : #examples }
RSChartExample >> example08TwoCharts [
	<script: 'self new example08TwoCharts open'>
	| c g1 c1 g2 c2 |
	c := RSCanvas new.

	g1 := RSGroup new.
	c1 := RSChart new.
	c1 container: g1.
	c1 addPlot: (RSLinePlot new x: (1 to: 10) y: (1 to: 10) sqrt).
	c1 title: 'squared root'.
	c1 xlabel: 'X'.
	c1 ylabel: 'Y'.
	c1 build.

	g2 := RSGroup new.
	c2 := RSChart new.
	c2 container: g2.
	c2 addPlot: (RSLinePlot new x: (1 to: 10) y: (1 to: 10) squared).
	c2 title: '^ 2'.
	c2 xlabel: 'X'.
	c2 ylabel: 'Y'.
	c2 build.

	c add: g1 asShape; add: g2 asShape.
	RSHorizontalLineLayout on: c shapes.

	c @ RSCanvasController.
	^ c 
]

{ #category : #examples }
RSChartExample >> example09LinearSqrtSymlog [
	<script: 'self new example09LinearSqrtSymlog open'>
	| c x y |
	c := RSCanvas new @ RSCanvasController.
	x := (-5 to: 500 by: 0.1).
	y := x.
	#(yLinear ySqrt yLog) do: [ :sel | 
		| chart g |
		g := RSGroup new.
		chart := RSChart new.
		chart container: g.
		chart addPlot: (RSLinePlot new x: x y: y).
		chart addDecoration: (RSVerticalTick new asFloat).
		chart perform: sel.
		chart title: sel.
		chart build.
		c add: g asShape ].
	RSHorizontalLineLayout on: c shapes.
	^ c
]

{ #category : #examples }
RSChartExample >> example10BarPlot [
	<script: 'self new example10BarPlot open'>
	| c p x y |

	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSBarPlot new x: x y: y.


	c addPlot: p.
	c xlabel: 'X Axis'.
	c addDecoration: (RSHorizontalTick new 
		numberOfTicks: 20;
		asFloat).
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c ylabel: 'Y Axis'.
	c title: 'Histogram'.
	^ c
]

{ #category : #examples }
RSChartExample >> example11BarplotCombinedWithLine [
	<script: 'self new example11BarplotCombinedWithLine open'>
	| c x y |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.

	c addPlot: (RSBarPlot new x: x y: y).
	c addPlot: (RSLinePlot new x: x y: y; color: Color red).

	c addDecoration: (RSHorizontalTick new  asFloat).
	c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
	c xlabel: 'X Axis'.
	c ylabel: 'Y Axis'.
	c title: 'Bar char'.
	^ c
]

{ #category : #examples }
RSChartExample >> example12ScatterPlotAndNormalizer [
	<script: 'self new example12ScatterPlotAndNormalizer open'>
	| x y z r c p |
	x := OrderedCollection new.
	y := OrderedCollection new.
	z := OrderedCollection new.
	r := Random seed: 42.
	1 to: 100 do: [ :i |
		x add: i + (r nextInt: 10).
		y add: i + (r nextInt: 10).
		z add: i + (r nextInt: 10).
	].

	c := RSChart new.
	p := RSScatterPlot new x: x y: y.
	p color: Color blue translucent.
	p processBlock: [ :shapes | 
			shapes models: z.
			RSNormalizer size
				shapes: shapes;
				from: 2;
				to: 10;
				normalize: #yourself.
			RSNormalizer color
				shapes: shapes;
				normalize: #yourself.
			shapes translucent.
				 ].
	c addPlot: p.
	 
	c addDecoration: (RSHorizontalTick new doNotUseNiceLabel asFloat: 3).
	c addDecoration: RSVerticalTick new.

	^ c
]

{ #category : #examples }
RSChartExample >> example13AreaPlot [
	<script: 'self new example13AreaPlot open'>
	| x y1 y2  c canvas charts |
	x := 0 to: 2 by: 0.01.
	y1 := (2 * Float pi * x) sin.
	y2 := 1.2 * (4 * Float pi * x) sin.

	canvas := RSCanvas new.
	charts := {'Between y1 and 0'-> (y1 -> 0).
	'Between y2 and 1'-> (y1 -> 1).
	'Between y1 and y2'-> (y1 -> y2)} collect: [ :assoc | | g |
		g := RSGroup new.
		c := RSChart new.
		c container: g.
		c extent: 500@100.
		c addPlot: (RSAreaPlot new x: x y1: assoc value key y2: assoc value value).
		c addDecoration: (RSHorizontalTick new numberOfTicks: 10; asFloat).
		c addDecoration: (RSVerticalTick new numberOfTicks: 3; asFloat).
		c ylabel: assoc key.
		c build.
		g asShape	].
	RSVerticalLineLayout on: charts.
	canvas addAll: charts.
	canvas @ RSCanvasController.
	^ canvas 


]

{ #category : #examples }
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
	c addPlot: (RSAreaPlot new x: x y1: y_est + y_err y2: y_est - y_err; color: (Color blue alpha: 0.1) ).
	c addPlot: (RSLinePlot new x: x y: y_est; color: Color red).
	c addPlot: (RSScatterPlot new x: x y: y).
	c addDecoration: (RSHorizontalTick new numberOfTicks: 10; asFloat).
	c addDecoration: (RSVerticalTick new numberOfTicks: 3; asFloat).
	^ c 
]

{ #category : #examples }
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

{ #category : #examples }
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

	^ c canvas.
]
