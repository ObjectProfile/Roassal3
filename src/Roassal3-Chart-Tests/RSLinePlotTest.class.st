Class {
	#name : #RSLinePlotTest,
	#superclass : #RSAbstractChartTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSLinePlotTest >> classToTest [
	^ RSLinePlot
]

{ #category : #tests }
RSLinePlotTest >> testDefaultValues [
	| p |
	p := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	p ylabel: 'Some numbers'.
	p xlabel: 'X label'.
 	chart := p buildChart.
	self assert: chart extent equals: 250 @ 200.
	self assert: chart padding equals: 15 @ 10.
]

{ #category : #tests }
RSLinePlotTest >> testMarkerShape [
	| circleMarkersPlot squareMarkersPlot |
	circleMarkersPlot := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	squareMarkersPlot := (RSLinePlot y: #(1 2 3 4)) format: 's-r'.
	self assert: (circleMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 'o') class name.
	self deny: (circleMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 's') class name.
	self assert: (squareMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 's') class name.
]

{ #category : #tests }
RSLinePlotTest >> testMarkerSize [
	| p |
	p := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	chart := p buildChart.
	"Is it correct that buildChart modify and return attributes of plot?"
	self assert: p shape markerStart shape extent equals: 4@4
]

{ #category : #tests }
RSLinePlotTest >> testPlotWithOneCollection [
	| p window |
	p := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	p ylabel: 'Some numbers'.
	p xlabel: 'X label'.
 	window := p open.
	self assert: p y equals: #(1 2 3 4).
	self assert: p x equals: #(1 2 3 4).
	self assert: p format equals: 'o-r'.
	self assert: p ylabel equals: 'Some numbers'.
	self assert: p xlabel equals: 'X label'.
	self assert: window isDisplayed.
	window delete.
	self flag: 'Add title and rename format2'
]
