Class {
	#name : #RSHistogramPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSHistogramPlotTest >> testBasic [
	| c values plot |
	c := RSChart new.
	values := #(1 2 3 4 5 6 7 8 9 10).
	c addPlot: (plot := RSHistogramPlot new x: values).
	c build.
	self assert: plot bars size equals: 10.
	self assert: plot xValues equals: (1 to: 10 count: 11).
	self assert: (plot yValues allSatisfy: [ :v | v = 1 ]).
	
]

{ #category : #tests }
RSHistogramPlotTest >> testBins [
	| c values plot |
	c := RSChart new.
	values := #(1 2 3 4 5 6 7 8 9 10).
	c addPlot: (plot := RSHistogramPlot new x: values; bins: 2).
	c build.
	self assert: plot bars size equals: 2.
	self assert: plot xValues equals: (1 to: 10 count: 3).
	self assert: (plot yValues allSatisfy: [ :v | v = 5 ]).
	
]

{ #category : #tests }
RSHistogramPlotTest >> testBinsCollection [
	| c values plot |
	c := RSChart new.
	values := #(1 2 3 4 5 6 7 8 9 10).
	c addPlot: (plot := RSHistogramPlot new x: values; bins: #(1 5 8 10)).
	c build.
	self assert: plot bars size equals: 3.
	self assert: plot xValues equals: #(1 5 8 10).
	self assert: plot yValues equals: #(4 3 3).
	
]

{ #category : #tests }
RSHistogramPlotTest >> testBinsStrat [
	| c values plot |
	c := RSChart new.
	values := (1 to: 100) shuffled.
	c addPlot: (plot := RSHistogramPlot new x: values; binningStrategy: RSSturgesBinning new).
	c build.
	self assert: plot bars size equals: 10.
	self assert: plot xValues equals: (1 to: 100 by: 99/10).
	self assert: plot yValues equals: (Array new: 10 withAll: 10).
	
]
