Extension { #name : #ASPolygon }

{ #category : #'*Roassal-SVG-Importer' }
ASPolygon >> roassalShape [
	^ RSPolygon new
		points: points;
		yourself
]
