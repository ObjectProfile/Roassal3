Extension { #name : #AthensCubicSegment }

{ #category : #'*Roassal3-SVG' }
AthensCubicSegment >> durationFor: aPoint [ 
	| d |
	d := to distanceTo: aPoint.
	^ 1 / (d*0.5)
]

{ #category : #'*Roassal3-SVG' }
AthensCubicSegment >> pointsWithStart: aPoint duration: duration [
	| c b a |
	c := 3 * (via1 - aPoint).
	b := 3 * (via2 - via1) - c.
	a := to - aPoint - c - b.

	^ (0 to: 1 by: duration) collect: [ :t | 
		a * (t raisedTo: 3) + (b * (t * t)) + (c * t) + aPoint. 
		]
]

{ #category : #'*Roassal3-SVG' }
AthensCubicSegment >> visitWith: visitor [
	visitor visitCubicSegment: self
]
