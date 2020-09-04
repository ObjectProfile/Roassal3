"
This provider uses CairoFontMetricsProvider to calculate the width of text, but uses `font height` to calculate the height
"
Class {
	#name : #RSCairoMetricsProvider,
	#superclass : #RSCairoFitMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSCairoMetricsProvider >> extentsOf: aRSLabel [
	| res font h|
	font := aRSLabel font.
	res := super extentsOf: aRSLabel.
	h := font height asFloat.
	res
		height: h;
		y_bearing: (h / 4) - h.
	^ res
]
