Class {
	#name : #RSdeCasteljauRationalLine,
	#superclass : #RSdeCasteljauLine,
	#instVars : [
		'weights'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalLine >> deCasteljau: diffPoints at: t [

	| mappedPoints triple factor n |
	mappedPoints := Array new: diffPoints size.

	n := diffPoints size.
	factor := 0.

	weights withIndexDo: [ :each :i | 
		| aPoint |
		aPoint := diffPoints at: i.
		mappedPoints at: i put: aPoint * each.
		factor := factor
		          + (each * (self bernstein: n - 1 choose: i - 1 at: t)) ].

	triple := super deCasteljau: mappedPoints at: t.

	^ triple collect: [ :each | each / factor ]
]

{ #category : #'instance creation' }
RSdeCasteljauRationalLine >> newLine [

	^ super newLine
		  weights: weights;
		  yourself
]

{ #category : #accessing }
RSdeCasteljauRationalLine >> weights: anObject [

	weights := anObject
]
