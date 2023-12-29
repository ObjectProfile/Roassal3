Class {
	#name : 'RSAbstractPlotTest',
	#superclass : 'RSTest',
	#instVars : [
		'plot',
		'x',
		'y'
	],
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'testing' }
RSAbstractPlotTest class >> isAbstract [
	^ self =  RSAbstractPlotTest
]

{ #category : 'tests' }
RSAbstractPlotTest >> classToTest [
	self subclassResponsibility
]

{ #category : 'running' }
RSAbstractPlotTest >> setUp [

	super setUp.
	x := 0 to: 6 by: 0.01.
	y := x sin.
	plot := self classToTest new x: x y: y
]

{ #category : 'tests' }
RSAbstractPlotTest >> testBasic [

	plot build
]

{ #category : 'tests' }
RSAbstractPlotTest >> testExtentIsCorrect [

	plot build.

	self assert: plot extent equals: 250 @ 200
]

{ #category : 'tests' }
RSAbstractPlotTest >> testInvert [
	| xScale yScale |

	plot yLinear.
	plot xLog.
	xScale := plot xScale.
	yScale := plot yScale.
	plot invertCoordinates.
	plot build.
	self assert: plot xScale equals: yScale.
	self assert: plot yScale equals: xScale.
	self assert: plot x equals: y.
	self assert: plot y equals: x
]

{ #category : 'tests' }
RSAbstractPlotTest >> testMinMaxValue2 [

	plot := self classToTest new x: #( 4 6 9 ) y: #( -10 -13 -15 ).
	plot build.

	self assert: plot minChartValueX equals: 4.
	self assert: plot maxChartValueX equals: 9.
	self assert: plot minChartValueY equals: -15.
	self assert: plot maxChartValueY equals: -10
]

{ #category : 'tests' }
RSAbstractPlotTest >> testMustInclude0 [

	plot := self classToTest new y: #( 10 13 15 ).
	plot mustInclude0inY.
	plot build.

	self assert: plot minChartValueX equals: 1.
	self assert: plot maxChartValueX equals: 3.
	self assert: plot minChartValueY equals: 0.
	self assert: plot maxChartValueY equals: 15
]

{ #category : 'tests' }
RSAbstractPlotTest >> testMustInclude02 [

	plot := self classToTest new y: #( -10 -13 -15 ).
	plot mustInclude0inY.
	plot build.

	self assert: plot minChartValueX equals: 1.
	self assert: plot maxChartValueX equals: 3.
	self assert: plot minChartValueY equals: -15.
	self assert: plot maxChartValueY equals: 0
]

{ #category : 'tests' }
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

{ #category : 'tests' }
RSAbstractPlotTest >> testMustInclude04 [

	plot := self classToTest new y: (-3.14 to: 3.14 by: 0.1) sin.
	plot removeAllTicks.
	plot build.

	self assert: plot minValueY equals: -0.9995258306054791.
	self assert: plot maxValueY equals: 0.9999417202299663
]

{ #category : 'tests' }
RSAbstractPlotTest >> testMustInclude05 [

	plot := self classToTest new y: (-3.14 to: 3.14 by: 0.1) sin.
	plot removeAllTicks.
	plot mustInclude0inY.
	plot build.

	self assert: plot minValueY equals: -0.9995258306054791.
	self assert: plot maxValueY equals: 0.9999417202299663
]

{ #category : 'tests' }
RSAbstractPlotTest >> testPaddingIsCorrect [

	plot build.

	self assert: plot padding equals: 5 @ 5
]

{ #category : 'tests' }
RSAbstractPlotTest >> testRawdata [

	| data |
	data := { 0@1 . 1@3 . 2@3 . 3@5 . 4@6 }.
	plot := self classToTest new rawData: data x: #x y: #y.
	plot build
]

{ #category : 'tests' }
RSAbstractPlotTest >> testStylerDefault [

	| tick |
	x := -10.0 to: 20.0 count: 100.
	plot := self classToTest new x: x y: (x raisedTo: 3).
	tick := plot horizontalTick.

	self assert: plot styler textColor equals: Color black.
	self assert: tick styler textColor equals: Color black.
	self assert: plot styler equals: tick styler
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
RSAbstractPlotTest >> testWithAxisLabel [

	plot xlabel: 'X axis'.
	plot build.

	self
		assert: (plot container shapes select: #isLabel) last text
		equals: 'X axis'
]

{ #category : 'tests' }
RSAbstractPlotTest >> testWithTitle [

	plot title: 'Hello World'.
	plot build.

	self
		assert: (plot container shapes select: #isLabel) last text
		equals: 'Hello World'
]

{ #category : 'tests' }
RSAbstractPlotTest >> testWithTitleAndLabels [

	plot := self classToTest new.
	plot y: #( 2 2 ).
	plot addDecoration: (RSChartTitleDecoration new
			 title: 'Reward evolution';
			 fontSize: 20).
	plot xlabel: 'Episode' offset: 0 @ 10.
	plot ylabel: 'Reward' offset: -20 @ 0.
	plot build
]

{ #category : 'tests' }
RSAbstractPlotTest >> testWithoutTicks [

	plot removeAllTicks.
	plot build.

	self assert: plot horizontalTick equals: nil.
	self assert: plot verticalTick equals: nil
]

{ #category : 'tests' }
RSAbstractPlotTest >> testYMarker [

	| marker line |
	plot horizontalTick doNotUseNiceLabel.
	plot verticalTick asFloat.

	marker := RSYMarkerDecoration new.
	plot addDecoration: marker.
	plot padding: 0 @ 0.
	plot build.

	line := marker createMarkerLineFromPlot: plot.

	self assert: plot maxValueY =~ 1.
	self
		assert: line from
		equals: 0 @ (plot yScale scale: 1).
	self assert: line to equals: (plot xScale scale: plot maxValueX)
		@ (plot yScale scale: 1)
]
