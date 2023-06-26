Class {
	#name : #RSBoxPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

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
	self assert: boxPlot statisticalMeasures size equals: 3.
	self assert: boxPlot statisticalMeasures first class equals: RSStatisticalMeasures.
	self assert: boxPlot statisticalMeasures first data equals: data first.
	self assert: boxPlot data first equals: data first.
]

{ #category : #tests }
RSBoxPlotTest >> testBoxPlotCreatedWithData [
	| boxPlot data |
	data := { 1. 2. 3. 4. 5. }.
	boxPlot := RSBoxPlot data: data.
	self assert: boxPlot statisticalMeasures class equals: RSStatisticalMeasures.
	self assert: boxPlot statisticalMeasures data equals: data.
	self assert: boxPlot data first equals: data first.
]

{ #category : #tests }
RSBoxPlotTest >> testComputeBoxPoints [
	| boxPlot data boxPoints q1 q3 |
	data := { 1. 2. 3. 4. 5. }.
	boxPlot := RSBoxPlot data: data.
	q1 := boxPlot statisticalMeasures quartiles at: 1.
	q3 := boxPlot statisticalMeasures quartiles at: 3.
	boxPoints := boxPlot computeBoxPoints: data.
	self assert: boxPoints size equals: 4.
	self assert: boxPoints first y equals: q1.
	self assert: boxPoints last y equals: q3.
]

{ #category : #tests }
RSBoxPlotTest >> testComputeBoxesPoints [
	| boxPlot data boxesPoints firstDatasetQ1 firstDatasetQ3 |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	boxesPoints := boxPlot computeBoxesPoints.
	self assert: boxesPoints size equals: 3.
	self assert: boxesPoints first size equals: 4.
	firstDatasetQ1 := boxPlot statisticalMeasures first quartiles at: 1.
	firstDatasetQ3 := boxPlot statisticalMeasures first quartiles at: 3.
	self assert: boxesPoints first first y equals: firstDatasetQ1.
	self assert: boxesPoints first last y equals: firstDatasetQ3.
]

{ #category : #tests }
RSBoxPlotTest >> testCreateBoxes [
	| boxPlot data boxes window |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	window := boxPlot open.
	boxes := boxPlot boxes.
	self assert: boxes first class equals: RSPolygon.
	window delete.
]
