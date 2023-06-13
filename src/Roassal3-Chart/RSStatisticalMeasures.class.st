Class {
	#name : #RSStatisticalMeasures,
	#superclass : #RSObject,
	#instVars : [
		'data',
		'quantile'
	],
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #accessing }
RSStatisticalMeasures class >> data: aDataset [
	| statisticalMeasures |
	statisticalMeasures := self new.
	statisticalMeasures data: aDataset.
	statisticalMeasures quantile: statisticalMeasures defaultQuantile.
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

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> defaultQuantile [
	^ (RSInvertedCDF data: data).
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> interQuartileRange [
	| quartiles q1 q3 |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	^ q3 - q1.
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> lowerLimit [
	| quartiles q1 q3 iqr |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	iqr := self interQuartileRange.
	^ q1 - (1.5 * iqr).
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> mean [
	| sum |
	sum := 0.
	data do: [ :xi | sum := sum + xi ].
	^ (sum / (data size)).
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> median [
	^ self median: data.
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> median: aDataset [
	| medianIndex medianValue isSizeEven |
	isSizeEven := aDataset size even.
	medianIndex := (aDataset size / 2) ceiling.
	medianValue := isSizeEven
		               ifTrue: [((aDataset at: medianIndex) + (aDataset at: (medianIndex + 1))) / 2 ]
		               ifFalse: [ aDataset at: medianIndex ].
	^ medianValue
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> quantile: aRSQuantileSubclass [
	quantile := aRSQuantileSubclass.
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> quartiles [
	| q1 q2 q3 |
	q1 := quantile compute: 0.25.
	q2 := quantile compute: 0.50.
	q3 := quantile compute: 0.75.
	^  { q1. q2. q3 }.
]

{ #category : #'accessing - computed' }
RSStatisticalMeasures >> upperLimit [
	| quartiles q1 q3 iqr |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	iqr := self interQuartileRange.
	^ q3 + (1.5 * iqr).
]
