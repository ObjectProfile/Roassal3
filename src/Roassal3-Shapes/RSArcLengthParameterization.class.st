Class {
	#name : #RSArcLengthParameterization,
	#superclass : #RSParameterization,
	#instVars : [
		'sourceDomain',
		'initIterations'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'as yet unclassified' }
RSArcLengthParameterization >> initDo: aBlock [

	initIterations timesRepeat: aBlock
]

{ #category : #accessing }
RSArcLengthParameterization >> initIterations: anObject [

	initIterations := anObject
]

{ #category : #accessing }
RSArcLengthParameterization >> parameterization: aParameterization [

	sourceDomain := aParameterization domain.

	cumulativeArcLengths := aParameterization cumulativeArcLengths copy.

	self updateDomain
]

{ #category : #'as yet unclassified' }
RSArcLengthParameterization >> parameterize_RSParametricLine: aLine [

	aLine parameterized_RSArcLengthParameterization: self
]

{ #category : #accessing }
RSArcLengthParameterization >> updateDomain [

	| size totalArcLength arcLengths |
	arcLengths := (SortedCollection sortBlock: [ :aFloat :anotherFloat | 
			               aFloat < anotherFloat ])
		              addAll: cumulativeArcLengths;
		              yourself.

	totalArcLength := arcLengths last.

	size := arcLengths size - 1.

	domain := sourceDomain collect: [ :u | 
		          | arcLength index before after ratio |
		          arcLength := totalArcLength * u.

		          index := (arcLengths indexForInserting: arcLength) - 1
			                   min: size
			                   max: 1.

		          before := arcLengths at: index.
		          after := arcLengths at: index + 1.

		          ratio := arcLength - before / (after - before).

		          ratio + index - 1 / size ].

	domain
		at: 1 put: 0.0;
		atLast: 1 put: 1.0
]

{ #category : #enumerating }
RSArcLengthParameterization >> withIndexDo: aBlock [

	super withIndexDo: aBlock.

	self updateDomain
]
