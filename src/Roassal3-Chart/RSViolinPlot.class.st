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
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #accessing }
RSViolinPlot class >> exampleViolinPlot [
	| boxPlot1   data1  |
	data1 := { 12. 12. 13. 14. 15. 24. }.
	boxPlot1 := self data: data1.
	boxPlot1 xlabel: 'x axis'.
	boxPlot1 ylabel: 'y axis'.
	^ boxPlot1 open.
]

{ #category : #accessing }
RSViolinPlot class >> exampleViolinPlotClusters [
	| violinPlotA violinPlotB data aRSClusterChart |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }. {-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	
	violinPlotA := self data: data.
	violinPlotA bandwidth: 3.
	violinPlotA color: Color green.
	
	violinPlotB := self data: data.
	violinPlotB bandwidth: 3.
	violinPlotB color: Color red.
	
	aRSClusterChart := violinPlotA + violinPlotB.
	
	^ aRSClusterChart open.
]

{ #category : #accessing }
RSViolinPlot class >> exampleViolinPlotColor [
	| violinPlot data |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }. {-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot color: Color green.
	^ violinPlot open.
]

{ #category : #accessing }
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

{ #category : #accessing }
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
	chart horizontalTick ticks ifNil: [ self xTickLabels: (1 to: self numberOfViolins) ].
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

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolygon new
		noPaint.
]

{ #category : #initialization }
RSViolinPlot >> initialize [
	super initialize.
	chart := RSChart new.
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
RSViolinPlot >> open [
	^ self buildChart open.
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
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
