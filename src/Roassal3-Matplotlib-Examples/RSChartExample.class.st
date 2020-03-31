Class {
	#name : #RSChartExample,
	#superclass : #Object,
	#category : #'Roassal3-Matplotlib-Examples'
}

{ #category : #'as yet unclassified' }
RSChartExample >> example02ScatterPlot [
	<script: 'self new example02ScatterPlot'>

	| classes plt p |
	classes := Collection withAllSubclasses.
	plt := RSChart new.
	p := RSScatterPlot new x: (classes collect: #numberOfMethods) y: (classes collect: #linesOfCode).
	plt addPlot: p.
	
	plt xlabel: 'X Axis'.
	plt ylabel: 'Y Axis'.
	plt title: 'Hello World'.
	plt show
]

{ #category : #'as yet unclassified' }
RSChartExample >> example03Plot [
	<script: 'self new example03Plot'>

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
	plt show
]

{ #category : #'as yet unclassified' }
RSChartExample >> example04WithTick [
	<script: 'self new example04WithTick'>
	| x |
	x := -10.0 to: 20.0 count: 100.
	RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		addDecoration: RSHorizontalTick new integer;
		addDecoration: RSVerticalTick new integer;
		show
]

{ #category : #'as yet unclassified' }
RSChartExample >> example05WithTick [
	<script: 'self new example05WithTick'>
	| x c |
	x := 0.0 to: 14 count: 100.
	c := RSChart new.
	1 to: 7 do: [ :i |
		c addPlot: (RSLinePlot new x: x y: (i * 0.3 + x) sin * (7 - i))
	].
	c addDecoration: RSVerticalTick new integer.
	c addDecoration: RSHorizontalTick new integer.
	c show
]

{ #category : #'as yet unclassified' }
RSChartExample >> example06CustomNumberOfTicks [
	<script: 'self new example06CustomNumberOfTicks'>
	| x |
	x := -10.0 to: 20.0 count: 100.
	RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		addDecoration: (RSHorizontalTick new 
			numberOfTicks: 20;
			integer);
		addDecoration: (RSVerticalTick new integer 
			numberOfTicks: 2;
			doNotUseNiceLabel);
		show
	
]

{ #category : #'as yet unclassified' }
RSChartExample >> example07Corona [
	<script: 'self new example07Corona'>
	"Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame:v2.0/src';
  load."

	| url content dataFrame dataSum indexX columnNames chart |
	url := 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv'.
	content := (ZnEasy get: url) contents.
	dataFrame := DataFrame 
	            readFromCsv: content readStream contents 
	            withSeparator: $,.

	dataSum := OrderedCollection new.
	5 to: dataFrame numberOfColumns do: [ :index |
	    dataSum add: (dataFrame columnAt: index) sum ].
	indexX := dataSum collectWithIndex: [ :s :i | i ].
	columnNames := dataFrame columnNames allButFirst: 4.

	chart := RSChart new.

	chart extent: 400@250.
	chart addPlot:(RSBarPlot new x: indexX y: dataSum).
	"chart xlabel: 'Time'."
	chart ylabel: 'Contaminated'.
	chart title: 'Corona confirmed cases'.
	chart addDecoration: (RSHorizontalTick new fromNames: columnNames).
	chart addDecoration: (RSVerticalTick new
		numberOfTicks: 10;
		integerWithCommas).
	chart show.
	"chart canvas shapes 
		select: [ :s | s class = RSPolyline ] 
		thenDo: [ :s | s dashArray: #(5) ]."
]

{ #category : #'as yet unclassified' }
RSChartExample >> exampleBasic01 [

"
This example is not meant to work. It is just the result of a brainstorming

x = np.linspace(0, 2, 100)

plt.plot(x, x, label='linear')
plt.plot(x, x**2, label='quadratic')
plt.plot(x, x**3, label='cubic')

plt.xlabel('x label')
plt.ylabel('y label')

plt.title('Simple Plot')
plt.legend()
plt.show()

From: https://matplotlib.org/tutorials/introductory/usage.html#sphx-glr-tutorials-introductory-usage-py
"

	| plt x |
	plt := RSChart new.
	x := (0 to: 2 by: 1 / 100).
	plt plotX: x y: x label: 'linear'.
	plt plotX: x y: (x collect: [ :v | v raisedTo: 2 ]) label: 'quadratic'.
	plt plotX: x y: (x collect: [ :v | v raisedTo: 3 ]) label: 'cubic'.
		
	plt xLabel: 'x label'.
	plt yLabel: 'y label'.
	plt title: 'Simple plot'.
	plt legend.
	plt show
]
