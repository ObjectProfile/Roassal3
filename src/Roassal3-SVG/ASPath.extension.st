Extension { #name : #ASPath }

{ #category : #'*Roassal3-SVG' }
ASPath >> roassalShape [
	^ RSSVGPath new
		segments: pathData;
	 	computePolygons;
		centerSegments;
		resetPath;
		yourself
]
