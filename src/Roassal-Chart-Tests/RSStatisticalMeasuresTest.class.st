Class {
	#name : 'RSStatisticalMeasuresTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Statistics',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Statistics'
}

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testBasicStatisticalMeasures [
	| statisticalMeasures data sortedData |
	data := #(90 23 22 20 50 80 82 87 15).
	sortedData := #(15 20 22 23 50 80 82 87 90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures data equals: sortedData
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testConfidenceInterval [

	| median iqr data sm|
	data := { 30. 37. 36. 43. 42. 43. 43. 46. 41. 42 }.
	sm := RSStatisticalMeasures data: data.
	median := sm median.
	iqr := sm iqr.
	self assert: median closeTo: 42.
	self assert: sm confidenceInterval max equals: 46.
	self assert: sm confidenceInterval min equals: 30
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetInterQuartileRange [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures interQuartileRange closeTo: (43 - 15)
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetLowerLimit [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures lowerLimit closeTo: 6
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetMeanOfDataset [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: (statisticalMeasures mean) closeTo: 52.1111
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetMeanOfDatasetSizeOne [
	| statisticalMeasures data |
	data := #(90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures mean equals: 90
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetMedianOfDatasetSizeOne [
	| statisticalMeasures data |
	data := #(90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median equals: 90
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetMedianOfEvenDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15 95).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median closeTo: 50
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetMedianOfOddDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median equals: 50
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetQuartilesOfEvenDatasetSize [
	| statisticalMeasures data |
	data := #(7 15 36 39 40 41).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(15 36 40)
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetQuartilesOfOddDatasetSize [
	| statisticalMeasures data |
	data := #(1 2 3 4 5 6 7 8 9 10 11 12 13).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(4 7 10)
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testGetQuartilesOfOddDatasetSize2 [
	| statisticalMeasures data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures quartiles closeTo: #(15 40 43)
]

{ #category : 'tests' }
RSStatisticalMeasuresTest >> testOutliers [
	| statisticalMeasures data |
	data := { 12. 12. 13. 14. 15. 24. }.
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures upperLimit closeTo: 15.
	self assert: statisticalMeasures outliers closeTo: #(24)
]
