"
TODO
"
Class {
	#name : #RSRiceBinning,
	#superclass : #RSAbstractBinning,
	#category : #'Roassal3-Chart-Strategy'
}

{ #category : #hooks }
RSRiceBinning >> computeSizeFor: values [
	^ 2 * (values size raisedTo: 1/3)
]
