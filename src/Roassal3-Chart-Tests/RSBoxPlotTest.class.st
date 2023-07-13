Class {
	#name : #RSBoxPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

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
	self assert: chart class equals: RSChart.
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
	self assert: chart class equals: RSChart.
	self assert: chart plots size equals: 2.
]

{ #category : #tests }
RSBoxPlotTest >> testBasicBoxPlot [
	| c p y window |

	y := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	c := RSChart new.
	p := RSBoxPlot new y: y.

	c addPlot: p.

	c horizontalTick numberOfTicks: y size.
	c xlabel: 'X Axis'.
	c verticalTick numberOfTicks: 10;
		asFloat.
	c ylabel: 'Y Axis'.
	c title: 'Box Plot'.
	window := c open.
	self assert: p createdShapes notEmpty.
	window delete.
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
RSBoxPlotTest >> testDefaultPlotColors [
	| boxPlot data chart boxColor |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	chart := boxPlot buildChart.
	boxColor := chart colorFor: boxPlot.
	boxPlot boxShapes do: [ :box |
		self assert: box color equals: boxColor.
	].
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultXTickLabels [
	| boxPlot data chart horizontalTick xTickLabels |
	data := { { 1. 2. 3. 4. 5. } . "1"
			 { 5. 6. 7. 5. 10. }  . "2"
			 { 12. 12. 13. 14. 15. 24. } "3"  }.
	xTickLabels := { '1'. '2'. '3'.}.
	boxPlot := RSBoxPlot data: data.
	chart := boxPlot buildChart.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: xTickLabels.
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
	| boxPlot data chart categories horizontalTick yTickLabels |
	data := { { 1. 2. 3. 4. 5. } . "A"
			 { 5. 6. 7. 5. 10. }  . "B"
			 { 12. 12. 13. 14. 15. 24. } "C"  }.
	categories := { 'A'. 'B'. 'C' }.
	yTickLabels := { '-5'. 'zero'. '10'. '30' }.
	boxPlot := RSBoxPlot data: data.
	boxPlot xTickLabels: categories.
	chart := boxPlot buildChart.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: categories.
]

{ #category : #tests }
RSBoxPlotTest >> testYTickLabels [
	| boxPlot data chart categories horizontalTick yTickLabels |
	data := { { 1. 2. 3. 4. 5. } . "A"
			 { 5. 6. 7. 5. 10. }  . "B"
			 { 12. 12. 13. 14. 15. 24. } "C"  }.
	categories := { 'A'. 'B'. 'C' }.
	yTickLabels := { '-5'. 'zero'. '10'. '30' }.
	boxPlot := RSBoxPlot data: data.
	boxPlot xTickLabels: categories.
	boxPlot yTicks: #(-5 0 10 30) labels: yTickLabels.
	chart := boxPlot buildChart.
	horizontalTick := chart horizontalTick.
	self assert: (horizontalTick labels collect: [ :label | label text ]) equals: categories.
]
