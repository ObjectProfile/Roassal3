Class {
	#name : #RSClusterChart,
	#superclass : #RSCompositeChart,
	#instVars : [
		'innerClusterScale',
		'clustersScale',
		'clustersMargin',
		'bandsMargin',
		'horizontal'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSClusterChart >> + aRSPlot [
	self add: aRSPlot.
	^ self.
]

{ #category : #adding }
RSClusterChart >> add: aPlot [
	horizontal := aPlot isHorizontal.
	super add: aPlot.
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

{ #category : #adding }
RSClusterChart >> beforeRenderingIn: aChart [
	yScale := clustersScale.
	aChart yScale: aChart.
]

{ #category : #private }
RSClusterChart >> clusterBandValues [
	| bandValuesSet |
	bandValuesSet := Set new.
	self plots do: [ :plot |
		plot computeXAndYValues.
		plot positions do: [ :value | bandValuesSet add: value ].
	].
	^ bandValuesSet.
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
	| range |
	range := { self padding x. self extent x - self padding x}.
	horizontal ifTrue: [ 
		range := { self padding y negated. (self extent y - self padding y) negated} ].
	clustersScale := NSScale ordinal
		domain: (self clusterBandValues);
		rangeBands: range padding: clustersMargin.
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
		plot bandScale: clustersScale.
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

{ #category : #adding }
RSClusterChart >> horizontal [
	self plots do: [ :plot | plot horizontal ].
	horizontal := true.
]

{ #category : #initialization }
RSClusterChart >> initialize [
	super initialize.
	clustersMargin := self defaultClustersMargin.
	bandsMargin := self defaultBandsMargin.
	horizontal := false.
]

{ #category : #accessing }
RSClusterChart >> innerClusterScale [
	^ innerClusterScale
]

{ #category : #accessing }
RSClusterChart >> maxNumberOfBandsPerPlot [
	^ (self plots collect: [ :plot | plot numberOfBands ]) max.
]

{ #category : #rendering }
RSClusterChart >> renderIn: aCanvas [
	horizontal 
		ifTrue: [ self extent: (self extent x)@(self extent y * (1+(self plots size * 0.1))). ]
		ifFalse: [ self extent: (self extent x * (1+(self plots size * 0.1)))@(self extent y). ].	
	self computePlotsBands.
	horizontal 
		ifTrue: [ self yTickLabels: (1 to: self maxNumberOfBandsPerPlot).  ]
		ifFalse: [ self xTickLabels: (1 to: self maxNumberOfBandsPerPlot). ].
	^ super renderIn: aCanvas.
]
