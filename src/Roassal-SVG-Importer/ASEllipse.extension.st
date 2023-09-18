Extension { #name : #ASEllipse }

{ #category : #'*Roassal-SVG-Importer' }
ASEllipse >> roassalShape [
	^ RSEllipse new
		extent: (rx @ ry *2);
		position: cx@ cy;
		yourself
]
