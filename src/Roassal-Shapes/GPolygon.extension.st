Extension { #name : 'GPolygon' }

{ #category : '*Roassal-Shapes' }
GPolygon >> rsScaleWith: anAthensAffineTransform [
	^ self class vertices: (self vertices collect: [ :p | anAthensAffineTransform transform: p ])
]
