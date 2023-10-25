Extension { #name : 'Collection' }

{ #category : '*Roassal-Chart' }
Collection >> interQuartileRange [
	| quartiles q1 q3 |
	quartiles := self quartiles.
	q1 := quartiles first.
	q3 := quartiles third.
	^ q3 - q1
]

{ #category : '*Roassal-Chart' }
Collection >> quartiles [
	| q1 q2 q3 quantile |
	quantile := RSInvertedCDF data: self.
	q1 := quantile compute: 0.25.
	q2 := quantile compute: 0.50.
	q3 := quantile compute: 0.75.
	^  { q1. q2. q3 }
]

{ #category : '*Roassal-Chart' }
Collection >> standardDeviation [
	"It follows the implementation of numpy using the size N (instead of N - 1)"
	| standardDeviation sum mean |
	sum := 0.
	mean := self average.
	self do: [ :observationX | sum := sum + ((observationX - mean) squared) ].
	standardDeviation := (sum/self size) sqrt.
	^ standardDeviation
]
