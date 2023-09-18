"
This provider uses the exact width and height of CairoFontMetricsProvider
"
Class {
	#name : #RSCairoFitMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-TextMetrics'
}

{ #category : #hooks }
RSCairoFitMetricsProvider >> extentsOf: aRSLabel [
	| rawExt cairoFont glyphs |
	cairoFont := aRSLabel cairoFont.
	glyphs := aRSLabel cairoGlyphs.
	rawExt := CairoTextExtents new.
	cairoFont getExtentsOfGlyphs: glyphs getHandle ofLength: glyphs size into: rawExt.
	^ RSTextExtents new
		from: rawExt;
		yourself
]
