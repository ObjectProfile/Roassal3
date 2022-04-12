Class {
	#name : #RSArcLengthParametricLine,
	#superclass : #RSParametricLine,
	#instVars : [
		'line'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSArcLengthParametricLine >> controlPoints: aSequenceableOfPoints at: t [

	^ line controlPoints: aSequenceableOfPoints at: t
]

{ #category : #accessing }
RSArcLengthParametricLine >> line [

	^ line
]

{ #category : #accessing }
RSArcLengthParametricLine >> line: aLine [

	line := aLine
]

{ #category : #initializing }
RSArcLengthParametricLine >> param: aParam cumulativeArcLengths: aCollection [

	| size newParam arcLengths |
	arcLengths := (SortedCollection sortBlock: [ :aFloat :anotherFloat | 
			               aFloat < anotherFloat ])
		              addAll: aCollection;
		              yourself.

	size := arcLengths size - 1.

	newParam := aParam collect: [ :u | 
		            | arcLength index before after ratio |
		            arcLength := arcLengths last * u.

		            index := (arcLengths indexForInserting: arcLength) - 1
			                     min: size
			                     max: 1.

		            before := arcLengths at: index.
		            after := arcLengths at: index + 1.

		            ratio := arcLength - before / (after - before).

		            ratio + index - 1 / size ].

	self param: newParam
]
