Class {
	#name : #RSdeCasteljauDerivativeLine,
	#superclass : #RSdeCasteljauLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauDerivativeLine >> deCasteljau: aSequenceableOfPoints at: t [

	| aPoint n |
	n := aSequenceableOfPoints size.
	aPoint := 0 @ 0.

	aSequenceableOfPoints withIndexDo: [ :each :i | 
		aPoint := aPoint + (each * (t bernstein: n choose: i) asPoint) ].

	^ { (n + 1 * aPoint) }
]
