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
