Class {
	#name : #RSdeCasteljauRationalWoznyChudyLine,
	#superclass : #RSdeCasteljauWeightedLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalWoznyChudyLine >> deCasteljau: aSequenceableOfPoints at: t [

	| h u qPoint |
	h := 1.
	u := 1 - t.
	qPoint := aSequenceableOfPoints first.

	1 to: pointsSize - 1 do: [ :k | 
		| hPoint i |
		i := k + 1.
		h := h * t * (pointsSize - k) * (weights at: i) max: Float epsilon.
		h := h / (k * u * (weights at: k) + h).
		hPoint := h * (aSequenceableOfPoints at: i).
		qPoint := qPoint * (1 - h) + hPoint ].

	^ { qPoint }
]
