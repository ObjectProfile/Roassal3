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

{ #category : #adding }
RSClusterChart >> computeBandsOffset [
	| numberOfPlots bandsWidth offsets |
	numberOfPlots := self plots size.
	bandsWidth := self plots first bandsWidth.
	
	offsets := OrderedCollection new.
	
	numberOfPlots odd ifTrue: [ 
		| indexOfTheMiddle currentIndex counter |
		indexOfTheMiddle := (numberOfPlots / 2) ceiling. 
		currentIndex := 1.
		counter := 1.
		[currentIndex < indexOfTheMiddle] whileTrue: [ 
			offsets addFirst: (0-(bandsWidth * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
		currentIndex := indexOfTheMiddle.
		counter := 0.
		[currentIndex <= numberOfPlots] whileTrue: [ 
			offsets add: (bandsWidth * counter).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
	].
	
	numberOfPlots even ifTrue: [ 
		| indexOfTheMiddle currentIndex counter |
		indexOfTheMiddle := (numberOfPlots / 2). 
		currentIndex := 1.
		counter := 0.
		[currentIndex <= indexOfTheMiddle] whileTrue: [ 
			offsets addFirst: (0-(bandsWidth/2)-(bandsWidth * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
		currentIndex := indexOfTheMiddle.
		counter := 0.
		[currentIndex < numberOfPlots] whileTrue: [ 
			offsets add: ((bandsWidth/2) + (bandsWidth * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
	].
	
	self plots doWithIndex: [ :plot :idx | 
		plot offset: (offsets at: idx)
	].
]

{ #category : #adding }
RSClusterChart >> computeBandsWidth [
	| numberOfPlots newBandWidth |
	numberOfPlots := self plots size.
	newBandWidth := (self defaultBandsWidth - self defaultClusterPadding) / numberOfPlots.
	self plots do: [ :plot | 
		plot bandsWidth: newBandWidth.
	].
]

{ #category : #adding }
RSClusterChart >> defaultBandsWidth [
	^ 1
]

{ #category : #adding }
RSClusterChart >> defaultClusterPadding [
	^ 0.3
]

{ #category : #adding }
RSClusterChart >> defaultPlotDomainLength [
	^ 38
]
