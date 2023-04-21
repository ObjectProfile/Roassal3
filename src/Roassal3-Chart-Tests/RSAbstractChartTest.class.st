Class {
	#name : #RSAbstractChartTest,
	#superclass : #RSTest,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #testing }
RSAbstractChartTest class >> isAbstract [
	^ self =  RSAbstractChartTest
]

{ #category : #tests }
RSAbstractChartTest >> classToTest [
	self subclassResponsibility
]

{ #category : #running }
RSAbstractChartTest >> setUp [
	super setUp.
	chart := RSChart new
]

{ #category : #tests }
RSAbstractChartTest >> testBasic [

	self assert: chart numberOfPlots equals: 0
]

{ #category : #tests }
RSAbstractChartTest >> testEmptyPlot [

	| p |
	p := self classToTest new x: #(0) y: #(0).
	chart addPlot: p.
	chart addDecoration: (RSVerticalTick new integer fontSize: 10; doNotUseNiceLabel).
	chart addDecoration: (RSHorizontalTick new  integer fontSize: 10; doNotUseNiceLabel).
	chart build
]

{ #category : #tests }
RSAbstractChartTest >> testOpening [
	| x |
	chart := RSChart new.
	x := 0 to: 2 by: 1 / 100.
	chart addPlot: (self classToTest new x: x y: x).
	chart addPlot: (self classToTest new x: x y: (x collect: #squared)).
	chart addPlot: (self classToTest new x: x y: (x collect: [ :v | v * v * v ])).
	chart build.
	chart show delete
]

{ #category : #tests }
RSAbstractChartTest >> testWithOnePlot [

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
RSAbstractChartTest >> testWithOnePlotWithTitle [

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
RSAbstractChartTest >> testWithOnePlotWithTitleAndTitleOnAxes [

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
RSAbstractChartTest >> testWithTwoPlots [

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
