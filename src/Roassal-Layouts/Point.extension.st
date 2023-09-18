Extension { #name : #Point }

{ #category : #'*Roassal-Layouts' }
Point class >> r: radius theta: angle [
	^ (radius * angle cos) @ (radius * angle sin)
]
