Class {
	#name : #RSChartTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSChartTest >> testBasic [

	| x |
	x := -10.0 to: 20.0 count: 100.
	RSScatterPlot new
		x: x y: (x raisedTo: 3);
		build
]

{ #category : #tests }
RSChartTest >> testExtentOnChange [
	| chart plot canvas|
	chart := RSCombinedChart new.
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

	| y p |
	y := #(10 13 15).
	p := RSLinePlot new y: y.
	p build.
	self assert: p minValueX equals: 1.
	self assert: p maxValueX equals: 3.
	self assert: p minValueY equals: 10.
	self assert: p maxValueY equals: 15
]

{ #category : #tests }
RSChartTest >> testMinMaxValue2 [

	| y p x |
	y := #(-10 -13 -15).
	x := #(4 6 9).
	p := RSLinePlot new x: x y: y.
	p build.
	self assert: p minValueX equals: 4.
	self assert: p maxValueX equals: 9.
	self assert: p minValueY equals: -15.
	self assert: p maxValueY equals: -10
]

{ #category : #tests }
RSChartTest >> testMustInclude0 [

	| y p |
	y := #(10 13 15).
	p := RSLinePlot new y: y.
	p mustInclude0inY.
	p build.
	self assert: p minValueX equals: 1.
	self assert: p maxValueX equals: 3.
	self assert: p minValueY equals: 0.
	self assert: p maxValueY equals: 15
]

{ #category : #tests }
RSChartTest >> testMustInclude02 [

	| y p |
	y := #(-10 -13 -15).
	p := RSLinePlot new y: y.
	p mustInclude0inY.
	p build.
	self assert: p minValueX equals: 1.
	self assert: p maxValueX equals: 3.
	self assert: p minValueY equals: -15.
	self assert: p maxValueY equals: 0
]

{ #category : #tests }
RSChartTest >> testMustInclude03 [

	| y p x |
	y := #(-10 -13 -15).
	x := #(4 6 9).
	p := RSLinePlot new x: x y: y.
	p removeAllTicks.
	p mustInclude0inX.
	p build.
	self assert: p minValueX equals: 0.
	self assert: p maxValueX equals: 9.
	self assert: p minValueY equals: -15.
	self assert: p maxValueY equals: -10
]

{ #category : #tests }
RSChartTest >> testMustInclude05 [

	| y p |
	y := OrderedCollection new.
	-3.14 to: 3.14 by: 0.1 do: [ :x |
		y add: x sin ].

	p := RSLinePlot new y: y.
	p removeAllTicks.
	p mustInclude0inY.
	p build.

	self assert: p minValueY equals: -0.9995258306054791.
	self assert: p maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSChartTest >> testSameMinMax [

	| plot |
	plot := RSLinePlot new.
	plot y: #( 2 2 ).

	plot addDecoration: (RSChartTitleDecoration new
		title: 'Reward evolution';
		fontSize: 20).
	plot xlabel: 'Episode' offset: 0 @ 10.
	plot ylabel: 'Reward' offset: -20 @ 0.
	plot build
]

{ #category : #tests }
RSChartTest >> testStylerDefault [
	| x tick plot |
	x := -10.0 to: 20.0 count: 100.
	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	self assert: plot styler textColor equals: Color black.
	self assert: tick styler textColor equals: Color black.
	self assert: plot styler equals: tick styler
]

{ #category : #tests }
RSChartTest >> testStylerRedLabel [
	| x tick plot styler |
	x := -10.0 to: 20.0 count: 100.
	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new
		textColor: Color red.
	tick styler: styler.
	plot build.
	self assert: (tick labels allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerRedTick [
	| x tick plot styler |
	x := -10.0 to: 20.0 count: 100.
	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new
		tickColor: Color red.
	tick styler: styler.
	plot build.
	self assert: (tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerRedTickInChart [
	| x tick plot styler |
	x := -10.0 to: 20.0 count: 100.
	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new
		tickColor: Color red.
	plot styler: styler.
	plot build.
	self assert: (tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSChartTest >> testStylerSpineRed [
	| x plot styler spine |
	x := -10.0 to: 20.0 count: 100.

	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	styler := RSChartStyler new
		spineColor: Color red.

	spine := plot spineDecoration.

	plot styler: styler.
	plot build.
	self assert: spine box border color equals: Color red
]

{ #category : #tests }
RSChartTest >> testStylerTitleLabel [
	| x title plot styler |
	x := -10.0 to: 20.0 count: 100.

	plot := RSScatterPlot new x: x y: (x raisedTo: 3).
	styler := RSChartStyler new
		textColor: Color red.

	title := plot title: 'Chart'.
	plot styler: styler.
	plot build.
	self assert: title label color equals: Color red
]

{ #category : #tests }
RSChartTest >> testWithWeirdValues [

	| values d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	d := RSLinePlot new y: values.
	d removeAllTicks.
	d build.
	c := d canvas.

	self assert: c numberOfShapes equals: 2.
	self assert: c shapes first class equals: RSBox.

	line := c shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLine [

	| values d line c |
	values := {Float infinity negated. Float infinity negated. 0.30102999566398114. 0.47712125471966244}.
	d := RSLinePlot new y: values.
	d removeAllTicks.
	d build.
	c := d canvas.

	self assert: c numberOfShapes equals: 2.
	self assert: c shapes first class equals: RSBox.

	line := c shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLineWithTicks [

	| values linePlot line canvas |
	values := {
		          Float infinity negated.
		          Float infinity negated.
		          0.30102999566398114.
		          0.47712125471966244 }.

	linePlot := RSLinePlot new y: values.
	linePlot build.

	canvas := linePlot canvas.

	self assert: canvas numberOfShapes equals: 20.
	self assert: canvas shapes first class equals: RSBox.

	line := canvas shapes second.
	self assert: line controlPoints size equals: 2
]

{ #category : #tests }
RSChartTest >> testWithWeirdValuesLineWithTicks2 [

	| x linePlot canvas labels y |
	x := { -5. 0. 1. 2 }.
	y := x log.

	linePlot := RSLinePlot new x: x y: y.
	linePlot verticalTick doNotUseNiceLabel.
	linePlot removeHorizontalTicks.
	linePlot build.

	self assert: linePlot minValueX equals: x min.
	self assert: linePlot minValueY equals: 0. "Here is y min negative infinity but Roassal puts a 0"

	self assert: linePlot maxValueX equals: x max.
	self assert: linePlot maxValueY equals: y max.

	canvas := linePlot canvas.

	labels := canvas shapes select: [ :s | s class == RSLabel ].
	self assert: labels first position y <= 0
]

{ #category : #tests }
RSChartTest >> testYMarker [

	| x plot2 marker line y |
	x := -3.14 to: 3.14 by: 0.01.
	y := x cos * 0.18.

	plot2 := RSLinePlot new.
	plot2 x: x y: y.

	plot2 horizontalTick doNotUseNiceLabel.
	plot2 verticalTick asFloat.

	marker := RSYMarkerDecoration new.
	plot2 addDecoration: marker.
	plot2 build.

	line := marker createMarkerLineFromPlot: plot2.
	self assert: line from equals: 0 @ (plot2 yScale scale: plot2 maxValueY).
	self assert: line to
		equals: (plot2 xScale scale: plot2 maxValueX) @ (plot2 yScale scale: plot2 maxValueY)
]
