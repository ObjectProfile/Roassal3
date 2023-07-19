Class {
	#name : #RSClusterChart,
	#superclass : #RSChart,
	#instVars : [
		'innerClusterScale',
		'clustersScale',
		'clustersMargin',
		'bandsMargin'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSClusterChart >> addPlot: aPlot [
	super addPlot: aPlot.
	
	self extent: (self extent x * (1+(self plots size * 0.1)))@(self extent y).
	
	self computePlotsBands.
	
	self xTickLabels: (1 to: self maxNumberOfBoxesPerPlot).
	^ aPlot
]

{ #category : #accessing }
RSClusterChart >> bandsMargin [
	^ bandsMargin
]

{ #category : #accessing }
RSClusterChart >> bandsMargin: floatBetween0And1 [
	bandsMargin := floatBetween0And1.
	self computePlotsBands
]

{ #category : #private }
RSClusterChart >> clusterXValues [
	| xValuesSet |
	xValuesSet := Set new.
	self plots do: [ :plot |
		plot xValues do: [ :xValue | xValuesSet add: xValue ]
	].
	^ xValuesSet.
]

{ #category : #accessing }
RSClusterChart >> clustersMargin [
	^ clustersMargin 
]

{ #category : #accessing }
RSClusterChart >> clustersMargin: floatBetween0And1 [
	clustersMargin := floatBetween0And1.
	self computePlotsBands.
]

{ #category : #accessing }
RSClusterChart >> clustersScale [
	^ clustersScale
]

{ #category : #private }
RSClusterChart >> computeClustersScale [
	clustersScale := NSScale ordinal
		domain: (self clusterXValues);
		rangeBands: { self padding x. self extent x - self padding x} padding: clustersMargin.
	^ clustersScale
]

{ #category : #private }
RSClusterChart >> computeInnerClusterScale [
	innerClusterScale := NSScale ordinal
		domain: (1 to: self numberOfPlots);
		rangeBands: {0. clustersScale rangeBand} padding: bandsMargin.
	^ innerClusterScale
]

{ #category : #private }
RSClusterChart >> computePlotsBands [
	self computeClustersScale.
	self computeInnerClusterScale.
	self plots doWithIndex: [ :plot :index |
		| positionInInnerClusterScale |
		positionInInnerClusterScale := innerClusterScale scale: index.
		plot bandsWidth: innerClusterScale rangeBand.
		plot bandsOffset:
			positionInInnerClusterScale - (clustersScale rangeBand / 2) ]
]

{ #category : #defaults }
RSClusterChart >> defaultBandsMargin [
	^ 0.2
]

{ #category : #defaults }
RSClusterChart >> defaultClustersMargin [
	^ 0.2
]

{ #category : #initialization }
RSClusterChart >> initialize [
	super initialize.
	clustersMargin := self defaultClustersMargin.
	bandsMargin := self defaultBandsMargin.
]

{ #category : #accessing }
RSClusterChart >> innerClusterScale [
	^ innerClusterScale
]

{ #category : #accessing }
RSClusterChart >> maxNumberOfBoxesPerPlot [
	^ (self plots collect: [ :plot | plot boxes size ]) max.
]
