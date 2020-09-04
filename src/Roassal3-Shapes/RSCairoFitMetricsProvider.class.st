"
This provider uses the exact width and height of CairoFontMetricsProvider
"
Class {
	#name : #RSCairoFitMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSCairoFitMetricsProvider >> extentsOf: aRSLabel [
	| rawExt text cairoFont glyphs |
	text := aRSLabel text.
	cairoFont := aRSLabel cairoFont.
	glyphs := aRSLabel cairoGlyphs.
	rawExt := CairoTextExtents new.
	cairoFont getExtentsOfGlyphs: glyphs getHandle ofLength: glyphs size into: rawExt.
	^ RSTextExtents new
		from: rawExt;
		yourself.
]
