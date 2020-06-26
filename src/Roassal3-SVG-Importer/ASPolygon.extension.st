Extension { #name : #ASPolygon }

{ #category : #'*Roassal3-SVG-Importer' }
ASPolygon >> roassalShape [
	^ RSPolygon new
		points: points;
		yourself
]
