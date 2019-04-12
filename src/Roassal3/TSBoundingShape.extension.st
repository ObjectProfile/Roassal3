Extension { #name : #TSBoundingShape }

{ #category : #'*Roassal3' }
TSBoundingShape >> geometry [
	| rect |
	rect := self encompassingRectangle.
	^ GRectangle
		origin: rect origin 
		corner: rect corner
]
