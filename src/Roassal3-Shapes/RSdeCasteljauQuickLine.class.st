Class {
	#name : #RSdeCasteljauQuickLine,
	#superclass : #RSdeCasteljauLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauQuickLine >> deCasteljau: aCollectionOfPoints at: t [

	| aPoint n |
	aPoint := 0 @ 0.

	n := aCollectionOfPoints size.

	aCollectionOfPoints withIndexDo: [ :each :i | 
		aPoint := each * (self bernstein: n - 1 choose: i - 1 at: t)
		          + aPoint ].

	^ { aPoint }
]
