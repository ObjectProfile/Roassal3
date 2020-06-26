Extension { #name : #ASPolyLine }

{ #category : #'*Roassal3-SVG' }
ASPolyLine >> roassalShape [
	^ RSPolyline new
		controlPoints: points;
		yourself
]
