Extension { #name : #ASPolyLine }

{ #category : #'*Roassal3-SVG-Importer' }
ASPolyLine >> roassalShape [
	^ RSPolyline new
		controlPoints: points;
		yourself
]
