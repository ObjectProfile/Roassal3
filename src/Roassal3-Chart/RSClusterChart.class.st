Class {
	#name : #RSClusterChart,
	#superclass : #RSChart,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSClusterChart >> addPlot: aPlot [
	| scale clusterPadding bandPadding clusterScale |
	super addPlot: aPlot.
	clusterPadding := 0.2.
	scale := NSScale ordinal
		domain: aPlot xValues;
		rangeBands: { self padding x. self extent x - self padding x} padding: clusterPadding.
	bandPadding := 0.2.
	clusterScale := NSScale ordinal
		domain: (1 to: self numberOfPlots);
		rangeBands: {0. scale rangeBand} padding: bandPadding.
	self plots doWithIndex: [ :plot :index |
		| positionInInnerOrdinalScale |
		positionInInnerOrdinalScale := clusterScale scale: index.
		plot bandsWidth: clusterScale rangeBand.
		plot bandsOffset: positionInInnerOrdinalScale - (scale rangeBand/2)
	].
	^ aPlot
]
