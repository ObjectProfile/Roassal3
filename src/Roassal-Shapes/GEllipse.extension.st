Extension { #name : 'GEllipse' }

{ #category : '*Roassal-Shapes' }
GEllipse >> rsScaleWith: anAthensAffineTransform [
	| m |
	m := anAthensAffineTransform.
	^ self class
		center: (m transform: center)
		vertex: (m transform: coVertex)
		coVertex: (m transform: vertex)
]
