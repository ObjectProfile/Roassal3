"
This provider uses the exact width and height of CairoFontMetricsProvider
"
Class {
	#name : 'RSCairoFitMetricsProvider',
	#superclass : 'RSMetricsProvider',
	#category : 'Roassal-Shapes-TextMetrics',
	#package : 'Roassal-Shapes',
	#tag : 'TextMetrics'
}

{ #category : 'hooks' }
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
