Class {
	#name : #RSdeCasteljauDerivativeLine,
	#superclass : #RSdeCasteljauLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauDerivativeLine >> deCasteljau: diffPoints at: t [

	| aPoint n |
	n := diffPoints size.
	aPoint := 0 @ 0.

	diffPoints withIndexDo: [ :each :i | 
		aPoint := aPoint + (each * (self binomial: n choose: i at: t)) ].

	^ { aPoint }
]
