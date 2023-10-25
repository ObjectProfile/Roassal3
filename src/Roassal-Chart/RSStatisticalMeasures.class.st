Class {
	#name : 'RSStatisticalMeasures',
	#superclass : 'RSObject',
	#instVars : [
		'data',
		'quantile',
		'confidencePercentage'
	],
	#category : 'Roassal-Chart-Statistics',
	#package : 'Roassal-Chart',
	#tag : 'Statistics'
}

{ #category : 'accessing' }
RSStatisticalMeasures class >> data: aDataset [
	| statisticalMeasures |
	statisticalMeasures := self new.
	statisticalMeasures data: aDataset.
	statisticalMeasures quantile: statisticalMeasures defaultQuantile.
	statisticalMeasures confidencePercentage: 95.
	^ statisticalMeasures
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> confidenceInterval [
	| confidenceProbability |
	confidenceProbability := confidencePercentage / 100.
	^ { quantile compute: (1-confidenceProbability). quantile compute: confidenceProbability. }
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> confidencePercentage [
	^ confidencePercentage
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> confidencePercentage: aPercentage [

	confidencePercentage := aPercentage
]

{ #category : 'accessing' }
RSStatisticalMeasures >> data [
	^ data
]

{ #category : 'accessing' }
RSStatisticalMeasures >> data: aDataset [
	data := aDataset copy sort
]

{ #category : 'accessing' }
RSStatisticalMeasures >> defaultQuantile [
	^ (RSInvertedCDF data: data)
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> interQuartileRange [
	| quartiles q1 q3 |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	^ q3 - q1
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> iqr [
	| q1 q3 |
	q1 := quantile compute: 0.25.
	q3 := quantile compute: 0.75.
	^  (q3 - q1)
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> lowerLimit [
	| quartiles q1 q3 iqr iqr15 |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	iqr := self interQuartileRange.
	iqr15 := q1 - (1.5 * iqr).
	^ (data select: [ :d | d >= iqr15 ]) min
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> mean [
	| sum |
	sum := 0.
	data do: [ :xi | sum := sum + xi ].
	^ (sum / (data size))
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> median [
	^ self median: data
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> median: aDataset [
	^ quantile compute: 0.5
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> medianConfidenceInterval [
	| notchFactors delta median iqr |
	notchFactors := Dictionary newFrom: {
			                (90 -> 1.28).
			                (95 -> 1.57).
			                (99 -> 1.81) }.
	iqr := self iqr.
	delta := (notchFactors at: confidencePercentage) * iqr / (data size sqrt).
	median := self median.
	^  { median - delta. median + delta}
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> outliers [
	| outlierValues lowerLimit upperLimit iterator |
	outlierValues := OrderedCollection new.
	lowerLimit := self lowerLimit.
	upperLimit := self upperLimit.
	iterator := 1.
	[(data at:iterator)<lowerLimit] whileTrue: [
		outlierValues add: (data at:iterator).
		iterator := iterator + 1 ].
	iterator := data size.
	[(data at:iterator)>upperLimit] whileTrue: [
		outlierValues add: (data at:iterator).
		iterator := iterator - 1].
	^ outlierValues
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> quantile: aRSQuantileSubclass [
	quantile := aRSQuantileSubclass
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> quartiles [
	| q1 q2 q3 |
	q1 := quantile compute: 0.25.
	q2 := quantile compute: 0.50.
	q3 := quantile compute: 0.75.
	^  { q1. q2. q3 }
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> standardDeviation [
	| standardDeviation sum mean |
	sum := 0.
	mean := self mean.
	data do: [ :observationX | sum := sum + ((observationX - mean) squared) ].
	standardDeviation := (mean/(data size)) sqrt.
	^ standardDeviation
]

{ #category : 'accessing - computed' }
RSStatisticalMeasures >> upperLimit [
	| quartiles q1 q3 iqr iqr15 |
	quartiles := self quartiles.
	q1 := quartiles at: 1.
	q3 := quartiles at: 3.
	iqr := self interQuartileRange.
	iqr15 := q3 + (1.5 * iqr).
	^ (data select: [ :d | d <= iqr15 ]) max
]
