"
TODO
"
Class {
	#name : 'RSDefaultBinning',
	#superclass : 'RSAbstractBinning',
	#instVars : [
		'numberOfBins'
	],
	#category : 'Roassal-Chart-Strategy',
	#package : 'Roassal-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSDefaultBinning >> computeNumberOfBinsFor: aCollection [
	^ self numberOfBins
]

{ #category : 'defaults' }
RSDefaultBinning >> defaultNumberOfBins [
	^ 10
]

{ #category : 'initialization' }
RSDefaultBinning >> initialize [
	super initialize.
	self numberOfBins: self defaultNumberOfBins
]

{ #category : 'accessing' }
RSDefaultBinning >> numberOfBins [
	^ numberOfBins
]

{ #category : 'accessing' }
RSDefaultBinning >> numberOfBins: aNumber [
	numberOfBins := aNumber
]
