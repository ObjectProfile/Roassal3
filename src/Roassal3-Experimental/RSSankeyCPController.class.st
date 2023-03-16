"
TODO
"
Class {
	#name : #RSSankeyCPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Experimental-Sankey'
}

{ #category : #hooks }
RSSankeyCPController >> controlPointsFor: aLine [

	| x1 x2 x3 x4 y1 y2 y3 y4 sy ty |
	aLine dy ifNil: [
		^ {
			  (0 @ 0).
			  (0 @ 0) } ].
	sy := aLine sy ifNil: [ 0 ].
	ty := aLine ty ifNil: [ 0 ].

	x1 := aLine from position x.
	y1 := aLine from position y + sy + ((aLine dy ifNil: [ 0 ]) / 2)
	      - ((aLine from dy ifNil: [ 0 ]) / 2).
	x4 := aLine to position x.
	y4 := aLine to position y + ty + ((aLine dy ifNil: [ 0 ]) / 2)
	      - ((aLine to dy ifNil: [ 0 ]) / 2).

	x2 := x3 := aLine from position x + aLine to position x / 2.
	y2 := aLine from position y + aLine sy + (aLine dy / 2)
	      - (aLine from dy / 2).
	y3 := aLine to position y + aLine ty + (aLine dy / 2)
	      - (aLine to dy / 2).
	^ {
		  (x1 @ y1).
		  (x2 @ y2).
		  (x3 @ y3).
		  (x4 @ y4) }
]
