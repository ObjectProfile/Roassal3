Class {
	#name : #RSdeCasteljauDerivativeLine,
	#superclass : #RSdeCasteljauLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauDerivativeLine >> deCasteljau: aSequenceableOfPoints at: t [

	| aPoint |
	aPoint := 0 @ 0.

	aSequenceableOfPoints withIndexDo: [ :each :i | 
		aPoint := aPoint
		          + (each * (t bernstein: pointsSize choose: i) asPoint) ].

	^ pointsSize + 1 * aPoint
]
