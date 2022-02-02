Class {
	#name : #RSdeCasteljauStep,
	#superclass : #Object,
	#instVars : [
		'param'
	],
	#category : #'Roassal3-Examples'
}

{ #category : #accessing }
RSdeCasteljauStep >> value: controlPoints [

	| n |
	n := controlPoints size.

	1 to: n do: [ :k | 
		1 to: n - k do: [ :i | 
			| aPoint nextPoint |
			aPoint := 1 - param * (controlPoints at: i).
			nextPoint := param * (controlPoints at: i + 1).
			controlPoints at: i put: aPoint + nextPoint ] ].

	^ controlPoints at: 1
]
