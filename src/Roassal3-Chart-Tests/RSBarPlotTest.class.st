Class {
	#name : #RSBarPlotTest,
	#superclass : #RSAbstractChartTest,
	#category : #'Roassal3-Chart-Tests'
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
		equals: extent+(vtick configuration tickSize @0).
]
