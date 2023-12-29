Class {
	#name : 'RSLinePlotTest',
	#superclass : 'RSAbstractPlotTest',
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
RSLinePlotTest >> classToTest [
	^ RSLinePlot
]

{ #category : 'tests' }
RSLinePlotTest >> testDefaultValues [
	| p |
	p := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	p ylabel: 'Some numbers'.
	p xlabel: 'X label'.
	p build.
	self assert: p extent equals: 250 @ 200.
	self assert: p padding equals: 5 @ 5
]

{ #category : 'tests' }
RSLinePlotTest >> testLineStroke [
	| p |
	p := RSLinePlot y: #(1 2 3 4).

	p format: '--'.
	p build.
	self assert: p border style equals: (RSStrokeStyle fromString: '--').

	p format: '-.'.
	p build.
	self assert: p border style equals: (RSStrokeStyle fromString: '-.').

	p format: '.'.
	p build.
	self assert: p border style equals: (RSStrokeStyle fromString: '.')
]

{ #category : 'tests' }
RSLinePlotTest >> testMarkerShape [
	| circleMarkersPlot squareMarkersPlot |
	circleMarkersPlot := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	squareMarkersPlot := (RSLinePlot y: #(1 2 3 4)) format: 's-r'.
	self assert: (circleMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 'o') class name.
	self deny: (circleMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 's') class name.
	self assert: (squareMarkersPlot marker) shape class name equals: (RSShapeFactory shapeFromString: 's') class name
]

{ #category : 'tests' }
RSLinePlotTest >> testMarkerSize [
	| p |
	p := (RSLinePlot y: #(1 2 3 4)) format: 'o-r'.
	p build.
	"Is it correct that buildChart modify and return attributes of plot?"
	self assert: p shape markerStart shape baseRectangle extent equals: 4@4
]

{ #category : 'tests' }
RSLinePlotTest >> testMinMaxValue [

	plot := RSLinePlot new y: #(10 13 15).
	plot build.
	self assert: plot minValueX equals: 1.
	self assert: plot maxValueX equals: 3.
	self assert: plot minValueY equals: 10.
	self assert: plot maxValueY equals: 15
]

{ #category : 'tests' }
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

{ #category : 'tests' }
RSLinePlotTest >> testWithWeirdValuesLine [

	| values line canvas |
	values := {
		          Float infinity negated.
		          Float infinity negated.
		          0.30102999566398114.
		          0.47712125471966244 }.
	plot := RSLinePlot new y: values.
	plot removeAllTicks.
	plot build.
	canvas := plot canvas.

	self assert: canvas numberOfShapes equals: 2.
	self assert: canvas shapes first class equals: RSBox.

	line := canvas shapes second.

	self assert: line controlPoints size equals: 2
]

{ #category : 'tests' }
RSLinePlotTest >> testWithWeirdValuesLineWithTicks [

	| values line canvas |
	values := {
		          Float infinity negated.
		          Float infinity negated.
		          0.30102999566398114.
		          0.47712125471966244 }.
	plot := RSLinePlot new y: values.
	plot build.
	canvas := plot canvas.

	self assert: canvas numberOfShapes equals: 20.
	self assert: canvas shapes first class equals: RSBox.

	line := canvas shapes second.

	self assert: line controlPoints size equals: 2
]

{ #category : 'tests' }
RSLinePlotTest >> testWithWeirdValuesLineWithTicks2 [

	| canvas labels |
	x := { -5. 0. 1. 2 }.
	y := x log.

	plot := RSLinePlot new x: x y: y.
	plot verticalTick doNotUseNiceLabel.
	plot removeHorizontalTicks.
	plot build.

	self assert: plot minValueX equals: x min.
	self assert: plot minValueY equals: 0. "Here is y min negative infinity but Roassal puts a 0"

	self assert: plot maxValueX equals: x max.
	self assert: plot maxValueY equals: y max.

	canvas := plot canvas.

	labels := canvas shapes select: [ :s | s class == RSLabel ].

	self assert: labels first position y <= 0
]
