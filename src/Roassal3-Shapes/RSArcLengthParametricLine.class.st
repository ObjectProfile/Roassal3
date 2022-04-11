Class {
	#name : #RSArcLengthParametricLine,
	#superclass : #RSParametricLine,
	#instVars : [
		'line'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #converting }
RSArcLengthParametricLine >> controlPoints1: aSequenceableOfPoints at: u [

	| arcLength index j |
	arcLength := arcLenghts last * u.

	index := (arcLenghts indexForInserting: arcLength) - 1 max: 1.

	j := (arcLength closeTo: (arcLenghts at: index))
		     ifTrue: [ index ]
		     ifFalse: [ 
			     | before after ratio |
			     before := arcLenghts at: index.
			     after := arcLenghts at: index + 1.

			     ratio := arcLength - before / (after - before).

			     index + ratio ].

	^ line
		  controlPoints: aSequenceableOfPoints
		  at: j - 1 / (arcLenghts size - 1)
]

{ #category : #converting }
RSArcLengthParametricLine >> controlPoints: aSequenceableOfPoints at: t [

	^ line controlPoints: aSequenceableOfPoints at: t
]

{ #category : #accessing }
RSArcLengthParametricLine >> line: aLine [

	line := aLine
]

{ #category : #'as yet unclassified' }
RSArcLengthParametricLine >> param: aParam cumulativeArcLengths: arcLenghts [

	| size |
	size := arcLenghts size - 1.

	self param: (aParam collect: [ :u | 
			 | arcLength index before after ratio |
			 arcLength := arcLenghts last * u.

			 index := (arcLenghts indexForInserting: arcLength) - 1
				          min: size
				          max: 1.

			 before := arcLenghts at: index.
			 after := arcLenghts at: index + 1.

			 ratio := arcLength - before / (after - before).

			 index + ratio - 1 / size ])
]
