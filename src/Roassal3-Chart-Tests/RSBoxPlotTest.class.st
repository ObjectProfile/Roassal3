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
	| boxPlot data boxes window firstDatasetQ1 |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	firstDatasetQ1 := boxPlot statisticalMeasures first quartiles first.
	window := boxPlot open.
	boxes := boxPlot boxes.
	self assert: boxes first class equals: RSPolygon.
	self assert: boxPlot boxesPoints first first y closeTo: firstDatasetQ1. 
	window close.
]

{ #category : #tests }
RSBoxPlotTest >> testCreateBoxesOneBox [
	| boxPlot data boxes window firstDatasetQ1 |
	data := { 1. 2. 3. 4. 5. } .
	boxPlot := RSBoxPlot data: data.
	firstDatasetQ1 := boxPlot statisticalMeasures quartiles first.
	window := boxPlot open.
	boxes := boxPlot boxes.
	self assert: boxes first class equals: RSPolygon.
	self assert: boxPlot boxesPoints first first y closeTo: firstDatasetQ1.
]

{ #category : #tests }
RSBoxPlotTest >> testCreateCenterLines [
	| boxPlot data window firstDatasetUpperLimit centerLines |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	firstDatasetUpperLimit := boxPlot statisticalMeasures first upperLimit.
	self assert: boxPlot upperLimits first closeTo: firstDatasetUpperLimit.
	window := boxPlot open.
	centerLines := boxPlot centerLines.
	self assert: centerLines first class equals: RSPolyline.
	self assert: boxPlot centerLinesPoints first first y closeTo: firstDatasetUpperLimit.
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testCreateMedianLines [
	| boxPlot data medianLines window firstDatasetMedian |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	firstDatasetMedian := boxPlot statisticalMeasures first median.
	self assert: boxPlot medians first closeTo: firstDatasetMedian.
	window := boxPlot open.
	medianLines := boxPlot medianLines.
	self assert: medianLines first class equals: RSPolyline.
	self assert: boxPlot medianLinesPoints first first y closeTo: firstDatasetMedian.
	window delete.
]

{ #category : #tests }
RSBoxPlotTest >> testCreateOutliers [
	| boxPlot data outliers window lastDatasetOutliers |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := RSBoxPlot data: data.
	lastDatasetOutliers := boxPlot statisticalMeasures last outliers.
	self assert: boxPlot outliersValues last closeTo: lastDatasetOutliers.
	window := boxPlot open.
	outliers := boxPlot outliers.
	self assert: outliers last first class equals: RSEllipse.
	self assert: boxPlot outliersPoints last first y closeTo: lastDatasetOutliers first.
	window delete.
]
