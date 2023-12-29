Extension { #name : 'AthensCloseSegment' }

{ #category : '*Roassal-SVG' }
AthensCloseSegment >> visitWith: visitor [
	visitor visitCloseSegment:  self
]
