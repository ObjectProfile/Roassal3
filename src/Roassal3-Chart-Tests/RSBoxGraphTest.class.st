Class {
	#name : #RSBoxGraphTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSBoxGraphTest >> testBoxGraphComputeBoxPoints [
	| boxGraph data boxPoints q1 q3 |
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	q1 := boxGraph statisticalMeasures quartiles at: 1.
	q3 := boxGraph statisticalMeasures quartiles at: 3.
	boxPoints := boxGraph computeBoxPoints: data boxCenterAt: 1.
	self assert: boxPoints size equals: 4.
	self assert: boxPoints first y equals: q1.
	self assert: boxPoints last y equals: q3.
]

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
RSBoxGraphTest >> testDefaultBoxWidth [
	| boxGraph data|
	data := { 1. 2. 3. 4. 5. }.
	boxGraph := RSBoxGraph data: data.
	self assert: boxGraph boxWidth closeTo: 0.7 precision: 1.
]
