Class {
	#name : #RSBlocMetricProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Bloc'
}

{ #category : #hooks }
RSBlocMetricProvider >> extentsOf: aRSLabel [
	| paragraph line | 
	paragraph := BlSingleLineTextParagraph new
		text: aRSLabel blRopedText;
		yourself.
	(BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen)
		measureTextParagraph: paragraph.
	line := paragraph line.
	"ascent descent height baseline y"
	^ RSTextExtents new
		width: line width;
		height: line height;
		x_advance: line advance;
		y_advance: 0;
		x_bearing: 0;
		y_bearing: line top;
		yourself.
]
