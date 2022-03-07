Class {
	#name : #RSdeCasteljauRationalWoznyChudyLine,
	#superclass : #RSdeCasteljauRationalLine,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauRationalWoznyChudyLine >> deCasteljau: aSequenceableOfPoints at2: t [

	| h u qPoint |
	h := 1.
	u := 1 - t.
	qPoint := aSequenceableOfPoints first.

	t > 0.5
		ifTrue: [ 
			u := u / t.
			1 to: pointsSize - 1 do: [ :k | 
				| hPoint i |
				i := k + 1.
				h := h * (pointsSize - k) * (weights at: i).
				h := h / (k * u * (weights at: k) + h).
				hPoint := h * (aSequenceableOfPoints at: i).
				qPoint := 1 - h * qPoint + hPoint ] ]
		ifFalse: [ 
			u := t / u.
			1 to: pointsSize - 1 do: [ :k | 
				| hPoint i |
				i := k + 1.
				h := h * u * (pointsSize - k) * (weights at: i).
				h := h / (k * (weights at: k) + h).
				hPoint := h * (aSequenceableOfPoints at: i).
				qPoint := 1 - h * qPoint + hPoint ] ].

	^ { qPoint }
]

{ #category : #accessing }
RSdeCasteljauRationalWoznyChudyLine >> deCasteljau: aSequenceableOfPoints at: t [

	| h u qPoint |
	h := 1.
	u := 1 - t.
	qPoint := aSequenceableOfPoints first.

	1 to: pointsSize - 1 do: [ :k | 
		| hPoint i |
		i := k + 1.
		h := h * t * (pointsSize - k) * (weights at: i).
		h := h / (k * u * (weights at: k) + h).
		hPoint := h * (aSequenceableOfPoints at: i).
		qPoint := 1 - h * qPoint + hPoint ].

	^ { qPoint }
]
