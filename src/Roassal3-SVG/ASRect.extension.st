Extension { #name : #ASRect }

{ #category : #'*Roassal3-SVG' }
ASRect >> roassalShape [
	^ RSBox new
		fromRectangle: (x@y extent: width@height);
		yourself
]
