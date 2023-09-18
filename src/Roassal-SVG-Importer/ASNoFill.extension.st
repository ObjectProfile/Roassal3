Extension { #name : #ASNoFill }

{ #category : #'*Roassal-SVG-Importer' }
ASNoFill >> rsFill: aRSShape with: anShape [
	aRSShape paint: nil.
]

{ #category : #'*Roassal-SVG-Importer' }
ASNoFill >> rsStroke: aRSShape with: anShape [
	aRSShape border: nil.
]
