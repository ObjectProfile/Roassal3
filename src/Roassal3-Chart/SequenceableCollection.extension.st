Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal3-Chart' }
SequenceableCollection >> rsHistogram [
	| c plot |
	c := RSChart new.
	plot := RSHistogramPlot new x: self.
	c addPlot: plot.
	c addDecoration: RSVerticalTick new.
	c addDecoration: RSHorizontalTick new.
	^ c
]
