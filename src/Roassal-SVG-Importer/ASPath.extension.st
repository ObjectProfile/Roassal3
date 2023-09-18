Extension { #name : #ASPath }

{ #category : #'*Roassal-SVG-Importer' }
ASPath >> roassalShape [
	^ RSSVGPath new
		segments: pathData;
	 	computePolygons;
		centerSegments;
		resetPath;
		yourself
]
