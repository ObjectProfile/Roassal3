"
This provider uses CairoFontMetricsProvider to calculate the width of text, but uses `font height` to calculate the height. It is the default metric profider used for labels.
"
Class {
	#name : #RSCairoMetricsProvider,
	#superclass : #RSCairoFitMetricsProvider,
	#category : #'Roassal3-Shapes-TextMetrics'
}

{ #category : #hooks }
RSCairoMetricsProvider >> extentsOf: aRSLabel [
	| res font h |
	font := aRSLabel font.
	res := super extentsOf: aRSLabel.
	h := font getPreciseHeight asFloat.
	res
		height: h;
		y_bearing: font getPreciseAscent negated.
	^ res
]
