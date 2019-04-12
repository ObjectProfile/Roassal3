Extension { #name : #TSEllipse }

{ #category : #'*Roassal3' }
TSEllipse >> geometry [ 
	| rect |
	rect := self encompassingRectangle.
	^ GEllipse 
		center: self position 
		a: rect width / 2 
		b: rect height / 2
]
