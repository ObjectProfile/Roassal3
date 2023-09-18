Extension { #name : #ASRect }

{ #category : #'*Roassal3-SVG-Importer' }
ASRect >> roassalShape [
	^ RSBox new
		fromRectangle: (x@y extent: width@height);
		yourself
]
