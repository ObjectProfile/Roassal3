Extension { #name : 'RSViolinPlot' }

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot >> categoryBy: aColumnName [

	| newModels newLabels |
	newModels := OrderedCollection new.
	newLabels := OrderedCollection new.
	models do: [ :df |
		| categories |
		categories := (model column: aColumnName) removeDuplicates sort.
		categories do: [ :category |
			| newDataFrame |
			newDataFrame := df select: [ :row |
				                (row at: aColumnName) = category ].
			newModels add: newDataFrame.
			newLabels add: category ] ].
	self models: newModels.
	self data: dataBlock.
	self xTickLabels: newLabels
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> dataFrame: aDataSeriesOrDataFrame [
	| violinPlot aDataSeries |
	violinPlot := self new.
	aDataSeriesOrDataFrame class = DataSeries 
		ifTrue: [ aDataSeries := aDataSeriesOrDataFrame ].
	violinPlot dataSeries: aDataSeries.
	^ violinPlot
]

{ #category : '*Roassal3-Chart-DataFrame' }
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

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot >> dataSeries: aDataSeries [
	self data: aDataSeries asArray.
	self ylabel: aDataSeries name.
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example03DataSeries [

	| boxPlot1 toothGrowthDose |
	toothGrowthDose := (AIDatasets loadToothGrowth) column: 'dose'.
	boxPlot1 := self dataFrame: toothGrowthDose.
	^ boxPlot1 open
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example04DataFrame [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) y: #len.
	boxPlot1 color: Color purple translucent.
	^ boxPlot1 open
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example05DataFrameCategoryBy [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) y: #len; categoryBy: #dose.
	boxPlot1 xlabel: 'dose'.
	boxPlot1 ylabel: 'len'.
	^ boxPlot1 open
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example06DataFrameHue [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) y: #len; hue:#supp.
	^ boxPlot1 open
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> example07DataFrameCategoryAndHue [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := (self fromDataFrame: toothGrowth) y: #len; categoryBy: #dose; hue:#supp.
	^ boxPlot1 open
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot class >> fromDataFrame: aDataFrame [
	| violinPlot |
	violinPlot := self new.
	violinPlot model: aDataFrame.
	violinPlot models: { aDataFrame }.
	^ violinPlot
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot >> hue: aColumnName [

	| categories clusteredChart |
	categories := (model column: aColumnName) removeDuplicates sort.

	clusteredChart := RSClusterChart new.

	categories doWithIndex: [ :category :idx |
		| newModels newViolinPlot |
		newViolinPlot := self class new.
		newModels := OrderedCollection new.
		models do: [ :df |
			| newDataFrame |
			newDataFrame := df select: [ :row |
				                (row at: aColumnName) = category ].
			newModels add: newDataFrame ].
		newViolinPlot models: newModels.
		newViolinPlot data: dataBlock.
		clusteredChart := clusteredChart + newViolinPlot ].
	^ clusteredChart
]

{ #category : '*Roassal3-Chart-DataFrame' }
RSViolinPlot >> y: aColumnName [
	
	self data: [ :df | (df column: aColumnName) asArray ].
	self computeState.
]
