Class {
	#name : 'RSClusterChart',
	#superclass : 'RSCompositeChart',
	#instVars : [
		'innerClusterScale',
		'clustersScale',
		'clustersMargin',
		'bandsMargin',
		'horizontal',
		'positions'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'adding' }
RSClusterChart >> + aRSPlot [
	self add: aRSPlot.
	^ self
]

{ #category : 'adding' }
RSClusterChart >> add: aPlot [
	horizontal := aPlot isHorizontal.
	super add: aPlot.
	^ aPlot
]

{ #category : 'accessing' }
RSClusterChart >> bandsMargin [
	^ bandsMargin
]

{ #category : 'accessing' }
RSClusterChart >> bandsMargin: floatBetween0And1 [
	bandsMargin := floatBetween0And1.
	self computePlotsBands
]

{ #category : 'adding' }
RSClusterChart >> beforeRenderingIn: aChart [
	yScale := clustersScale.
	aChart yScale: aChart
]

{ #category : 'private' }
RSClusterChart >> clusterBandValues [
	positions := OrderedCollection new.
	self plots do: [ :plot |
		plot computeXAndYValues.
		positions addAll: plot positions.
	].
	positions removeDuplicates.
	^ positions
]

{ #category : 'accessing' }
RSClusterChart >> clustersMargin [
	^ clustersMargin
]

{ #category : 'accessing' }
RSClusterChart >> clustersMargin: floatBetween0And1 [
	clustersMargin := floatBetween0And1.
	self computePlotsBands
]

{ #category : 'accessing' }
RSClusterChart >> clustersScale [
	^ clustersScale
]

{ #category : 'private' }
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

{ #category : 'private' }
RSClusterChart >> computeInnerClusterScale [
	innerClusterScale := NSScale ordinal
		domain: (1 to: self numberOfPlots);
		rangeBands: {0. clustersScale rangeBand} padding: bandsMargin.
	^ innerClusterScale
]

{ #category : 'private' }
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

{ #category : 'rendering' }
RSClusterChart >> computeTicks [
	| horizontalTick verticalTick |
	horizontal
		ifFalse: [
			horizontalTick := self horizontalTick.
			horizontalTick ifNotNil: [
				horizontalTick isTicksDataNil ifTrue: [ self xTicks: positions labels: positions ] ].
		 ]
		ifTrue: [
			verticalTick := self verticalTick.
			verticalTick ifNotNil: [
				verticalTick isTicksDataNil ifTrue: [ self yTicks: positions labels: positions ] ].
		 ]
]

{ #category : 'defaults' }
RSClusterChart >> defaultBandsMargin [
	^ 0.2
]

{ #category : 'defaults' }
RSClusterChart >> defaultClustersMargin [
	^ 0.2
]

{ #category : 'adding' }
RSClusterChart >> horizontal [
	self plots do: [ :plot | plot horizontal ].
	horizontal := true
]

{ #category : 'initialization' }
RSClusterChart >> initialize [
	super initialize.
	clustersMargin := self defaultClustersMargin.
	bandsMargin := self defaultBandsMargin.
	horizontal := false
]

{ #category : 'accessing' }
RSClusterChart >> innerClusterScale [
	^ innerClusterScale
]

{ #category : 'accessing' }
RSClusterChart >> maxNumberOfBandsPerPlot [
	^ (self plots collect: [ :plot | plot numberOfBands ]) max
]

{ #category : 'rendering' }
RSClusterChart >> renderIn: aCanvas [
	horizontal
		ifTrue: [ self extent: (self extent x)@(self extent y * (1+(self plots size * 0.1))). ]
		ifFalse: [ self extent: (self extent x * (1+(self plots size * 0.1)))@(self extent y). ].
	self computePlotsBands.
	self computeTicks.
	^ super renderIn: aCanvas
]
