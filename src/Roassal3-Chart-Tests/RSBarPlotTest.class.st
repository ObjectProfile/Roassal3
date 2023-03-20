Class {
	#name : #RSBarPlotTest,
	#superclass : #RSAbstractChartTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSBarPlotTest >> classToTest [
	^ RSBarPlot
]

{ #category : #tests }
RSBarPlotTest >> test2BarPlots [
	| d1 d2 extent vtick |
	d1 := #(4 10 5 9).
	d2 := #(-5 -6 -3 -3 ).
	extent := chart extent.
	chart addPlot: (RSBarPlot new y: d1).
	chart addPlot: (RSBarPlot new y: d2).
	vtick := RSVerticalTick new withNoLabels.
	chart addDecoration: vtick.
	chart build.
	self
		assert: chart canvas encompassingRectangle extent
		equals: extent+(vtick configuration tickSize @0)
]

{ #category : #tests }
RSBarPlotTest >> testHorizontalBar [
	| c p x y |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSHorizontalBarPlot new x: x y: y.

	self deny: p isVerticalBarPlot.
	self assert: p isHorizontalBarPlot.
	c addPlot: p.
	c build.
	self assert: (p bars allSatisfy: [ :shape |
		 shape height closeTo: p bars anyOne height ])
]

{ #category : #tests }
RSBarPlotTest >> testVerticalBar [
	| c p x y |
	x := 0.0 to: 2 count: 10.
	y := (x raisedTo: 2) - 2.
	c := RSChart new.
	p := RSBarPlot new x: x y: y.

	self assert: p isVerticalBarPlot.
	self deny: p isHorizontalBarPlot.
	c addPlot: p.
	c addDecoration: (RSVerticalTick new
		numberOfTicks: 10;
		asFloat).
	c build.
	self assert: (p bars allSatisfy: [ :shape |
		 shape width closeTo: p bars anyOne width ])
]
