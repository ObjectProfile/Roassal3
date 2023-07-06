Class {
	#name : #RSAbstractPlotTest,
	#superclass : #RSTest,
	#instVars : [
		'plot',
		'x',
		'y'
	],
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #testing }
RSAbstractPlotTest class >> isAbstract [
	^ self =  RSAbstractPlotTest
]

{ #category : #tests }
RSAbstractPlotTest >> classToTest [
	self subclassResponsibility
]

{ #category : #tests }
RSAbstractPlotTest >> setUp [

	super setUp.
	x := 0 to: 6 by: 0.1.
	y := x sin.
	plot := self classToTest new x: x y: y
]

{ #category : #tests }
RSAbstractPlotTest >> testBasic [

	plot build
]

{ #category : #tests }
RSAbstractPlotTest >> testEmptyPlot [

	| p |
	p := self classToTest new x: #( 0 ) y: #( 0 ).
	chart addPlot: p.
	chart verticalTick integer;
			 numberOfTicks: 1;
			 fontSize: 10.
	chart horizontalTick integer;
			 numberOfTicks: 1;
			 fontSize: 10.
	chart build
]

{ #category : #tests }
RSAbstractPlotTest >> testExtentIsCorrect [

	plot build.
	
	self assert: plot extent equals: 250 @ 200
]

{ #category : #tests }
RSAbstractPlotTest >> testMinMaxValue2 [

	plot := self classToTest new x: #( 4 6 9 ) y: #( -10 -13 -15 ).
	plot build.
	
	self assert: plot minValueX equals: 4.
	self assert: plot maxValueX equals: 9.
	self assert: plot minValueY equals: -15.
	self assert: plot maxValueY equals: -10
]

{ #category : #tests }
RSAbstractPlotTest >> testMustInclude0 [

	plot := self classToTest new y: #( 10 13 15 ).
	plot mustInclude0inY.
	plot build.

	self assert: plot minChartValueX equals: 1.
	self assert: plot maxChartValueX equals: 3.
	self assert: plot minChartValueY equals: 0.
	self assert: plot maxChartValueY equals: 15
]

{ #category : #tests }
RSAbstractPlotTest >> testMustInclude02 [

	plot := self classToTest new y: #( -10 -13 -15 ).
	plot mustInclude0inY.
	plot build.

	self assert: plot minChartValueX equals: 1.
	self assert: plot maxChartValueX equals: 3.
	self assert: plot minChartValueY equals: -15.
	self assert: plot maxChartValueY equals: 0
]

{ #category : #tests }
RSAbstractPlotTest >> testMustInclude03 [

	plot := self classToTest new x: #( 4 6 9 ) y: #( -10 -13 -15 ).
	plot removeAllTicks.
	plot mustInclude0inX.
	plot build.

	self assert: plot minChartValueX equals: 0.
	self assert: plot maxChartValueX equals: 9.
	self assert: plot minChartValueY equals: -15.
	self assert: plot maxChartValueY equals: -10
]

{ #category : #tests }
RSAbstractPlotTest >> testMustInclude04 [

	plot := self classToTest new y: (-3.14 to: 3.14 by: 0.1) sin.
	plot removeAllTicks.
	plot build.

	self assert: plot minValueY equals: -0.9995258306054791.
	self assert: plot maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSAbstractPlotTest >> testMustInclude05 [

	plot := self classToTest new y: (-3.14 to: 3.14 by: 0.1) sin.
	plot removeAllTicks.
	plot mustInclude0inY.
	plot build.

	self assert: plot minValueY equals: -0.9995258306054791.
	self assert: plot maxValueY equals: 0.9999417202299663
]

{ #category : #tests }
RSAbstractPlotTest >> testOpening [
	| x |
	chart := RSCompositeChart new.
	x := 0 to: 2 by: 1 / 100.
	chart addPlot: (self classToTest new x: x y: x).
	chart addPlot: (self classToTest new x: x y: (x collect: #squared)).
	chart addPlot: (self classToTest new x: x y: (x collect: [ :v | v * v * v ])).
	chart build.
	chart show delete
]

{ #category : #tests }
RSAbstractPlotTest >> testPaddingIsCorrect [

	plot build.
	
	self assert: plot padding equals: 15 @ 10
]

{ #category : #tests }
RSAbstractPlotTest >> testSameMinMax [

	plot := self classToTest new.
	plot y: #( 2 2 ).
	plot addDecoration: (RSChartTitleDecoration new
			 title: 'Reward evolution';
			 fontSize: 20).
	plot xlabel: 'Episode' offset: 0 @ 10.
	plot ylabel: 'Reward' offset: -20 @ 0.
	plot build
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerDefault [

	| tick |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.

	self assert: plot styler textColor equals: Color black.
	self assert: tick styler textColor equals: Color black.
	self assert: plot styler equals: tick styler
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerRedLabel [

	| tick styler |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new textColor: Color red.
	tick styler: styler.
	plot build.

	self assert:
		(tick labels allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerRedTick [

	| tick styler |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new tickColor: Color red.
	tick styler: styler.
	plot build.

	self assert:
		(tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerRedTickInChart [

	| tick styler |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.
	styler := RSChartStyler new tickColor: Color red.
	plot styler: styler.
	plot build.

	self assert:
		(tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerSpineRed [

	| styler spine |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	styler := RSChartStyler new spineColor: Color red.
	spine := plot spineDecoration.
	plot styler: styler.
	plot build.

	self assert: spine box border color equals: Color red
]

{ #category : #tests }
RSAbstractPlotTest >> testStylerTitleLabel [

	| title styler |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	styler := RSChartStyler new textColor: Color red.
	title := plot title: 'Chart'.
	plot styler: styler.
	plot build.

	self assert: title label color equals: Color red
]

{ #category : #tests }
RSAbstractPlotTest >> testWithAxisLabel [

	plot xlabel: 'X axis'.
	plot build.

	self
		assert: (plot container shapes select: #isLabel) last text
		equals: 'X axis'
]

{ #category : #tests }
RSAbstractPlotTest >> testWithOnePlot [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	chart addPlot: p.
	self assert: chart numberOfPlots equals: 1.
	chart build.

	self assert: chart plots size equals: 1.
	self assert: chart plots first equals: p.
	self assert: p chart equals: chart
]

{ #category : #tests }
RSAbstractPlotTest >> testWithOnePlotWithTitle [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	chart addPlot: p.
	self assert: chart numberOfPlots equals: 1.
	chart title: 'Hello World'.
	chart build.

	self assert: chart plots size equals: 1.
	self assert: chart plots first equals: p.
	self assert: p chart equals: chart
]

{ #category : #tests }
RSAbstractPlotTest >> testWithOnePlotWithTitleAndTitleOnAxes [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	chart addPlot: p.
	chart xlabel: 'X Axis'.
	chart ylabel: 'Y Axis'.
	self assert: chart numberOfPlots equals: 1.
	chart title: 'Hello World'.
	chart build.

	self assert: chart plots size equals: 1.
	self assert: chart plots first equals: p.
	self assert: p chart equals: chart
]

{ #category : #tests }
RSAbstractPlotTest >> testWithTitle [

	plot title: 'Hello World'.
	plot build.

	self
		assert: (plot container shapes select: #isLabel) last text
		equals: 'Hello World'
]

{ #category : #tests }
RSAbstractPlotTest >> testWithTwoPlots [

	| p1 p2 |
	p1 := self classToTest new x: #(1 2 3) y: #(1 2 3).
	p2 := self classToTest new x: #(-1 0 1) y: #(-2 0 2).
	chart addPlot: p1.
	chart addPlot: p2.
	self assert: chart numberOfPlots equals: 2.

	self assert: chart minValueX equals: -1.
	self assert: chart maxValueX equals: 3.
	self assert: chart maxValueY equals: 3.
	self assert: chart minValueY equals: -2
]

{ #category : #tests }
RSAbstractPlotTest >> testWithoutTicks [

	plot removeAllTicks.
	plot build.

	self assert: plot horizontalTick equals: nil.
	self assert: plot verticalTick equals: nil
]

{ #category : #tests }
RSAbstractPlotTest >> testYMarker [

	| marker line |
	x := -3.14 to: 3.14 by: 0.01.
	y := x cos * 0.18.

	plot := self classToTest new.
	plot x: x y: y.

	plot horizontalTick doNotUseNiceLabel.
	plot verticalTick asFloat.

	marker := RSYMarkerDecoration new.
	plot addDecoration: marker.
	plot padding: 0 @ 0.
	plot build.

	line := marker createMarkerLineFromPlot: plot.

	self
		assert: line from
		equals: 0 @ (plot yScale scale: plot maxValueY).
	self assert: line to equals: (plot xScale scale: plot maxValueX)
		@ (plot yScale scale: plot maxValueY)
]
