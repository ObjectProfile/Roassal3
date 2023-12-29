Class {
	#name : 'RSHistogramPlotTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Core',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSHistogramPlotTest >> testBasic [
	| values plot |
	values := #(1 2 3 4 5 6 7 8 9 10).
	plot := RSHistogramPlot new x: values.
	plot build.
	self assert: plot bars size equals: 10.
	self assert: plot xValues equals: (1 to: 10 count: 11).
	self assert: (plot yValues allSatisfy: [ :v | v = 1 ])
]

{ #category : 'tests' }
RSHistogramPlotTest >> testBinSize [
	| values plot size |
	values := (1 to: 100) shuffled.
	plot := RSHistogramPlot new x: values; binSize: 30.
	plot build.
	size := (plot binningStrategy computeNumberOfBinsFor: values sorted).
	self assert: plot bars size equals: size
]

{ #category : 'tests' }
RSHistogramPlotTest >> testBins [
	| values plot |
	values := #(1 2 3 4 5 6 7 8 9 10).
	plot := RSHistogramPlot new x: values; numberOfBins: 2.
	self deny: plot bins isNil.
	self assert: plot numberOfBins equals: 2.
	plot build.
	self assert: plot bars size equals: 2.
	self assert: plot bins equals: (1 to: 10 count: 3).
	self assert: plot xValues equals: (1 to: 10 count: 3).
	self assert: (plot yValues allSatisfy: [ :v | v = 5 ])
]

{ #category : 'tests' }
RSHistogramPlotTest >> testBinsCollection [
	| values plot bins |
	bins := #(1 5 8 10).
	values := #(1 2 3 4 5 6 7 8 9 10).
	plot := RSHistogramPlot new x: values; bins: bins.
	self assert: plot bins equals: bins.
	plot build.
	self assert: plot bars size equals: 3.
	self assert: plot bins equals: bins.
	self assert: plot xValues equals: bins.
	self assert: plot yValues equals: #(4 3 3)
]

{ #category : 'tests' }
RSHistogramPlotTest >> testBinsStrat [
	| values plot strategy size |
	strategy := RSSturgesBinning new.
	values := (1 to: 100) shuffled.
	plot := RSHistogramPlot new x: values; binningStrategy: strategy.
	plot build.
	size := (strategy computeNumberOfBinsFor: values).
	self assert: plot bars size equals: size.
	self assert: plot xValues equals: (1 to: 100 by: 99/size)
]

{ #category : 'tests' }
RSHistogramPlotTest >> testCollectDataOfOn [

	| col plot |
	col := 1 to: 10.
	plot := RSHistogramPlot new.

	plot collectDataOf: col on: [ :e | e % 4 ]; numberOfBins: 4.

	self assert: plot x equals: #(0 0 1 1 1 2 2 2 3 3).
	self assert: plot map equals: (Dictionary newFrom: { 1->1. 2->2. 3->3. 4->0. 5->1. 6->2. 7->3. 8->0. 9->1. 10->2 })
]

{ #category : 'tests' }
RSHistogramPlotTest >> testModelWithCollectedData [

	| col plot bars |
	col := 1 to: 10.
	plot := RSHistogramPlot new.

	plot collectDataOf: col on: [ :e | e % 4 ]; numberOfBins: 4.
	plot build.
	bars := plot bars.

	self assert: (plot bars at:1) model sorted equals: #(4 8).
	self assert: (plot bars at:2) model sorted equals: #(1 5 9).
	self assert: (plot bars at:3) model sorted equals: #(2 6 10).
	self assert: (plot bars at:4) model sorted equals: #(3 7)
]

{ #category : 'tests' }
RSHistogramPlotTest >> testModelWithRawValues [

	| plot bars |
	plot := RSHistogramPlot new.

	plot x: #(0 1 3 3 1 1); bins: (0 to: 4).
	plot build.
	bars := plot bars.

	self assert: (plot bars at:1) model equals: 0->1->1.
	self assert: (plot bars at:2) model equals: 1->2->3.
	self assert: (plot bars at:3) model equals: 2->3->0.
	self assert: (plot bars at:4) model equals: 3->4->2
]
