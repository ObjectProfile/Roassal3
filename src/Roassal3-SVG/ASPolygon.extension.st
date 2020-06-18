Extension { #name : #ASPolygon }

{ #category : #'*Roassal3-SVG' }
ASPolygon >> roassalShape [
	^ RSPolygon new
		points: points;
		yourself
]
