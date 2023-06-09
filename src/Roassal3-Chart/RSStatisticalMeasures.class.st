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

{ #category : #accessing }
RSStatisticalMeasures >> mean [
	| sum |
	sum := 0.
	data do: [ :xi | sum := sum + xi ].
	^ (sum / (data size)).
]

{ #category : #accessing }
RSStatisticalMeasures >> median [
	| medianIndex medianValue isSizeEven |
	isSizeEven := data size even.
	medianIndex := (data size / 2) ceiling.
	medianValue := isSizeEven
		               ifTrue: [((data at: medianIndex) + (data at: (medianIndex + 1))) / 2 ]
		               ifFalse: [ data at: medianIndex ].
	^ medianValue
]
