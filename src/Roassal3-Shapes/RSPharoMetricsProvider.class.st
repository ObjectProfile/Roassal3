Class {
	#name : #RSPharoMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSPharoMetricsProvider >> extentsOf: text with: font [
	| w h |
	w := (font widthOfString: text) asFloat.
	h := font height asFloat.
	^ RSTextExtents new
		width: w;
		height: h;
		x_advance: w;
		y_advance: h;
		x_bearing: 0;
		y_bearing: (h / 4) - h;
		yourself.
]
