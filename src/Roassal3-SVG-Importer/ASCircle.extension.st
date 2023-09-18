Extension { #name : #ASCircle }

{ #category : #'*Roassal3-SVG-Importer' }
ASCircle >> roassalShape [
	^ RSEllipse new
		radius: (r ifNil: [0]);
		position: cx@ cy;
		yourself
]
