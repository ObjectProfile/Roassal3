Class {
	#name : 'RSScatterPlotTest',
	#superclass : 'RSAbstractPlotTest',
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
RSScatterPlotTest >> classToTest [
	^ RSScatterPlot
]

{ #category : 'tests' }
RSScatterPlotTest >> testCreateScatterPlot [
	| scatterPlot xScale yScale |
	scatterPlot := RSScatterPlot new.
	x:= -3.14 to: 3.14 by: 0.1.
	y := x sin * 0.22 + 0.5.
	scatterPlot x: x y: y.
	scatterPlot yLinear.
	scatterPlot xLog.
	xScale := scatterPlot xScale.
	yScale := scatterPlot yScale.
	scatterPlot invertCoordinates.
	self assert: scatterPlot xScale equals: yScale.
	self assert: scatterPlot yScale equals: xScale.
	self assert: scatterPlot x equals: y.
	self assert: scatterPlot y equals: x
]
