"
TODO
"
Class {
	#name : #RSRiceBinning,
	#superclass : #RSBinningStrategy,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #'as yet unclassified' }
RSRiceBinning >> computeSizeFor: values [
	^ 2 * (values size raisedTo: 1/3)
]
