Class {
	#name : 'RSdeCasteljauPolynomialLine',
	#superclass : 'RSdeCasteljauLine',
	#category : 'Roassal3-Shapes-Lines',
	#package : 'Roassal3-Shapes',
	#tag : 'Lines'
}

{ #category : 'accessing' }
RSdeCasteljauPolynomialLine >> deCasteljau: aSequenceableOfPoints at: t [

	| aPoint n |
	aPoint := 0 @ 0.

	n := pointsSize - 1.

	aSequenceableOfPoints withIndexDo: [ :each :i | 
		aPoint := each * (t bernstein: n choose: i - 1) asPoint + aPoint ].

	^ aPoint
]
