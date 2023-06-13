Class {
	#name : #RSStatisticalMeasuresTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Statistics'
}

{ #category : #tests }
RSStatisticalMeasuresTest >> testBasicStatisticalMeasures [
	| statisticalMeasures data sortedData |
	data := #(90 23 22 20 50 80 82 87 15).
	sortedData := #(15 20 22 23 50 80 82 87 90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures data equals: sortedData.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetInterQuartileRange [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures interQuartileRange closeTo: (43 - 15).
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetLowerLimit [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures lowerLimit closeTo: -27.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMeanOfDataset [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: (statisticalMeasures mean) closeTo: 52.1111.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMeanOfDatasetSizeOne [
	| statisticalMeasures data |
	data := #(90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures mean equals: 90.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMedianOfDatasetSizeOne [
	| statisticalMeasures data |
	data := #(90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median equals: 90.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMedianOfEvenDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15 95).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median closeTo: 50.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMedianOfOddDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median equals: 50.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetQuartilesOfEvenDatasetSize [
	| statisticalMeasures data |
	data := #(7 15 36 39 40 41).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(15 36 40).
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetQuartilesOfOddDatasetSize [
	| statisticalMeasures data |
	data := #(1 2 3 4 5 6 7 8 9 10 11 12 13).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(4 7 10).
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetQuartilesOfOddDatasetSize2 [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(15 40 43).
]
