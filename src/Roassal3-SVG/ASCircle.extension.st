Extension { #name : #ASCircle }

{ #category : #'*Roassal3-SVG' }
ASCircle >> roassalShape [
	^ RSEllipse new
		radius: r;
		position: cx@ cy;
		yourself
]
