Extension { #name : #ASLine }

{ #category : #'*Roassal-SVG-Importer' }
ASLine >> roassalShape [
	^ RSLine new
		startPoint: x1@y1;
		endPoint: x2@y1;
		yourself
]
