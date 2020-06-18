Extension { #name : #ASNoFill }

{ #category : #'*Roassal3-SVG' }
ASNoFill >> rsFill: aRSShape with: anShape [
	aRSShape paint: nil.
]

{ #category : #'*Roassal3-SVG' }
ASNoFill >> rsStroke: aRSShape with: anShape [
	aRSShape border: nil.
]
