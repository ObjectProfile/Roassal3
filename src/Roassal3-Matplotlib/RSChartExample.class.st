Class {
	#name : #RSChartExample,
	#superclass : #Object,
	#category : #'Roassal3-Matplotlib'
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

	| classes plt p x |
	x := 0.0 to: 2 count: 100.
	classes := Collection withAllSubclasses.
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
	x := 0.0 to: 20.0 count: 100.

	RSChart new
    addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
    addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
	addDecoration: RSVerticalTick new;
	show
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
