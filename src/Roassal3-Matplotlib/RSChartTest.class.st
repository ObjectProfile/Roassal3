Class {
	#name : #RSChartTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #tests }
RSChartTest >> testBasic [

	| x |
	x := -10.0 to: 20.0 count: 100.

	RSChart new
    addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
    addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
	addDecoration: RSHorizontalTick new;
	addDecoration: RSVerticalTick new;
	build
]
