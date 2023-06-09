Class {
	#name : #RSStatisticalMeasures,
	#superclass : #RSObject,
	#instVars : [
		'data'
	],
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #accessing }
RSStatisticalMeasures class >> data: aDataset [
	| statisticalMeasures |
	statisticalMeasures := self new.
	statisticalMeasures data: aDataset.
	^ statisticalMeasures
]

{ #category : #accessing }
RSStatisticalMeasures >> data [
	^ data
]

{ #category : #accessing }
RSStatisticalMeasures >> data: aDataset [
	data := aDataset copy sort.
]
