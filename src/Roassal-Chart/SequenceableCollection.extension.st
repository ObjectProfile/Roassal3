Extension { #name : 'SequenceableCollection' }

{ #category : '*Roassal-Chart' }
SequenceableCollection >> rsHistogram [
	| plot |
	plot := RSHistogramPlot new x: self.
	^ plot
]
