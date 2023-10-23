Class {
	#name : 'RSCompositeChartTest',
	#superclass : 'RSTest',
	#instVars : [
		'chart'
	],
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'running' }
RSCompositeChartTest >> setUp [

	super setUp.
	chart := RSCompositeChart new
]

{ #category : 'running' }
RSCompositeChartTest >> testAddAll [

	| p1 p2 plots x1 x2 |
	x1 := 1 to: 5 by: 0.1.
	x2 := -6 to: -2 by: 0.1.
	p1 := RSLinePlot new x: x1 y: x1 squared.
	p2 := RSLinePlot new x: x2 y: x2 squared.
	plots := { p1. p2 }.

	chart addAll: plots.

	chart build
]

{ #category : 'running' }
RSCompositeChartTest >> testExtentIsCorrect [

	| plot x |
	plot := RSLinePlot new x: (x := 1 to: 5 by: 0.1) y: x sin.
	chart add: plot.
	chart extent: 250 @ 200.

	chart build.

	self assert: plot extent equals: 250 @ 200
]

{ #category : 'running' }
RSCompositeChartTest >> testMinMaxValuesAreCorrect [

	| p1 p2 x1 x2 |
	x1 := 1 to: 5 by: 0.1.
	x2 := -6 to: -2 by: 0.1.
	p1 := RSLinePlot new x: x1 y: x1 squared.
	p2 := RSLinePlot new x: x2 y: x2 squared.
	chart
		add: p1;
		add: p2.
	chart verticalTick doNotUseNiceLabel.
	chart horizontalTick doNotUseNiceLabel.

	chart build.

	self assert: chart minChartValueX equals: -6.
	self assert: chart minChartValueY equals: 1.
	self assert: chart maxChartValueX equals: 5.
	self assert: chart maxChartValueY equals: 36
]

{ #category : 'running' }
RSCompositeChartTest >> testPaddingIsCorrect [

	| plot x |
	plot := RSLinePlot new x: (x := 1 to: 5 by: 0.1) y: x sin.
	chart add: plot.
	chart padding: 0 @ 0.

	chart build.

	self assert: plot padding equals: 0 @ 0
]

{ #category : 'running' }
RSCompositeChartTest >> testXScaleIsCorrect [

	| p1 p2 x1 x2 |
	x1 := 1 to: 5 by: 0.1.
	x2 := -6 to: -2 by: 0.1.
	p1 := RSLinePlot new x: x1 y: x1 squared.
	p2 := RSLinePlot new x: x2 y: x2 squared.
	chart
		add: p1;
		add: p2.
	chart verticalTick doNotUseNiceLabel.
	chart horizontalTick doNotUseNiceLabel.

	chart build.

	self assert: p1 xScale domain equals: #( -6 5 ).
	self assert: p2 xScale domain equals: #( -6 5 )
]

{ #category : 'running' }
RSCompositeChartTest >> testYScaleIsCorrect [

	| p1 p2 x1 x2 |
	x1 := 1 to: 5 by: 0.1.
	x2 := -6 to: -2 by: 0.1.
	p1 := RSLinePlot new x: x1 y: x1 squared.
	p2 := RSLinePlot new x: x2 y: x2 squared.
	chart
		add: p1;
		add: p2.
	chart verticalTick doNotUseNiceLabel.
	chart horizontalTick doNotUseNiceLabel.

	chart build.

	self assert: p1 yScale domain equals: #( 1 36 ).
	self assert: p2 yScale domain equals: #( 1 36 )
]
