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
	self assert: (plot yValues allSatisfy: [ :v | v = 1 ])
]

{ #category : #tests }
RSHistogramPlotTest >> testBinSize [
	| c values plot size |
	c := RSChart new.
	values := (1 to: 100) shuffled.
	c addPlot: (plot := RSHistogramPlot new x: values; binSize: 30).
	c build.
	size := (plot binningStrategy computeNumberOfBinsFor: values sorted).
	self assert: plot bars size equals: size
]

{ #category : #tests }
RSHistogramPlotTest >> testBins [
	| c values plot |
	c := RSChart new.
	values := #(1 2 3 4 5 6 7 8 9 10).
	c addPlot: (plot := RSHistogramPlot new x: values; numberOfBins: 2).
	self deny: plot bins isNil.
	self assert: plot numberOfBins equals: 2.
	c build.
	self assert: plot bars size equals: 2.
	self assert: plot bins equals: (1 to: 10 count: 3).
	self assert: plot xValues equals: (1 to: 10 count: 3).
	self assert: (plot yValues allSatisfy: [ :v | v = 5 ])
]

{ #category : #tests }
RSHistogramPlotTest >> testBinsCollection [
	| c values plot bins |
	c := RSChart new.
	bins := #(1 5 8 10).
	values := #(1 2 3 4 5 6 7 8 9 10).
	c addPlot: (plot := RSHistogramPlot new x: values; bins: bins).
	self assert: plot bins equals: bins.
	c build.
	self assert: plot bars size equals: 3.
	self assert: plot bins equals: bins.
	self assert: plot xValues equals: bins.
	self assert: plot yValues equals: #(4 3 3)
]

{ #category : #tests }
RSHistogramPlotTest >> testBinsStrat [
	| c values plot strategy size |
	c := RSChart new.
	strategy := RSSturgesBinning new.
	values := (1 to: 100) shuffled.
	c addPlot: (plot := RSHistogramPlot new x: values; binningStrategy: strategy).
	c build.
	size := (strategy computeNumberOfBinsFor: values).
	self assert: plot bars size equals: size.
	self assert: plot xValues equals: (1 to: 100 by: 99/size)
]
