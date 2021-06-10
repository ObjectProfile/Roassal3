"
source from

https://www.answerminer.com/blog/binning-guide-ideal-histogram
"
Class {
	#name : #RSAbstractBinning,
	#superclass : #RSObject,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #hooks }
RSAbstractBinning >> computeSizeFor: values [
	^ self subclassResponsibility
]
