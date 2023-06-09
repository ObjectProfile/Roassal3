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
		build
]

{ #category : #tests }
RSChartTest >> testExtentOnChange [
	| chart plot canvas|
	chart := RSChart new.
	self skip.
	plot := RSLinePlot y: #(1 2 3).
	chart add: plot.
	chart build.
	canvas := chart container.
	self assert: canvas extent equals: canvas defaultExtent.
	self assert: chart extent < canvas extent.
	canvas extent: 1000@1000.
	self assert: chart extent equals: canvas extent.
	self assert: chart extent > canvas defaultExtent.	
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
	c removeAllTicks.
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
	c removeAllTicks.
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
	c removeAllTicks.
	c addPlot: (RSLinePlot new y: y).
	c mustInclude0inY.
	c build.

	self assert: c minValueY equals: -0.9995258306054791.
	self assert: c maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSChartTest >> testSameMinMax [

	| chart plot |
	chart := RSChart new.
	plot := RSLinePlot new.
	plot y: #( 2 2 ).
	chart addPlot: plot.

	chart addDecoration: (RSChartTitleDecoration new
		title: 'Reward evolution';
		fontSize: 20).
	chart xlabel: 'Episode' offset: 0 @ 10.
	chart ylabel: 'Reward' offset: -20 @ 0.
	chart build
]

{ #category : #tests }
RSChartTest >> testStylerDefault [
	| x tick chart |
	x := -10.0 to: 20.0 count: 100.
	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	tick := chart horizontalTick.
	self assert: chart styler textColor equals: Color black.
	self assert: tick styler textColor equals: Color black.
	self assert: chart styler equals: tick styler
]

{ #category : #tests }
RSChartTest >> testStylerRedLabel [
	| x tick chart styler |
	x := -10.0 to: 20.0 count: 100.
	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	tick := chart horizontalTick.
	styler := RSChartStyler new
		textColor: Color red.
	tick styler: styler.
	chart build.
	self assert: (tick labels allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerRedTick [
	| x tick chart styler |
	x := -10.0 to: 20.0 count: 100.
	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	tick := chart horizontalTick.
	styler := RSChartStyler new
		tickColor: Color red.
	tick styler: styler.
	chart build.
	self assert: (tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerRedTickInChart [
	| x tick chart styler |
	x := -10.0 to: 20.0 count: 100.
	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	tick := chart horizontalTick.
	styler := RSChartStyler new
		tickColor: Color red.
	chart styler: styler.
	chart build.
	self assert: (tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerSpineRed [
	| x chart styler spine |
	x := -10.0 to: 20.0 count: 100.

	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	styler := RSChartStyler new
		spineColor: Color red.

	spine := chart spineDecoration.

	chart styler: styler.
	chart build.
	self assert: spine box border color equals: Color red
]

{ #category : #tests }
RSChartTest >> testStylerTitleLabel [
	| x title chart styler |
	x := -10.0 to: 20.0 count: 100.

	chart := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		yourself.
	styler := RSChartStyler new
		textColor: Color red.

	title := chart title: 'Chart'.
	chart styler: styler.
	chart build.
	self assert: title label color equals: Color red
]

{ #category : #tests }
RSChartTest >> testWithWeirdValues [

	| values g d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	g := RSChart new.
	g removeAllTicks.
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
	g removeAllTicks.
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

	| values chart linePlot line canvas |
	values := {
		          Float infinity negated.
		          Float infinity negated.
		          0.30102999566398114.
		          0.47712125471966244 }.
	chart := RSChart new.

	linePlot := RSLinePlot new y: values.
	chart addPlot: linePlot.
	chart build.

	canvas := chart canvas.

	self assert: canvas numberOfShapes equals: 20.
	self assert: canvas shapes first class equals: RSBox.

	line := canvas shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLineWithTicks2 [

	| x chart linePlot canvas labels y |
	x := { -5. 0. 1. 2 }.
	y := x log.
	chart := RSChart new.

	linePlot := RSLinePlot new x: x y: y.
	chart addPlot: linePlot.
	chart verticalTick doNotUseNiceLabel.
	chart removeHorizontalTicks.
	chart build.

	self assert: chart minValueX equals: x min.
	self assert: chart minValueY equals: 0. "Here is y min negative infinity but Roassal puts a 0"

	self assert: chart maxValueX equals: x max.
	self assert: chart maxValueY equals: y max.

	canvas := chart canvas.

	labels := canvas shapes select: [ :s | s class == RSLabel ].
	self assert: labels first position y <= 0
]

{ #category : #tests }
RSChartTest >> testYMarker [

	| x chart plot2 marker line y |
	x := -3.14 to: 3.14 by: 0.01.
	y := x cos * 0.18.
	chart := RSChart new.

	plot2 := RSLinePlot new.
	plot2 x: x y: y.
	chart addPlot: plot2.

	chart horizontalTick doNotUseNiceLabel.
	chart verticalTick asFloat.

	marker := RSYMarkerDecoration new.
	chart addDecoration: marker.
	chart build.

	line := marker createMarkerLineFromPlot: plot2.
	self assert: line from equals: 0 @ (plot2 yScale scale: plot2 maxValueY).
	self assert: line to
		equals: (plot2 xScale scale: plot2 maxValueX) @ (plot2 yScale scale: plot2 maxValueY)
]
