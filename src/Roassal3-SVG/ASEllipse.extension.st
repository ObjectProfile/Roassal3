Extension { #name : #ASEllipse }

{ #category : #'*Roassal3-SVG' }
ASEllipse >> roassalShape [
	^ RSEllipse new
		extent: (rx @ ry *2);
		position: cx@ cy;
		yourself
]
