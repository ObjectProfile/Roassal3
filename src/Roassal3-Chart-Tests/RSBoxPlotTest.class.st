Class {
	#name : #RSBoxPlotTest,
	#superclass : #RSTest,
	#instVars : [
		'plot',
		'y'
	],
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #running }
RSBoxPlotTest >> setUp [

	super setUp.
	plot := RSBoxPlot new.
	y := {
		     { 1. 2. 3. 4. }.
		     { 3. 4. 5. 6. } }.
	plot y: y
]

{ #category : #'tests - adding' }
RSBoxPlotTest >> testAdd3BoxPlotsReturnsClusterChart [
	| boxPlotA boxPlotB boxPlotC data chart |
	
	data := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	boxPlotA := RSBoxPlot data: data.
	boxPlotB := RSBoxPlot data: data.
	boxPlotC := RSBoxPlot data: data.
	
	chart := boxPlotA + boxPlotB + boxPlotC.
	self assert: chart class equals: RSClusterChart.
	self assert: chart plots size equals: 3.
]

{ #category : #'tests - adding' }
RSBoxPlotTest >> testAddBoxPlotAndLinePlotReturnsChart [
	| boxPlot linePlot data x y chart |
	
	x := { 1. 2. }.
	y := { 5. 6. }.
	linePlot := RSLinePlot x: x y: y.
	
	data := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	boxPlot := RSBoxPlot data: data.
	
	chart := boxPlot + linePlot.
	
	self assert: chart class equals: RSCompositeChart.
	self assert: chart plots size equals: 2.
]

{ #category : #'tests - adding' }
RSBoxPlotTest >> testAddBoxPlotsAddPlotsInTheChart [
	| boxPlotA boxPlotB dataA dataB chart |
	
	dataA := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	dataB := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	boxPlotA := RSBoxPlot data: dataA.
	boxPlotB := RSBoxPlot data: dataB.
	chart := boxPlotA + boxPlotB.
	self assert: chart plots first identicalTo: boxPlotA.
	self assert: chart plots second identicalTo: boxPlotB.
]

{ #category : #'tests - adding' }
RSBoxPlotTest >> testAddBoxPlotsReturnsNewChart [
	| boxPlotA boxPlotB dataA dataB chart |
	
	dataA := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	dataB := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	boxPlotA := RSBoxPlot data: dataA.
	boxPlotB := RSBoxPlot data: dataB.
	chart := boxPlotA + boxPlotB.
	self assert: chart class equals: RSClusterChart.
	self assert: chart plots size equals: 2.
]

{ #category : #'tests - adding' }
RSBoxPlotTest >> testAddLinePlotAndBoxPlotReturnsChart [
	| boxPlot linePlot data x y chart |
	x := { 1. 2. }.
	y := { 5. 6. }.
	linePlot := RSLinePlot x: x y: y.
	
	data := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	boxPlot := RSBoxPlot data: data.
	
	chart := linePlot + boxPlot.
	self assert: chart class equals: RSCompositeChart.
	self assert: chart plots size equals: 2.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotCreatedWithCollectionOfDatasets [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	self assert: boxPlot boxShapes size equals: 3.
	self assert: boxPlot boxShapes first class equals: RSBoxPlotShape.
	self assert: boxPlot boxShapes first data equals: data first.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotCreatedWithData [
	| boxPlot data |
	data := { 1. 2. 3. 4. 5. }.
	boxPlot := RSBoxPlot data: data.
	self assert: boxPlot boxShapes first class equals: RSBoxPlotShape.
	self assert: boxPlot boxShapes first data equals: data.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotWithOneBoxShape [
	| p y window |
	y := { 12. 12. 13. 14. 15. 24. }.
	p := RSBoxPlot data: y.
	self assert: p boxShapes size equals: 1.
	self assert: p boxShapes first class equals: RSBoxPlotShape.
	window := p open.
	self assert: p createdShapes notEmpty.
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxShouldBeInsideContainerRectangle [
	| boxPlot data chart box chartBox categories window |
	data := { { 1. 2. 3. 4. 5. } . "A"
			 { 5. 6. 7. 5. 10. }  . "B"
			 { 12. 12. 13. 14. 15. 24. } "C"  }.
	categories := { 'A'. 'B'. 'C' }.
	boxPlot := RSBoxPlot data: data.
	boxPlot xTickLabels: categories.
	window := boxPlot open.
	chart := boxPlot chart.
	chartBox := chart spine encompassingRectangle.
	boxPlot boxShapes do: [ :eachBoxShape |
		box := eachBoxShape box.
		self assert: box class equals: RSPolygon.
		self assert: (chartBox containsRect: box encompassingRectangle).
	].
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalIsOk [

	| median iqr interval n |
	y := {
		     { 1. 2. 3. 4. 5 }. }.
	plot y: y.
	plot notch: true.
	plot build.
	median := plot median.
	iqr := plot iqr.
	interval := plot medianConfidenceInterval.
	n := y first size.
	self assert: interval max equals: median + (1.57 * iqr/(n sqrt)).
	self assert: interval min equals: median - (1.57 * iqr/(n sqrt))
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMaxIsGreaterThanQuartile3 [

	| confidenceIntervalMax quartile3 |
	y := { { 1. 2. 3. 4. 5 }. }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMax := plot medianConfidenceInterval max.
	quartile3 := plot quartiles third.

	self assert: confidenceIntervalMax > quartile3.
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMaxIsLesserThanQuartile3 [

	| confidenceIntervalMax quartile3 |
	y := {{ 1. 2. 3. 4. 5. 1. 2. 3. 4. 5. 1. 2. 3. 4. 5 }.}.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMax := plot medianConfidenceInterval max.
	quartile3 := plot quartiles third.

	self assert: confidenceIntervalMax < quartile3
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMinIsGreaterThanQuartile1 [

	| confidenceIntervalMin quartile1 |
	y := { { 1. 2. 3. 4. 5. 1. 2. 3. 4. 5. 1. 2. 3. 4. 5 }. }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMin := plot medianConfidenceInterval min.
	quartile1 := plot quartiles first.

	self assert: confidenceIntervalMin > quartile1
]

{ #category : #tests }
RSBoxPlotTest >> testConfidenceIntervalMinIsLesserThanQuartile1 [

	| confidenceIntervalMin quartile1 |
	y := {{ 1. 2. 3. 4. 5 }. }.
	plot y: y.
	plot notch: true.
	plot build.
	confidenceIntervalMin := plot medianConfidenceInterval min.
	quartile1 := plot quartiles first.

	self assert: confidenceIntervalMin < quartile1
]

{ #category : #tests }
RSBoxPlotTest >> testConfidencePercentageIsCorrectlyChanged [

	plot confidencePercentage: 99.
	plot build.

	self assert: plot confidencePercentage first equals: 99
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultConfidencePercentageIs95 [

	plot y: {
			{ 1. 2 }.
			{ 3. 4 } }.
			
	self assert: plot confidencePercentage first equals: 95.
	self assert: plot confidencePercentage second equals: 95
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultPlotColors [
	| boxPlot data chart boxColor window |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	window := boxPlot open.
	chart := boxPlot chart.
	window delete.
	boxColor := chart colorFor: boxPlot.
	boxPlot boxShapes do: [ :box |
		self assert: box color equals: boxColor.
	].
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultXTickLabels [
	| boxPlot data chart horizontalTick xTickLabels window |
	self skip.
	data := { { 1. 2. 3. 4. 5. } . "1"
			 { 5. 6. 7. 5. 10. }  . "2"
			 { 12. 12. 13. 14. 15. 24. } "3"  }.
	xTickLabels := { '1'. '2'. '3'.}.
	boxPlot := RSBoxPlot data: data.
	window := boxPlot open.
	chart := boxPlot chart.
	window delete.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: xTickLabels.
]

{ #category : #tests }
RSBoxPlotTest >> testNotchBasic [

	plot notch: true.
	
	plot build
]

{ #category : #tests }
RSBoxPlotTest >> testNumberOfBoxes [
	| boxPlot data boxes window |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	window := boxPlot open.
	boxes := boxPlot boxShapes.
	self assert: boxPlot numberOfBoxes equals: 3.
	self assert: boxPlot boxShapes size equals: boxPlot numberOfBoxes. 
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testXTickLabels [
	| boxPlot data chart categories horizontalTick yTickLabels window |
	data := { { 1. 2. 3. 4. 5. } . "A"
			 { 5. 6. 7. 5. 10. }  . "B"
			 { 12. 12. 13. 14. 15. 24. } "C"  }.
	categories := { 'A'. 'B'. 'C' }.
	yTickLabels := { '-5'. 'zero'. '10'. '30' }.
	boxPlot := RSBoxPlot data: data.
	boxPlot xTickLabels: categories.
	window := boxPlot open.
	chart := boxPlot chart.
	window delete.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: categories.
]

{ #category : #tests }
RSBoxPlotTest >> testYTickLabels [
	| boxPlot data chart categories horizontalTick yTickLabels window |
	data := { { 1. 2. 3. 4. 5. } . "A"
			 { 5. 6. 7. 5. 10. }  . "B"
			 { 12. 12. 13. 14. 15. 24. } "C"  }.
	categories := { 'A'. 'B'. 'C' }.
	yTickLabels := { '-5'. 'zero'. '10'. '30' }.
	boxPlot := RSBoxPlot data: data.
	boxPlot xTickLabels: categories.
	boxPlot yTicks: #(-5 0 10 30) labels: yTickLabels.
	window := boxPlot open.
	chart := boxPlot chart.
	window delete.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: categories.
]
