Extension { #name : #ASCircle }

{ #category : #'*Roassal3-SVG-Importer' }
ASCircle >> roassalShape [
	^ RSEllipse new
		radius: r;
		position: cx@ cy;
		yourself
]
