"
TODO
"
Class {
	#name : #RSSturgesBinning,
	#superclass : #RSAbstractBinning,
	#category : #'Roassal-Chart-Strategy'
}

{ #category : #hooks }
RSSturgesBinning >> computeNumberOfBinsFor: aCollection [
	^ (aCollection size log / 2 log) ceiling + 1
]
