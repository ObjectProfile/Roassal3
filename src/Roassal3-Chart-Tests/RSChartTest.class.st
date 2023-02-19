Class {
	#name : #RSChartTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
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

{ #category : #tests }
RSChartTest >> testMinMaxValue [

	| y c |
	y := #(10 13 15).
	c := RSChart new.
	c addPlot: (RSLinePlot new y: y).
	c build.
	self assert: c minValueX equals: 1.
	self assert: c maxValueX equals: 3.
	self assert: c minValueY equals: 10.
	self assert: c maxValueY equals: 15
]

{ #category : #tests }
RSChartTest >> testMinMaxValue2 [

	| y c x |
	y := #(-10 -13 -15).
	x := #(4 6 9).
	c := RSChart new.
	c addPlot: (RSLinePlot new x: x y: y).
	c build.
	self assert: c minValueX equals: 4.
	self assert: c maxValueX equals: 9.
	self assert: c minValueY equals: -15.
	self assert: c maxValueY equals: -10
]

{ #category : #tests }
RSChartTest >> testMustInclude0 [

	| y c |
	y := #(10 13 15).
	c := RSChart new.
	c addPlot: (RSLinePlot new y: y).
	c mustInclude0inY.
	c build.
	self assert: c minValueX equals: 1.
	self assert: c maxValueX equals: 3.
	self assert: c minValueY equals: 0.
	self assert: c maxValueY equals: 15
]

{ #category : #tests }
RSChartTest >> testMustInclude02 [

	| y c |
	y := #(-10 -13 -15).
	c := RSChart new.
	c addPlot: (RSLinePlot new y: y).
	c mustInclude0inY.
	c build.
	self assert: c minValueX equals: 1.
	self assert: c maxValueX equals: 3.
	self assert: c minValueY equals: -15.
	self assert: c maxValueY equals: 0
]

{ #category : #tests }
RSChartTest >> testMustInclude03 [

	| y c x |
	y := #(-10 -13 -15).
	x := #(4 6 9).
	c := RSChart new.
	c addPlot: (RSLinePlot new x: x y: y).
	c mustInclude0inX.
	c build.
	self assert: c minValueX equals: 0.
	self assert: c maxValueX equals: 9.
	self assert: c minValueY equals: -15.
	self assert: c maxValueY equals: -10
]

{ #category : #tests }
RSChartTest >> testMustInclude04 [

	| y c |
	y := OrderedCollection new.
	-3.14 to: 3.14 by: 0.1 do: [ :x |
		y add: x sin ].

	c := RSChart new.
	c addPlot: (RSLinePlot new y: y).
	c build.

	self assert: c minValueY equals: -0.9995258306054791.
	self assert: c maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSChartTest >> testMustInclude05 [

	| y c |
	y := OrderedCollection new.
	-3.14 to: 3.14 by: 0.1 do: [ :x |
		y add: x sin ].

	c := RSChart new.
	c addPlot: (RSLinePlot new y: y).
	c mustInclude0inY.
	c build.

	self assert: c minValueY equals: -0.9995258306054791.
	self assert: c maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSChartTest >> testSameMinMax [

	| c plot |
	c := RSChart new.
	plot := RSLinePlot new.
	plot y: #( 2 2 ).
	c addPlot: plot.

	c addDecoration: (RSChartTitleDecoration new
			 title: 'Reward evolution';
			 fontSize: 20).
	c xlabel: 'Episode' offset: 0 @ 10.
	c ylabel: 'Reward' offset: -20 @ 0.
	c addDecoration: RSHorizontalTick new.
	c addDecoration: RSVerticalTick new.
	c build
]

{ #category : #tests }
RSChartTest >> testWithWeirdValues [

	| values g d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	g := RSChart new.
	d := RSLinePlot new y: values.
	g addPlot: d.
	g build.
	c := g canvas.

	self assert: c numberOfShapes equals: 2.
	self assert: c shapes first class equals: RSBox.

	line := c shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLine [

	| values g d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	g := RSChart new.
	d := RSLinePlot new y: values.
	g addPlot: d.
	g build.
	c := g canvas.

	self assert: c numberOfShapes equals: 2.
	self assert: c shapes first class equals: RSBox.

	line := c shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLineWithTicks [

	| values g d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	g := RSChart new.
	d := RSLinePlot new y: values.
	g addPlot: d.
	g addDecoration: RSHorizontalTick new.
	g addDecoration: RSVerticalTick new.
	g build.
	c := g canvas.

	self assert: c numberOfShapes equals: 20.
	self assert: c shapes first class equals: RSBox.

	line := c shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLineWithTicks2 [
	| x g d c labels |
	x := { -5 . 0 . 1 . 2 }.
	g := RSChart new.
	d := RSLinePlot new x: x y: x log.
	g addPlot: d.
	g addDecoration: RSVerticalTick new.
	g build.

	self assert: g minValueX equals: -5.
	self assert: g minValueY equals: 0.

	self assert: g maxValueX equals: 2.
	self assert: g maxValueY equals: 8 / 25.

	c := g canvas.

	labels := c shapes select: [ :s | s class == RSLabel ].
	self assert: labels first position y <= 0
]

{ #category : #tests }
RSChartTest >> testYMarker [

	| x c p1 p2 marker line |
	x := -3.14 to: 3.14 by: 0.01.
	c := RSChart new.
	p1 := RSLinePlot new.
	p1 x: x y: x sin * 0.22.
	c addPlot: p1.
	p2 := RSLinePlot new.
	p2 x: x y: x cos * 0.18.
	c addPlot: p2.
	c addDecoration: RSHorizontalTick new.
	c addDecoration: RSVerticalTick new asFloat.

	marker := RSYMarkerDecoration new.
	c addDecoration: marker.
	c build.

	line := marker createMarkerLineFromPlot: p2.
	self assert: line from equals: (0@ -175.0).
	self assert: line to equals: (200@ -175.0)
]
