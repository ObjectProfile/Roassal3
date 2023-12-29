"
I am class used to bins: in RSHistogramPlot
"
Class {
	#name : 'RSFixedBinning',
	#superclass : 'RSAbstractBinning',
	#instVars : [
		'bins'
	],
	#category : 'Roassal-Chart-Strategy',
	#package : 'Roassal-Chart',
	#tag : 'Strategy'
}

{ #category : 'accessing' }
RSFixedBinning >> bins [

	^ bins
]

{ #category : 'accessing' }
RSFixedBinning >> bins: aCollection [

	bins := aCollection
]

{ #category : 'hooks' }
RSFixedBinning >> computeNumberOfBinsFor: aCollection [
	^ bins size
]

{ #category : 'hooks' }
RSFixedBinning >> createBinsFor: aCollection [
	^ bins
]
