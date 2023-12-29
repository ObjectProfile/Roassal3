"
TODO
"
Class {
	#name : 'RSSturgesBinning',
	#superclass : 'RSAbstractBinning',
	#category : 'Roassal3-Chart-Strategy',
	#package : 'Roassal3-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSSturgesBinning >> computeNumberOfBinsFor: aCollection [
	^ (aCollection size log / 2 log) ceiling + 1
]
