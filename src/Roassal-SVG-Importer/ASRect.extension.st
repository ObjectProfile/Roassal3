Extension { #name : #ASRect }

{ #category : #'*Roassal-SVG-Importer' }
ASRect >> roassalShape [
	^ RSBox new
		fromRectangle: (x@y extent: width@height);
		yourself
]
