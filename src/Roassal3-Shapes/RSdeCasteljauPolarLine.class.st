Class {
	#name : #RSdeCasteljauPolarLine,
	#superclass : #RSdeCasteljauLine,
	#instVars : [
		'ratio'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauPolarLine >> deCasteljau: diffPoints at: t [

	| aPoint n |
	n := diffPoints size - 1.
	aPoint := 0 @ 0.

	1 to: n do: [ :i | 
		| each p |
		each := diffPoints at: i.

		p := 1 - ratio * (diffPoints at: i)
		     + (ratio * (diffPoints at: i + 1))
		     * (self binomial: n - 1 choose: i - 1 at: t).

		aPoint := aPoint + p ].

	^ { aPoint }
]

{ #category : #accessing }
RSdeCasteljauPolarLine >> ratio: anObject [

	ratio := anObject
]
