"
source from

https://www.answerminer.com/blog/binning-guide-ideal-histogram
"
Class {
	#name : #RSBinningStrategy,
	#superclass : #RSObject,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #'as yet unclassified' }
RSBinningStrategy >> computeSizeFor: values [
	^ self subclassResponsibility
]
