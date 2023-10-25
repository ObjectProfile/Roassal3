Class {
	#name : 'RSInvertedCDF',
	#superclass : 'RSQuantile',
	#category : 'Roassal-Chart-Statistics',
	#package : 'Roassal-Chart',
	#tag : 'Statistics'
}

{ #category : 'initialize' }
RSInvertedCDF >> compute: populationPercentage [
	| m j g n|
	n := data size.
	(n = 1) ifTrue: [ ^ data at: 1 ].
	m := 0.
	j := ((populationPercentage * n) + m).
	j := j//1.
	j = 0 ifTrue: [ j := 1 ].
	g := (populationPercentage * n) + m - j.
	^ ((1 - (self gama: g)) * (data at: j)) + ((self gama: g)*(data at:(j+1)))
]

{ #category : 'initialize' }
RSInvertedCDF >> gama: g [
	| ans |
	ans := nil.
	(g > 0) ifTrue: [ ans := 1 ].
	(g = 0) ifTrue: [ ans := 0 ].
	(g < 0) ifTrue: [ ans := 0 ].
	^ ans
]
