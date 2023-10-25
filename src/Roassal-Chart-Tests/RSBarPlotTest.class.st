Class {
	#name : 'RSBarPlotTest',
	#superclass : 'RSTest',
	#instVars : [
		'x',
		'y',
		'plot'
	],
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'running' }
RSBarPlotTest >> setUp [

	super setUp.
	x := 0 to: 6 by: 0.1.
	y := x sin.
	plot := RSBarPlot new x: x y: y
]

{ #category : 'tests' }
RSBarPlotTest >> test2BarPlots [
	| d1 d2 extent vtick width |
	d1 := #(4 10 5 9).
	d2 := #(-5 -6 -3 -3 ).
	plot := RSBarPlot new y: d1.
	extent := plot extent.
	vtick := plot verticalTick withNoLabels.
	plot removeHorizontalTicks.
	plot build.
	width := plot spine border width.
	self
		assert: plot canvas encompassingRectangle extent
		equals: extent+(vtick configuration tickSize @0)+(width / 2 @ width)
]

{ #category : 'running' }
RSBarPlotTest >> testBasic [

	plot build
]

{ #category : 'tests' }
RSBarPlotTest >> testDoubleBarPlotRawData [

	| data |
	data := { #(1 2 3). #(2 3 4) . #(-3 5 -7) }.
	plot := RSDoubleBarPlot new rawData: data x1: #first x2: #second y: #third.
	plot build
]

{ #category : 'running' }
RSBarPlotTest >> testExtentIsCorrect [

	plot build.

	self assert: plot extent equals: 250 @ 200
]

{ #category : 'tests' }
RSBarPlotTest >> testHorizontalBar [

	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	plot := RSHorizontalBarPlot new x: x y: y.

	self deny: plot isVerticalBarPlot.
	self assert: plot isHorizontalBarPlot.
	plot build.
	self assert: (plot bars allSatisfy: [ :shape |
		 shape height closeTo: plot bars anyOne height ])
]

{ #category : 'running' }
RSBarPlotTest >> testMinMaxValue2 [

	plot := RSBarPlot new x: #( 4 6 9 ) y: #( -10 -13 -15 ).
	plot build.

	self assert: plot minChartValueX equals: 4.
	self assert: plot maxChartValueX equals: 9.
	self assert: plot minChartValueY equals: -15.
	self assert: plot maxChartValueY equals: 0
]

{ #category : 'running' }
RSBarPlotTest >> testPaddingIsCorrect [

	plot build.

	self assert: plot padding equals: 5 @ 5
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerDefault [

	| tick |
	tick := plot horizontalTick.

	self assert: plot styler textColor equals: Color black.
	self assert: tick styler textColor equals: Color black.
	self assert: plot styler equals: tick styler
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerRedLabel [

	| tick styler |
	tick := plot horizontalTick.
	styler := RSChartStyler new textColor: Color red.
	tick styler: styler.
	plot build.

	self assert:
		(tick labels allSatisfy: [ :line | line color = Color red ])
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerRedTick [

	| tick styler |
	tick := plot horizontalTick.
	styler := RSChartStyler new tickColor: Color red.
	tick styler: styler.
	plot build.

	self assert:
		(tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerRedTickInChart [

	| tick styler |
	tick := plot horizontalTick.
	styler := RSChartStyler new tickColor: Color red.
	plot styler: styler.
	plot build.

	self assert:
		(tick ticks allSatisfy: [ :line | line color = Color red ])
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerSpineRed [

	| styler spine |
	styler := RSChartStyler new spineColor: Color red.
	spine := plot spineDecoration.
	plot styler: styler.
	plot build.

	self assert: spine box border color equals: Color red
]

{ #category : 'tests' }
RSBarPlotTest >> testStylerTitleLabel [

	| title styler |
	styler := RSChartStyler new textColor: Color red.
	title := plot title: 'Chart'.
	plot styler: styler.
	plot build.

	self assert: title label color equals: Color red
]

{ #category : 'tests' }
RSBarPlotTest >> testVerticalBar [
	| p |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	p := RSBarPlot new x: x y: y.

	self assert: p isVerticalBarPlot.
	self deny: p isHorizontalBarPlot.
	p verticalTick numberOfTicks: 10;
		asFloat.
	p build.
	self assert: (p bars allSatisfy: [ :shape |
		 shape width closeTo: p bars anyOne width ])
]

{ #category : 'tests' }
RSBarPlotTest >> testWithTilteAndLabels [

	plot addDecoration: (RSChartTitleDecoration new
			 title: 'Reward evolution';
			 fontSize: 20).
	plot xlabel: 'Episode' offset: 0 @ 10.
	plot ylabel: 'Reward' offset: -20 @ 0.
	plot build
]

{ #category : 'tests' }
RSBarPlotTest >> testWithoutTicks [

	plot removeAllTicks.
	plot build.

	self assert: plot horizontalTick equals: nil.
	self assert: plot verticalTick equals: nil
]
