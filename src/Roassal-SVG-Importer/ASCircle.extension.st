Extension { #name : #ASCircle }

{ #category : #'*Roassal-SVG-Importer' }
ASCircle >> roassalShape [
	^ RSEllipse new
		radius: (r ifNil: [0]);
		position: cx@ cy;
		yourself
]
