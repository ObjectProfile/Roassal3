Class {
	#name : #RSQuantileTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Statistics'
}

{ #category : #tests }
RSQuantileTest >> testGet025QuantileInvertedCDF [
	| aRSQuantile data |
	data := #(1 2 3 4 5 6 7 8 9 10 11 12 13).
	aRSQuantile := RSInvertedCDF data: data.
	self assert: (aRSQuantile compute: 0.75) closeTo: 10.
]
