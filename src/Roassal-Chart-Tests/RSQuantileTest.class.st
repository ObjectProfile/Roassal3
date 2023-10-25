Class {
	#name : 'RSQuantileTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Statistics',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Statistics'
}

{ #category : 'tests' }
RSQuantileTest >> testGet025QuantileInvertedCDF [
	| aRSQuantile data |
	data := #(1 2 3 4 5 6 7 8 9 10 11 12 13).
	aRSQuantile := RSInvertedCDF data: data.
	self assert: (aRSQuantile compute: 0.25) closeTo: 4
]

{ #category : 'tests' }
RSQuantileTest >> testGet075QuantileInvertedCDF [
	| aRSQuantile data |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	aRSQuantile := RSInvertedCDF data: data.
	aRSQuantile compute: 0.75.
	self assert: (aRSQuantile compute: 0.75) closeTo: 43
]
