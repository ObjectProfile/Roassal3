Extension { #name : #ASPath }

{ #category : #'*Roassal3-SVG-Importer' }
ASPath >> roassalShape [
	^ RSSVGPath new
		segments: pathData;
	 	computePolygons;
		centerSegments;
		resetPath;
		yourself
]
