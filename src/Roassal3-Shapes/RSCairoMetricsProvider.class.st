Class {
	#name : #RSCairoMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSCairoMetricsProvider >> extentsOf: text with: font [
	| rawExt |
	rawExt := CairoFontMetricsProvider new
		font: font;
		extentsOf: text.
	^ RSTextExtents new
		from: rawExt;
		yourself.
]
