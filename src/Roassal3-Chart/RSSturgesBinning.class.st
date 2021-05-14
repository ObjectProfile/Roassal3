"
TODO
"
Class {
	#name : #RSSturgesBinning,
	#superclass : #RSBinningStrategy,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #hooks }
RSSturgesBinning >> computeSizeFor: values [
	^ (values size log / 2 log) ceiling + 1
]
