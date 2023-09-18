Extension { #name : #ASNoFill }

{ #category : #'*Roassal3-SVG-Importer' }
ASNoFill >> rsFill: aRSShape with: anShape [
	aRSShape paint: nil.
]

{ #category : #'*Roassal3-SVG-Importer' }
ASNoFill >> rsStroke: aRSShape with: anShape [
	aRSShape border: nil.
]
