"
I am an strategy used by RSHistogramPlot by the method binSize:
"
Class {
	#name : 'RSBinSizeBinning',
	#superclass : 'RSAbstractBinning',
	#instVars : [
		'size'
	],
	#category : 'Roassal-Chart-Strategy',
	#package : 'Roassal-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSBinSizeBinning >> computeNumberOfBinsFor: aCollection [
	^ (self createBinsFor: aCollection) size - 1
]

{ #category : 'hooks' }
RSBinSizeBinning >> createBinsFor: aCollection [
	| interval |
	interval := aCollection first to: aCollection last by: size.
	^ interval last < aCollection last
		ifTrue: [ interval , { aCollection last } ]
		ifFalse: [ interval ]
]

{ #category : 'accessing' }
RSBinSizeBinning >> size [

	^ size
]

{ #category : 'accessing' }
RSBinSizeBinning >> size: anObject [

	size := anObject
]
