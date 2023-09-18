Extension { #name : #AthensCloseSegment }

{ #category : #'*Roassal3-SVG' }
AthensCloseSegment >> visitWith: visitor [
	visitor visitCloseSegment:  self
]
