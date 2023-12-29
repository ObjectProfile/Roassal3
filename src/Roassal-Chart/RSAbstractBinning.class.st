"
source from

https://www.answerminer.com/blog/binning-guide-ideal-histogram
"
Class {
	#name : 'RSAbstractBinning',
	#superclass : 'RSObject',
	#category : 'Roassal-Chart-Strategy',
	#package : 'Roassal-Chart',
	#tag : 'Strategy'
}

{ #category : 'hooks' }
RSAbstractBinning >> computeNumberOfBinsFor: aCollection [
	" should return a number"
	^ self subclassResponsibility
]

{ #category : 'hooks' }
RSAbstractBinning >> createBinsFor: aCollection [
	| size |
	size := self computeNumberOfBinsFor: aCollection.
	"an adjust"
	size := size + 1.
	^ aCollection first to: aCollection last count: size
]
