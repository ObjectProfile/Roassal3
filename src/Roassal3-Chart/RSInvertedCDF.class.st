Class {
	#name : #RSInvertedCDF,
	#superclass : #RSQuantile,
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #initialize }
RSInvertedCDF >> compute: populationPercentage [
	| m j g n|
	n := data size.
	m := 0.
	j := ((populationPercentage * n) + m)//1.
	g := (populationPercentage * n) + m - j.
	^ ((1 - (self gama: g)) * (data at: j)) + ((self gama: g)*(data at:(j+1))).
]

{ #category : #initialize }
RSInvertedCDF >> gama: g [
	| ans | 
	(g > 0) ifTrue: [ ans := 1 ]. 
	(g = 0) ifTrue: [ ans := 0 ].
	^ ans.
]
