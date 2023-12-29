"
Old version of metrics provider used in Roassal2 with fonts. It is a little slow
"
Class {
	#name : 'RSPharoMetricsProvider',
	#superclass : 'RSMetricsProvider',
	#category : 'Roassal-Shapes-TextMetrics',
	#package : 'Roassal-Shapes',
	#tag : 'TextMetrics'
}

{ #category : 'hooks' }
RSPharoMetricsProvider >> extentsOf: aRSLabel [
	| w h font text |
	font := aRSLabel font.
	text := aRSLabel text.
	w := (font widthOfString: text) asFloat.
	h := font height asFloat.
	^ RSTextExtents new
		width: w;
		height: h;
		x_advance: w;
		y_advance: h;
		x_bearing: 0;
		y_bearing: (h / 4) - h;
		yourself
]
