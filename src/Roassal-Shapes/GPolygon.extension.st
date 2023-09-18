Extension { #name : #GPolygon }

{ #category : #'*Roassal3-Shapes' }
GPolygon >> rsScaleWith: anAthensAffineTransform [
	^ self class vertices: (self vertices collect: [ :p | anAthensAffineTransform transform: p ])
]
