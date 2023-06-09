Class {
	#name : #RSStatisticalMeasuresTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Statistics'
}

{ #category : #tests }
RSStatisticalMeasuresTest >> testBasicNewKernelDensity [
	| statisticalMeasures data sortedData |
	data := #(90 23 22 20 50 80 82 87 15).
	sortedData := #(15 20 22 23 50 80 82 87 90).
	statisticalMeasures := RSStatisticalMeasures data: data.
	self assert: statisticalMeasures data equals: sortedData.
]
