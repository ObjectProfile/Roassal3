Class {
	#name : #RSBoxPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSBoxPlotTest >> testAddBoxPlotsToGroup [
	| groupA groupB groupC dataA dataB windowA windowB windowOfAdd boxPlot |
	dataA := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	dataB := { { 1. 2. 3. 4. 5. }. { 3. 2. 4. 5. 6. } }.
	groupA := RSBoxPlot data: dataA.
	groupB := RSBoxPlot data: dataB.
	groupC := RSBoxPlot data: dataB.
	windowA := groupA open.
	windowA delete.
	windowB := groupB open.
	windowB delete.
	boxPlot := groupA + groupB + groupC.
	self assert: boxPlot boxGraphics size equals: 6.
	windowOfAdd := boxPlot open.
	windowOfAdd delete.
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
	self assert: boxPlot boxGraphics size equals: 3.
	self assert: boxPlot boxGraphics first class equals: RSBoxGraph.
	self assert: boxPlot boxGraphics first data equals: data first.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotCreatedWithData [
	| boxPlot data |
	data := { 1. 2. 3. 4. 5. }.
	boxPlot := RSBoxPlot data: data.
	self assert: boxPlot boxGraphics first class equals: RSBoxGraph.
	self assert: boxPlot boxGraphics first data equals: data.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotWithOneBoxGraph [
	| p y window |
	y := { 12. 12. 13. 14. 15. 24. }.
	p := RSBoxPlot data: y.
	self assert: p boxGraphics size equals: 1.
	self assert: p boxGraphics first class equals: RSBoxGraph.
	window := p open.
	self assert: p createdShapes notEmpty.
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testDefaultPlotColors [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	boxPlot buildChart.
	self assert: (boxPlot defaultPlotColors scale: 1) equals: (NSScale category20 scale: 1).
]

{ #category : #tests }
RSBoxPlotTest >> testGroupsOfOneBoxGraph [
	| boxPlot data firstBoxGraphGroup |
	data := { 1. 2. 3. 4. 5. }.
	boxPlot := RSBoxPlot data: data.
	self assert: boxPlot groups size equals: 1.
	firstBoxGraphGroup := boxPlot groups first.
	self assert: firstBoxGraphGroup class equals: RSBoxGraphGroup.
	self assert: firstBoxGraphGroup boxGraphics size equals: 1.
	self assert: firstBoxGraphGroup boxGraphics first class equals: RSBoxGraph.
]

{ #category : #tests }
RSBoxPlotTest >> testNumberOfBoxes [
	| boxPlot data boxes window |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	window := boxPlot open.
	boxes := boxPlot boxGraphics.
	self assert: boxPlot numberOfBoxes equals: 3.
	self assert: boxPlot boxGraphics size equals: boxPlot numberOfBoxes. 
	window delete.
]
