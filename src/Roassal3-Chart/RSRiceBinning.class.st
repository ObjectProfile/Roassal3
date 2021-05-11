"
TODO
"
Class {
	#name : #RSRiceBinning,
	#superclass : #RSBinningStrategy,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #hooks }
RSRiceBinning >> computeSizeFor: values [
	^ 2 * (values size raisedTo: 1/3)
]
