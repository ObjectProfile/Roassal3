Class {
	#name : #RSBoxGraphTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSBoxGraphTest >> testBoxGraphHasScales [
	| boxGraph data aPoint aScale |
	data := { 1. 2. 3. 4. 5. }.
	aPoint := 1@1.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data.
	boxGraph scales: {aScale. aScale }.
	self assert: boxGraph xScale class equals: NSLinearScale.
	self assert: boxGraph yScale class equals: NSLinearScale.
	self assert: (boxGraph scalePoint: aPoint) class equals: Point.
]

{ #category : #tests }
RSBoxGraphTest >> testBoxGraphHasStatisticalMeasures [
	| boxGraph data |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph statisticalMeasures class equals: RSStatisticalMeasures.
	self assert: boxGraph median closeTo: 3 precision: 4.
]

{ #category : #tests }
RSBoxGraphTest >> testCenter [
	| boxGraph data  center aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	center := boxGraph center.
	self assert: center equals: 1.
]

{ #category : #tests }
RSBoxGraphTest >> testColor [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	boxGraph color: Color red.
	self assert: boxGraph color equals: Color red.
]

{ #category : #tests }
RSBoxGraphTest >> testData [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph data equals: data.
]

{ #category : #tests }
RSBoxGraphTest >> testDefaultGraphCenter [
	| boxGraph data|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph graphCenter equals: 1.
]

{ #category : #tests }
RSBoxGraphTest >> testLowerLimit [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph lowerLimit closeTo: 12 precision: 1.
]

{ #category : #tests }
RSBoxGraphTest >> testMaxYValueIsOutlier [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph maxYValue equals: 24.
]

{ #category : #tests }
RSBoxGraphTest >> testMaxYValueIsUpperLimit [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph maxYValue equals: 15.
]

{ #category : #tests }
RSBoxGraphTest >> testMinYValueIsLowerLimit [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph minYValue equals: 12.
]

{ #category : #tests }
RSBoxGraphTest >> testOutlierValues [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph outlierValues size equals: 1.
	self assert: boxGraph outlierValues first equals: 24.
]

{ #category : #tests }
RSBoxGraphTest >> testUpperLimit [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph upperLimit closeTo: 15 precision: 1.
]
