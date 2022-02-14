Class {
	#name : #RSdeCasteljauRationalLine,
	#superclass : #RSdeCasteljauLine,
	#instVars : [
		'weights',
		'mappedPoints'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalLine >> controlPoints: aSequenceableOfPoints [

	mappedPoints := Array new: aSequenceableOfPoints size.

	super controlPoints: aSequenceableOfPoints
]

{ #category : #accessing }
RSdeCasteljauRationalLine >> deCasteljau: aSequenceableOfPoints at: t [

	| triple factor n |
	n := pointsSize - 1.
	factor := 0.

	weights withIndexDo: [ :each :i | 
		| aPoint |
		aPoint := aSequenceableOfPoints at: i.
		mappedPoints at: i put: aPoint * each asPoint.

		factor := factor + (each * (t bernstein: n choose: i - 1)) ].

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
