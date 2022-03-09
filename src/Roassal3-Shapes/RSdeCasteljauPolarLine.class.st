Class {
	#name : #RSdeCasteljauPolarLine,
	#superclass : #RSdeCasteljauLine,
	#instVars : [
		'ratio'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauPolarLine >> deCasteljau: aSequenceableOfPoints at: t [

	| aPoint n |
	n := aSequenceableOfPoints size - 1.
	aPoint := 0 @ 0.

	1 to: n do: [ :i | 
		| each p |
		each := aSequenceableOfPoints at: i.

		p := 1 - ratio * (aSequenceableOfPoints at: i)
		     + (ratio * (aSequenceableOfPoints at: i + 1))
		     * (t bernstein: n - 1 choose: i - 1) asPoint.

		aPoint := aPoint + p ].

	^ aPoint
]

{ #category : #'instance creation' }
RSdeCasteljauPolarLine >> newLine [

	^ super newLine
		  ratio: ratio;
		  yourself
]

{ #category : #accessing }
RSdeCasteljauPolarLine >> ratio: anObject [

	ratio := anObject
]
