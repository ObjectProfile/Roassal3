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
	vtick := chart verticalTick withNoLabels.
	chart removeHorizontalTicks.
	chart build.
	chart open.
	self
		assert: chart canvas encompassingRectangle extent
		equals: extent+(vtick configuration tickSize @0)
]

{ #category : #tests }
RSBarPlotTest >> testAdd2BarPlotsToCluster [
	| d1 d2 x barPlot1 barPlot2 clusterChart plotsInClusterChart |
	x := 0.0 to: 2 count: 10.
	d1 := (x raisedTo: 2) - 2.
	d2 := d1 + 05.
	barPlot1 := RSBarPlot new y: d1.
	barPlot2 := RSBarPlot new y: d2.
	clusterChart := barPlot1 + barPlot2.
	plotsInClusterChart := clusterChart elements select: [ :element | element isPlot ].
	self assert: plotsInClusterChart size equals: 2.
	clusterChart open.
	self deny: plotsInClusterChart first barSize equals: plotsInClusterChart second barSize.
	self deny: plotsInClusterChart first barOffset equals: plotsInClusterChart second barOffset.
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
	c verticalTick numberOfTicks: 10;
		asFloat.
	c build.
	self assert: (p bars allSatisfy: [ :shape |
		 shape width closeTo: p bars anyOne width ])
]
