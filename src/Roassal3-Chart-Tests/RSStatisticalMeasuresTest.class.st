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
RSStatisticalMeasuresTest >> testGetMeanOfDataset [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: (statisticalMeasures mean) closeTo: 52.1111.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMedianOfEvenDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15 95).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median closeTo: (50+80)/2.
]

{ #category : #tests }
RSStatisticalMeasuresTest >> testGetMedianOfOddDatasetSize [
	| statisticalMeasures data |
	data := #(90 23 22 20 50 80 82 87 15).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures median equals: 50.
]
