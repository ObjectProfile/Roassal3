Extension { #name : 'AthensLineSegment' }

{ #category : '*Roassal-SVG' }
AthensLineSegment >> consumeShapes: shapes current: opoint delta: delta [
	| vector u unit angle w2 curPoint dist sum |
	shapes ifEmpty: [ ^ self ].
	vector := point - opoint.
	u := vector normal.
	angle := vector angle.
	unit := vector / (vector r max: 1).
	dist := opoint distanceTo: point.

	sum := 0.
	shapes copy do: [ :s |
		w2 := s width / 2.
		sum := sum + w2.
		sum > dist ifTrue: [ ^ self ].
		curPoint := opoint + delta + (unit * sum).
		shapes remove: s.
		s translateTo: curPoint - (u * (s height/2) ).
		sum := sum + w2.
		s rotateByRadians: angle.
	]
]

{ #category : '*Roassal-SVG' }
AthensLineSegment >> durationFor: aPoint [
	| d |
	d := aPoint distanceTo: point.
	^ 1 / (d*0.5)
]

{ #category : '*Roassal-SVG' }
AthensLineSegment >> pointsWithStart: aPoint duration: duration [

	^ (0 to: 1 by: duration) collect: [ :t |
		aPoint interpolateTo: point at: t ]
]
