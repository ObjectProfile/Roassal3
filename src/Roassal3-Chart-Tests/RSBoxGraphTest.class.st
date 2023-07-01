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
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	self assert: boxGraph xScale class equals: NSLinearScale.
	self assert: boxGraph yScale class equals: NSLinearScale.
	self assert: (boxGraph scalePoint: aPoint) class equals: Point.
]

{ #category : #tests }
RSBoxGraphTest >> testBoxGraphHasStatisticalMeasures [
	| boxGraph data |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	self assert: boxGraph statisticalMeasures class equals: RSStatisticalMeasures.
	self assert: boxGraph median closeTo: 3 precision: 4.
]

{ #category : #tests }
RSBoxGraphTest >> testBoxPointsWithCenterAt [
	| boxGraph data boxPoints q1 q3 |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	q1 := boxGraph statisticalMeasures quartiles at: 1.
	q3 := boxGraph statisticalMeasures quartiles at: 3.
	boxPoints := boxGraph boxPointsWithCenterAt: 1.
	self assert: boxPoints size equals: 4.
	self assert: boxPoints first y equals: q1.
	self assert: boxPoints last y equals: q3.
]

{ #category : #tests }
RSBoxGraphTest >> testBoxWithCenterAt [
	| boxGraph data  box aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	box := boxGraph boxWithCenterAt: 1.
	self assert: box class equals: RSPolygon.
	self assert: box points size equals: 4.
]

{ #category : #tests }
RSBoxGraphTest >> testCenterLinePointsWithCenterAt [
	| boxGraph data centerLinePoints upperLimit lowerLimit |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	upperLimit := boxGraph statisticalMeasures upperLimit.
	lowerLimit := boxGraph statisticalMeasures lowerLimit.
	centerLinePoints := boxGraph centerLinePointsWithCenterAt: 1.
	self assert: centerLinePoints size equals: 2.
	self assert: centerLinePoints first y equals: upperLimit.
	self assert: centerLinePoints second y equals: lowerLimit.
]

{ #category : #tests }
RSBoxGraphTest >> testCenterLineWithCenterAt [
	| boxGraph data  centerLine aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	centerLine := boxGraph centerLineWithCenterAt: 1.
	self assert: centerLine class equals: RSPolyline.
]

{ #category : #tests }
RSBoxGraphTest >> testDefaultBoxWidth [
	| boxGraph data|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	self assert: boxGraph boxWidth closeTo: 0.7 precision: 1.
]

{ #category : #tests }
RSBoxGraphTest >> testDefaultGraphCenter [
	| boxGraph data|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	self assert: boxGraph graphCenter equals: 1.
]

{ #category : #tests }
RSBoxGraphTest >> testMedianLinePointsWithCenterAt [
	| boxGraph data  median medianPoints|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	median := boxGraph statisticalMeasures quartiles at: 2.
	medianPoints := boxGraph medianLinePointsWithCenterAt: 1.
	self assert: medianPoints size equals: 2.
	self assert: medianPoints first y equals: median.
]

{ #category : #tests }
RSBoxGraphTest >> testMedianLineWithCenterAt [
	| boxGraph data  medianLine aScale |
	data := { 1. 2. 3. 4. 5. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	medianLine := boxGraph medianLineWithCenterAt: 1.
	self assert: medianLine class equals: RSPolyline.
]

{ #category : #tests }
RSBoxGraphTest >> testOutliers [
	| boxGraph data  aScale outliers |
	data := { 12. 12. 13. 14. 15. 24. }.
	aScale := NSLinearScale new.
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	outliers := boxGraph outliers.
	self assert: outliers size equals: 1.
	self assert: outliers first class equals: RSEllipse.
]

{ #category : #tests }
RSBoxGraphTest >> testOutliersPoints [
	| boxGraph data outliersPoints outliersValues |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxGraph := RSBoxGraph data: data.
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
	boxGraph := RSBoxGraph data: data scales: {aScale. aScale }.
	shapes := boxGraph shapesWithCenterAt: 1.
	centerLineX := shapes first controlPoints first x.
	self assert: shapes size equals: 4.
	shapes := boxGraph shapesWithCenterAt: 2.
	newCenterLineX := shapes first controlPoints first x.
	self assert: centerLineX < newCenterLineX.
]
