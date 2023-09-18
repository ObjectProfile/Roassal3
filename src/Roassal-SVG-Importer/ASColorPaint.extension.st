Extension { #name : #ASColorPaint }

{ #category : #'*Roassal3-SVG-Importer' }
ASColorPaint >> rsFill: rsShape with: shape [
	rsShape paint: (color alpha: (color alpha * shape fill_opacity))
]

{ #category : #'*Roassal3-SVG-Importer' }
ASColorPaint >> rsStroke: rsShape with: shape [
	| border |
	border := RSBorder new
		paint: (color alpha: (color alpha * shape stroke_opacity));
		width: shape stroke_width.
	rsShape border: border.
]
