Extension { #name : #SequenceableCollection }

{ #category : #'*Roassal3-Chart' }
SequenceableCollection >> rsHistogram [
	| plot |
	plot := RSHistogramPlot new x: self.
	^ plot
]
