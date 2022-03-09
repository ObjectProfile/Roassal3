Extension { #name : #AthensLineSegment }

{ #category : #'*Roassal3-SVG' }
AthensLineSegment >> consumeShapes: shapes current: opoint [
	| vector u unit width angle w2 curPoint |
	shapes ifEmpty: [ ^ self ].
	vector := point - opoint.
	u := vector normal.
	angle := vector angle.
	unit := vector / (vector r max: 1).
	width := (opoint distanceTo: point)/2.
	shapes do: [ :s |
		w2 := s width / 2.
		width := width + w2.
		curPoint := opoint+(unit*width).
		s translateTo: curPoint - (u * (s height/2) ).
		width := width + w2.
		s rotateByRadians: angle.
		 ].


]

{ #category : #'*Roassal3-SVG' }
AthensLineSegment >> durationFor: aPoint [
	| d |
	d := aPoint distanceTo: point.
	^ 1 / (d*0.5)
]

{ #category : #'*Roassal3-SVG' }
AthensLineSegment >> pointsWithStart: aPoint duration: duration [ 
	
	^ (0 to: 1 by: duration) collect: [ :t |
		aPoint interpolateTo: point at: t ].
]
