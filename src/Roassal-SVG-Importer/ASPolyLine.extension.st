Extension { #name : #ASPolyLine }

{ #category : #'*Roassal-SVG-Importer' }
ASPolyLine >> roassalShape [
	^ RSPolyline new
		controlPoints: points;
		yourself
]
