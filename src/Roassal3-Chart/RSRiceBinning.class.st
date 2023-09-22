"
TODO
"
Class {
	#name : 'RSRiceBinning',
	#superclass : 'RSAbstractBinning',
	#category : 'Roassal3-Chart-Strategy',
	#package : 'Roassal3-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSRiceBinning >> computeNumberOfBinsFor: aCollection [
	^ 2 * (aCollection size raisedTo: 1/3)
]
