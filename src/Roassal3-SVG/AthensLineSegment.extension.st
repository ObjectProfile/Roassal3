Extension { #name : #AthensLineSegment }

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
