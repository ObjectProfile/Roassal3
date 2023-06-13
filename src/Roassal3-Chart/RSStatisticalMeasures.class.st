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
RSStatisticalMeasures >> quartiles [

	| q1 q2 q3 medianIndex isSizeEven leftHalf rightHalf |
	isSizeEven := self data size even.
	q2 := self median.
	medianIndex := data size + 1 // 2.
	leftHalf := isSizeEven
		            ifTrue: [ data copyFrom: 1 to: medianIndex ]
		            ifFalse: [ data copyFrom: 1 to: medianIndex - 1 ].
	rightHalf := data copyFrom: medianIndex + 1 to: data size.
	q1 := self median: leftHalf.
	q3 := self median: rightHalf.
	^ {
		  q1.
		  q2.
		  q3 }
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