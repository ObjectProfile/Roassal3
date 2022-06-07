Class {
	#name : #RSArcLengthParameterization,
	#superclass : #RSParameterization,
	#instVars : [
		'parameterization'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #dispatching }
RSArcLengthParameterization >> controlPointsChanged: points overlappingDistancesSum: controlPolygonLength [

	parameterization
		controlPointsChanged: points
		overlappingDistancesSum: controlPolygonLength.

	self updateDomain
]

{ #category : #sorting }
RSArcLengthParameterization >> indexForInserting: newObject into: aSequenceable [

	"Very similar to SortedCollection>>#indexForInserting: with #< as sorting block."

	| index low high |
	low := 1.
	high := aSequenceable size.

	[ 
	index := high + low // 2.
	low > high ] whileFalse: [ 
		(aSequenceable at: index) < newObject
			ifTrue: [ low := index + 1 ]
			ifFalse: [ high := index - 1 ] ].

	^ low
]

{ #category : #accessing }
RSArcLengthParameterization >> parameterization: aParameterization [

	parameterization := aParameterization
]

{ #category : #dispatching }
RSArcLengthParameterization >> parameterize_RSParametricLine: aLine [

	aLine parameterized_RSArcLengthParameterization: self
]

{ #category : #copying }
RSArcLengthParameterization >> postCopy [

	super postCopy.

	parameterization := parameterization copy
]

{ #category : #accessing }
RSArcLengthParameterization >> updateDomain [

	| size totalArcLength |
	totalArcLength := cumulativeArcLengths last.

	size := cumulativeArcLengths size - 1.

	domain := parameterization collect: [ :u | 
		          | arcLength index before after ratio |
		          arcLength := totalArcLength * u.

		          index := (self
			                    indexForInserting: arcLength
			                    into: cumulativeArcLengths) - 1.

		          index := index min: size max: 1.

		          before := cumulativeArcLengths at: index.
		          after := cumulativeArcLengths at: index + 1.

		          ratio := arcLength - before / (after - before).

		          ratio + index - 1 / size ].

	"to ensure interpolation on the first and last control points."
	domain
		at: 1 put: 0.0;
		atLast: 1 put: 1.0
]

{ #category : #enumerating }
RSArcLengthParameterization >> withIndexDo: aBlock [

	"First, cumulate arc lengths using the original parameterization."

	cumulativeArcLengths := parameterization withIndexDo: aBlock.

	"Second, prepare the domain to be consistent according to arc length parameterization."
	self updateDomain.

	"Third, evaluate according to the new parameterization"
	super withIndexDo: aBlock.

	"Fourth, update again the domain after new arc lengths have been computed."
	self updateDomain.

	"Finally, return the new arc length to be consistent with my super class."
	^ cumulativeArcLengths
]
