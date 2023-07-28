Extension { #name : #RSViolinPlot }

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> dataFrame: aDataSeriesOrDataFrame [
	| violinPlot aDataSeries |
	violinPlot := self new.
	aDataSeriesOrDataFrame class = DataSeries 
		ifTrue: [ aDataSeries := aDataSeriesOrDataFrame ].
	violinPlot dataSeries: aDataSeries.
	^ violinPlot
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> dataFrame: aDataFrame x: aColumnNameToCategory y: aColumnNameOfData [

	| categoryNames data violinPlot collectionOfDataSeries |
	data := OrderedCollection new.
	categoryNames := (aDataFrame column: aColumnNameToCategory)
		                 uniqueValues sort.
	collectionOfDataSeries := OrderedCollection new. 
	categoryNames do: [ :categoryName |
		| aDataSeries |
		aDataSeries := (aDataFrame select: [ :row |
			                (row at: aColumnNameToCategory) = categoryName ])
			               column: aColumnNameOfData.
		collectionOfDataSeries add: aDataSeries.
		data add: [:ds|ds asArray].] .
	violinPlot := self new.
	violinPlot models: collectionOfDataSeries.
	violinPlot data: data.
	violinPlot xTickLabels: categoryNames.
	violinPlot ylabel: aColumnNameOfData.
	violinPlot xlabel: aColumnNameToCategory.
	^ violinPlot
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot >> dataSeries: aDataSeries [
	self data: aDataSeries asArray.
	self ylabel: aDataSeries name.
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example03DataSeries [

	| boxPlot1 toothGrowthDose |
	toothGrowthDose := (AIDatasets loadToothGrowth) column: 'dose'.
	boxPlot1 := self dataFrame: toothGrowthDose.
	^ boxPlot1 open
]

{ #category : #'*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example04DataFrame [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := self dataFrame: toothGrowth x: #dose y: #len.
	boxPlot1 color: Color purple translucent.
	"boxPlot1 bandwidth: 2."
	^ boxPlot1 open
]
