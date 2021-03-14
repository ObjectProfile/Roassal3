"
TODO
"
Class {
	#name : #RSSturgesBinning,
	#superclass : #RSBinningStrategy,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #'as yet unclassified' }
RSSturgesBinning >> computeSizeFor: values [
	^ (values size log / 2 log) ceiling + 1
]
