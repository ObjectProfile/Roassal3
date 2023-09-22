Extension { #name : 'LinearGradientPaint' }

{ #category : '*Roassal3-Shapes' }
LinearGradientPaint >> leftRight: aRSShape [ 
	| rect |
	rect := aRSShape encompassingRectangle.
	self start: rect topLeft; stop: rect topRight.
	aRSShape paint: self.
]
