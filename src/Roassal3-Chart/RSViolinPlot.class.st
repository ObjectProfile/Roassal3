"
`RSDensityPlot` is a visual representation that combines a box plot with a density distribution (an approximation of the frequency) to depict the distribution of a dataset.

**Responsibility:** 
- Plots the density distribution area, the box and the whiskers.
- Provides options to customize the plot.

**Collaborators:** 
- The instance variable `kernelDensity` is an `RSKernelDensity` object responsible for calculating the points of the density curve, which delineates the boundary of the density area.
- The instance variable `statisticalMeasures` is an `RSStatisticalMeasures` object that computes various statistical measures, including mean, median, quartiles, and interquartile range (IQR), to facilitate the construction of the box and whiskers plot.

**Public API and Key Messages**
- `data: aCollection` to create instances passing dataset (aCollection) as argument.
- `bandwidth: aFloat` to set the bandwith (h) of the kernel in the kernel density estimation function. By default is computed by `RSKernelDensity`. The float passed indicates how soft will be the curve.

**Instance Variables:**
- `box`: an `RSPolygon` in which the top and bottom correspond to the 3rd and 1st quartiles of the data, respectively.
- `boxPoints`: an `OrderedCollection` of  `Point`s that store the computed `box` points without any scaling.
- `boxWidth`: a `Float` that represents the width of the box in the y domain units.
- `centerLine`: an `RSPolyline` representing the whiskers (upper and lower limits) calculated as (q3 - q1)*1.5.
- `centerLinePoints`: an `OrderedCollection` of  `Point`s that store the computed `centerLine` points without any scaling.
- `densityArea`: an `RSPolygon` that represents the density distribution of the data, calculated by KDE method (`kernelDensity`).
- `densityAreaPoints`: an `OrderedCollection` of  `Point`s that store the computed `densityArea` points without any scaling.
- `kernelDensity`: a `RSKernelDensity` object that made the calculation of the Kernel Density Estimation, several parametres are passed to this object to personalize the curve (bandwidth, kernel, etc.).
- `statisticalMeasures`:	a `RSStatisticalMeasures` object that computes various statistical measures, including mean, median, quartiles, and interquartile range (IQR), to facilitate the construction of the box and whiskers plot.
- `title`: aString that stores the title of the chart.
- `xlabel`:	aString that stores the label of x axis.
- `ylabel`: aString that stores the label of y axis.


**Example:**
```Smalltalk
| violinPlot data |
data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
violinPlot := RSViolinPlot data: data.
violinPlot
	bandwidth: 3;
	title: 'This is a RSViolinPlot';
	xlabel: 'Data frequency (distribution)';
	ylabel: 'Data domain'.
violinPlot open.
```
"
Class {
	#name : #RSViolinPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'violinShapes',
		'offset',
		'bandWidth'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #accessing }
RSViolinPlot class >> dataFrame: aDataSeriesOrDataFrame [
	| violinPlot aDataSeries |
	violinPlot := self new.
	aDataSeriesOrDataFrame class = DataSeries 
		ifTrue: [ aDataSeries := aDataSeriesOrDataFrame ].
	violinPlot dataSeries: aDataSeries.
	^ violinPlot
]

{ #category : #accessing }
RSViolinPlot class >> dataFrame: aDataFrame x: aColumnNameToCategory y: aColumnNameOfData [

	| categoryNames data violinPlot |
	data := OrderedCollection new.
	categoryNames := (aDataFrame column: aColumnNameToCategory)
		                 uniqueValues sort.
	categoryNames do: [ :categoryName |
		| aDataSeries |
		aDataSeries := (aDataFrame select: [ :row |
			                (row at: aColumnNameToCategory) = categoryName ])
			               column: aColumnNameOfData.
		data add: aDataSeries asArray ].
	violinPlot := self new.
	violinPlot data: data.
	violinPlot xTickLabels: categoryNames.
	^ violinPlot
]

{ #category : #examples }
RSViolinPlot class >> example01BasicViolinPlot [
	| boxPlot1   data1  |
	data1 := { 12. 12. 13. 14. 15. 24. }.
	boxPlot1 := self data: data1.
	boxPlot1 xlabel: 'x axis'.
	boxPlot1 ylabel: 'y axis'.
	^ boxPlot1 open.
]

{ #category : #examples }
RSViolinPlot class >> example02MultipleVionlinsArrayOfArrays [

	| boxPlot1 |
	boxPlot1 := self data: {
			            {6. 8. 7. 5. 7. 11. 9. }.
			            {2. 2. 2. 3. 3. 12. 4. 2. 4. 2. 2. 2. 6. 2. 2. 8. 2. 5. 9. 2. 2. 2. 2. 2.}. }.
	^ boxPlot1 open
]

{ #category : #examples }
RSViolinPlot class >> example03DataSeries [

	| boxPlot1 toothGrowthDose |
	toothGrowthDose := (AIDatasets loadToothGrowth) column: 'dose'.
	boxPlot1 := self dataFrame: toothGrowthDose.
	^ boxPlot1 open
]

{ #category : #examples }
RSViolinPlot class >> example04DataFrame [

	| boxPlot1 toothGrowth |
	toothGrowth := AIDatasets loadToothGrowth.
	boxPlot1 := self dataFrame: toothGrowth x: #dose y: #len.
	"boxPlot1 bandwidth: 2."
	^ boxPlot1 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleBorder [

	| violinPlot2 data2 |
	
	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}.}.
	
	violinPlot2 := self data: data2.
	violinPlot2 borders do: [ :aRSBorder | aRSBorder color: Color red; dashArray: { 4. }. ].
	
	^ violinPlot2 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleBorderColorOfEachViolin [

	| violinPlot1 data1 |
	
	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.
	
	violinPlot1 := self data: data1.
	violinPlot1 borders first color: Color green.
	violinPlot1 violinShapes last borderColor: Color red.
	
	^ violinPlot1 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleBorderOfEachViolin [

	| violinPlot2 data2 |
	
	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}. {14. 14. 16. 12. 13. 10. 11. 14.}.}.
	
	violinPlot2 := self data: data2.
	violinPlot2 borders first color: Color red; dashArray: { 4. }. "way 1"
	violinPlot2 violinShapes second borderColor: Color orange. "way 2"
	violinPlot2 violinShapes third border color: Color green. "way 3"
	
	^ violinPlot2 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleBordersColor [

	| violinPlot1 data1 |
	
	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.
	
	violinPlot1 := self data: data1.
	violinPlot1 bordersColor: Color red.
	
	^ violinPlot1 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleBordersColors [

	| violinPlot1 data1 |
	
	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.
	
	violinPlot1 := self data: data1.
	violinPlot1 bordersColors: {Color red. Color purple.}.
	
	^ violinPlot1 open
]

{ #category : #'examples - styling' }
RSViolinPlot class >> exampleStyleColor [
	| violinPlot data |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot color: Color purple translucent.
	^ violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotClusters [
	| violinPlotA violinPlotB data aRSClusterChart |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }. {-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	
	violinPlotA := self data: data.
	violinPlotA bandwidth: 3.
	"violinPlotA color: Color green."
	
	violinPlotB := self data: data.
	violinPlotB bandwidth: 3.
	"violinPlotB color: Color red."
	
	aRSClusterChart := violinPlotA + violinPlotB.
	
	^ aRSClusterChart open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotColors [
	| violinPlot data |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }. {-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot colors: { Color green. Color blue }.
	
	"TO DO: Split violinShapes in compute and a defaultDensityArea"
	"violinPlot violinShapes first densityArea border: (RSBorder new color: Color red; dashArray: {4.})."
	^ violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotWithOutliers [
	| violinPlot data |
	data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	^ violinPlot open.
]

{ #category : #rendering }
RSViolinPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : #rendering }
RSViolinPlot >> bandsWidth: aNumber [
	bandWidth := aNumber.
]

{ #category : #rendering }
RSViolinPlot >> bandwidth: aNumber [
	self kernelBandwidth: aNumber.
]

{ #category : #rendering }
RSViolinPlot >> beforeRenderingIn: aChart [
	| bandScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	bandScale := NSScale ordinal
		domain: xValues;
		rangeBands: { 0. aChart extent x. }.
	aChart xScale: bandScale.
]

{ #category : #accessing }
RSViolinPlot >> borderColor [
	^ self bordersColor first.
]

{ #category : #styling }
RSViolinPlot >> borderColor: aColor [
	self bordersColor: aColor.
]

{ #category : #styling }
RSViolinPlot >> borderColors: aCollectionOfColors [
	self bordersColors: aCollectionOfColors.
]

{ #category : #accessing }
RSViolinPlot >> borders [
	^ violinShapes collect: [ :violin | violin border ].
]

{ #category : #accessing }
RSViolinPlot >> bordersColor [
	^ self borders collect: [ :border | border color ]
]

{ #category : #styling }
RSViolinPlot >> bordersColor: aColor [
	self borders do: [ :border | border color: aColor].
]

{ #category : #styling }
RSViolinPlot >> bordersColors: aCollectionOfColors [
	| borders |
	borders := self borders.
	aCollectionOfColors doWithIndex: [ :aColor :idx | (borders at: idx) color: aColor].
]

{ #category : #rendering }
RSViolinPlot >> boxes [
	^ RSGroup new addAll: (violinShapes collect: [ :violin | violin box ]); yourself.
]

{ #category : #rendering }
RSViolinPlot >> buildChart [
	chart add: self.
	chart
		extent: 360 @ 300;
		padding: 15.
	^ chart
]

{ #category : #initialization }
RSViolinPlot >> canHandleCluster [
	^ true
]

{ #category : #rendering }
RSViolinPlot >> colors: collectionOfColors [
	violinShapes doWithIndex: [ :violinShape :idx | violinShape color: (collectionOfColors at: idx) ].
]

{ #category : #rendering }
RSViolinPlot >> computeBandsOffset [
	violinShapes doWithIndex: [ :boxShape :idx |
		boxShape bandOffset: (xScale scale: (xValues at: idx)) + offset
	].
]

{ #category : #rendering }
RSViolinPlot >> computeBandsWidth [
	violinShapes do: [ :boxShape | boxShape bandWidth: bandWidth ].
]

{ #category : #initialization }
RSViolinPlot >> computeDefualtXTicks [
	self horizontalTick ticks ifNil: [ self xTickLabels: (1 to: self numberOfViolins) ].
]

{ #category : #initialization }
RSViolinPlot >> computeState [
	self computeXValues.
	self computeYValues.
	self computeDefualtXTicks.
]

{ #category : #rendering }
RSViolinPlot >> computeXValues [
	xValues := (1 to: self numberOfViolins).
]

{ #category : #initialization }
RSViolinPlot >> computeYValues [
	| yMax yMin |
	yMax := (violinShapes collect: [ :violinShape | violinShape maxYValue ]) max.
	yMin := (violinShapes collect: [ :violinShape | violinShape minYValue ]) min.
	yValues := {yMin. yMax.}.
]

{ #category : #accessing }
RSViolinPlot >> createdShapes [
	^ violinShapes
]

{ #category : #rendering }
RSViolinPlot >> data: aCollection [
	| collectionOfDatasets |
	
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	self violinShapes: (collectionOfDatasets collect: [ :dataSet | RSViolinPlotShape data: dataSet]).
	"self computeBoxGraphicsCenters."
	self computeState.
]

{ #category : #rendering }
RSViolinPlot >> defaultBandsWidth [
	^ xScale scale: 1
]

{ #category : #'accessing - defaults' }
RSViolinPlot >> defaultShape [ 
	^ RSPolygon new
		noPaint.
]

{ #category : #rendering }
RSViolinPlot >> kernelBandwidth: aNumber [
	violinShapes do: [ :violin | violin kernelBandwidth: aNumber ].
	self computeState.
]

{ #category : #rendering }
RSViolinPlot >> numberOfBands [
	^ self numberOfViolins
]

{ #category : #rendering }
RSViolinPlot >> numberOfViolins [
	^ violinShapes size
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	super renderIn: canvas.
	offset ifNil: [ offset := 1 ].
	self computeBandsOffset.
	
	bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
	self computeBandsWidth.
	
	violinShapes doWithIndex: [ :aRSBoxPlotShape :idx |
		aRSBoxPlotShape color ifNil: [ aRSBoxPlotShape color: self computeColor. ].
		aRSBoxPlotShape scales: {
				self xScale.
				self yScale }.
		aRSBoxPlotShape renderIn: canvas ]
]

{ #category : #rendering }
RSViolinPlot >> violinShapes [
	^ violinShapes
]

{ #category : #rendering }
RSViolinPlot >> violinShapes: collectionOfRSViolinPlotShapes [
	violinShapes := collectionOfRSViolinPlotShapes
	
]
