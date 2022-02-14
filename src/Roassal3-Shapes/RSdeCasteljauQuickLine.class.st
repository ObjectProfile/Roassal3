Class {
	#name : #RSdeCasteljauQuickLine,
	#superclass : #RSdeCasteljauLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauQuickLine >> deCasteljau: aSequenceableOfPoints at: t [

	| aPoint n |
	aPoint := 0 @ 0.

	n := aSequenceableOfPoints size.

	aSequenceableOfPoints withIndexDo: [ :each :i | 
		aPoint := each * (self bernstein: n - 1 choose: i - 1 at: t) asPoint
		          + aPoint ].

	^ { aPoint }
]
