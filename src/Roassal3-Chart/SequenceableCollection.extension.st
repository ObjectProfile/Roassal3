Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal3-Chart' }
SequenceableCollection >> rsHistogram [
	| c plot |
	c := RSCompositeChart new.
	plot := RSHistogramPlot new x: self.
	c addPlot: plot.
	^ c
]
