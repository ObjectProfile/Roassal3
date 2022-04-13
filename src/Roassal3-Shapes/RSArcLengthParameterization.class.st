Class {
	#name : #RSArcLengthParameterization,
	#superclass : #RSParameterization,
	#instVars : [
		'parameterization'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #accessing }
RSArcLengthParameterization >> parameterization: aParameterization [

	parameterization := aParameterization.

	cumulativeArcLengths := parameterization cumulativeArcLengths.

	self updateDomain
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

	domain := parameterization collect: [ :u | 
		          | arcLength index before after ratio |
		          arcLength := totalArcLength * u.

		          index := (arcLengths indexForInserting: arcLength) - 1
			                   min: size
			                   max: 1.

		          before := arcLengths at: index.
		          after := arcLengths at: index + 1.

		          ratio := arcLength - before / (after - before).

		          ratio + index - 1 / size ]
]

{ #category : #enumerating }
RSArcLengthParameterization >> withIndexDo: aBlock [

	self cumulativeArcLengths.

	super withIndexDo: aBlock
]
