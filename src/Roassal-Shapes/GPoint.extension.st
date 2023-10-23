Extension { #name : 'GPoint' }

{ #category : '*Roassal-Shapes' }
GPoint >> center [
	^ self
]

{ #category : '*Roassal-Shapes' }
GPoint >> rsScaleWith: anAthensAffineTransform [
	^ (anAthensAffineTransform transform: self) asGPoint
]
