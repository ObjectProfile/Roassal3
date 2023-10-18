"
TODO
"
Class {
	#name : 'RSRiceBinning',
	#superclass : 'RSAbstractBinning',
	#category : 'Roassal-Chart-Strategy',
	#package : 'Roassal-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSRiceBinning >> computeNumberOfBinsFor: aCollection [
	^ 2 * (aCollection size raisedTo: 1/3)
]
