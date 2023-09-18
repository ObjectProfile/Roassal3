Extension { #name : #Point }

{ #category : #'*Roassal3-Layouts' }
Point class >> r: radius theta: angle [
	^ (radius * angle cos) @ (radius * angle sin)
]
