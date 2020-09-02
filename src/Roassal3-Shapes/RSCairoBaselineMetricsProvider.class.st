Class {
	#name : #RSCairoBaselineMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSCairoBaselineMetricsProvider >> extentsOf: text with: font [
	| rawExt h |
	rawExt := CairoFontMetricsProvider new
		font: font;
		extentsOf: text.
	h := font height asFloat.
	^ RSTextExtents new
		from: rawExt;
		height: h;
		y_bearing: (h / 4) - h;
		yourself.
]
