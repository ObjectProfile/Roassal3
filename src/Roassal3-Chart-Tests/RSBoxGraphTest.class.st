Class {
	#name : #RSBoxGraphTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSBoxGraphTest >> testBox [
	| boxGraph data  box aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	box := boxGraph box.
	self assert: box class equals: RSPolygon.
	self assert: box points size equals: 4.
]

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
RSBoxGraphTest >> testBoxPoints [
	| boxGraph data boxPoints q1 q3 |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	q1 := boxGraph statisticalMeasures quartiles at: 1.
	q3 := boxGraph statisticalMeasures quartiles at: 3.
	boxPoints := boxGraph boxPoints.
	self assert: boxPoints size equals: 4.
	self assert: boxPoints first y equals: q1.
	self assert: boxPoints last y equals: q3.
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
RSBoxGraphTest >> testCenterLine [
	| boxGraph data  centerLine aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	centerLine := boxGraph centerLine.
	self assert: centerLine class equals: RSPolyline.
]

{ #category : #tests }
RSBoxGraphTest >> testCenterLinePoints [
	| boxGraph data centerLinePoints upperLimit lowerLimit |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	upperLimit := boxGraph statisticalMeasures upperLimit.
	lowerLimit := boxGraph statisticalMeasures lowerLimit.
	centerLinePoints := boxGraph centerLinePoints.
	self assert: centerLinePoints size equals: 2.
	self assert: centerLinePoints first y equals: upperLimit.
	self assert: centerLinePoints second y equals: lowerLimit.
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
RSBoxGraphTest >> testDefaultBoxWidth [
	| boxGraph data|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph boxWidth closeTo: 0.7.
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
RSBoxGraphTest >> testMedianLine [
	| boxGraph data  medianLine aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	medianLine := boxGraph medianLine.
	self assert: medianLine class equals: RSPolyline.
]

{ #category : #tests }
RSBoxGraphTest >> testMedianLinePoints [
	| boxGraph data  median medianPoints|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxPlotShape data: data.
	median := boxGraph statisticalMeasures quartiles at: 2.
	medianPoints := boxGraph medianLinePoints.
	self assert: medianPoints size equals: 2.
	self assert: medianPoints first y equals: median.
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
RSBoxGraphTest >> testOutliers [
	| boxGraph data  aScale outliers |
	data := { 12. 12. 13. 14. 15. 24. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	outliers := boxGraph outliers.
	self assert: outliers size equals: 1.
	self assert: outliers first class equals: RSEllipse.
]

{ #category : #tests }
RSBoxGraphTest >> testOutliersPoints [
	| boxGraph data outliersPoints outliersValues |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	outliersValues := boxGraph statisticalMeasures outliers.
	outliersPoints := boxGraph outliersPoints.
	self assert: outliersPoints size equals: 1.
	self assert: outliersPoints first y equals: outliersValues first.
]

{ #category : #tests }
RSBoxGraphTest >> testShapesWithCenterAt [
	| boxGraph data  shapes aScale centerLineX newCenterLineX |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxPlotShape data: data scales: {aScale. aScale }.
	shapes := boxGraph shapesWithCenterAt: 1.
	centerLineX := shapes first controlPoints first x.
	self assert: shapes size equals: 4.
	shapes := boxGraph shapesWithCenterAt: 2.
	newCenterLineX := shapes first controlPoints first x.
	self assert: centerLineX < newCenterLineX.
]

{ #category : #tests }
RSBoxGraphTest >> testUpperLimit [
	| boxGraph data   |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxPlotShape data: data.
	self assert: boxGraph upperLimit closeTo: 15 precision: 1.
]
