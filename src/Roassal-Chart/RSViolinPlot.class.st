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
	#name : 'RSViolinPlot',
	#superclass : 'RSAbstractBandPlot',
	#instVars : [
		'models',
		'model',
		'dataBlock'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSViolinPlot class >> data: aCollection [
	| plot |
	plot := self new.
	plot data: aCollection.
	^ plot
]

{ #category : 'examples' }
RSViolinPlot class >> example01BasicViolinPlot [
	| boxPlot1   data1  |
	data1 := { 12. 12. 13. 14. 15. 24. }.
	boxPlot1 := self data: data1.
	boxPlot1 xlabel: 'x axis'.
	boxPlot1 ylabel: 'y axis'.
	^ boxPlot1 open
]

{ #category : 'examples' }
RSViolinPlot class >> example02MultipleVionlinsArrayOfArrays [

	| boxPlot1 |
	boxPlot1 := self data: {
			            {6. 8. 7. 5. 7. 11. 9. }.
			            {2. 2. 2. 3. 3. 12. 4. 2. 4. 2. 2. 2. 6. 2. 2. 8. 2. 5. 9. 2. 2. 2. 2. 2.}. }.
	^ boxPlot1 open
]

{ #category : 'examples' }
RSViolinPlot class >> example03HorizontalViolinPlot [
	| violinPlot   data1  |
	data1 := { 12. 12. 13. 14. 15. 24. }.
	violinPlot := self data: data1.
	violinPlot xlabel: 'x axis'.
	violinPlot ylabel: 'y axis'.
	violinPlot horizontal.
	^ violinPlot open
]

{ #category : 'examples' }
RSViolinPlot class >> example03HorizontalVionlins [

	| violinPlot |
	violinPlot := self data: {
			            {6. 8. 7. 5. 7. 11. 9. }.
			            {2. 2. 2. 3. 3. 12. 4. 2. 4. 2. 2. 2. 6. 2. 2. 8. 2. 5. 9. 2. 2. 2. 2. 2.}. }.
	violinPlot horizontal.
	^ violinPlot open
]

{ #category : 'examples' }
RSViolinPlot class >> example03HorizontalVionlinsShowBands [

	| violinPlot |
	violinPlot := self data: {
			            {6. 8. 7. 5. 7. 11. 9. }.
			            {2. 2. 2. 3. 3. 12. 4. 2. 4. 2. 2. 2. 6. 2. 2. 8. 2. 5. 9. 2. 2. 2. 2. 2.}. }.
	violinPlot horizontal.
	violinPlot showBands.
	^ violinPlot open
]

{ #category : 'examples' }
RSViolinPlot class >> example08Positions [
	| boxPlot1 data1 |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }.
			 { 1. 2. 2. 2. 3. 4. 3. 5. 12. } . }.
	boxPlot1 := self data: data1.
	boxPlot1 positions: { 1. 6. 3. 5.}.
	boxPlot1 showBands.
	^ boxPlot1 open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleDays [
	| chart p1 p2 p3 y1 y2 y3 |

	y1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.

	y2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.

	y3 := { { 1. 2. 3. 3. 3. 5. 3. 5. 5. 7. 8. 5. 6. 10. 11. } .
			 { 12. 7. 10. 11. 11. 13. 10. 11. 12. 11. 15. 16. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. 25. 24. 25. 26. 24. 23. 23. 25. 25. }  }.

	p1 := self data: y1. "blue"
	p2 := self data: y2. "sky blue"
	p3 := self data: y3. "orange"
	chart := p1 + p2 + p3.
	chart xTickLabels: { 'Day 1'. 'Day 2'. 'Day 3' }.
	^ chart open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleDaysHorizontal [
	| chart p1 p2 p3 y1 y2 y3 |

	y1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.

	y2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.

	y3 := { { 1. 2. 3. 3. 3. 5. 3. 5. 5. 7. 8. 5. 6. 10. 11. } .
			 { 12. 7. 10. 11. 11. 13. 10. 11. 12. 11. 15. 16. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. 25. 24. 25. 26. 24. 23. 23. 25. 25. }  }.

	p1 := self data: y1. "blue"
	p2 := self data: y2. "sky blue"
	p3 := self data: y3. "orange"
	chart := p1 + p2 + p3.
	chart horizontal.
	^ chart open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleErrorMargin [
	| violinPlot data |
	data := {{5. 12. 12. 13. 14. 14. 15. 24. }. {1. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot verticalTick
		numberOfTicks: 10.
	violinPlot errorMargin: 0.09.
	^ violinPlot open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleMedianLineStyle [

	| violinPlot2 data2 |

	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}. {14. 14. 16. 12. 13. 10. 11. 14.}.}.

	violinPlot2 := self data: data2.
	violinPlot2 medianLine: (RSLine new color: Color red).
	violinPlot2 medianLines first color: Color green.
	^ violinPlot2 open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleModel [
	| violinPlot |
	violinPlot := self new.
	violinPlot models: { SequenceableCollection }.
	violinPlot data: [ :cls| cls methods collect: [ :met | met linesOfCode ] ].
	^ violinPlot open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleModels [
	| violinPlot accessor |
	accessor := [ :cls| cls methods collect: [ :met | met linesOfCode ] ].
	violinPlot := self new.
	violinPlot models: (String withAllSubclasses
		reject: [:cls | (accessor rsValue: cls) isEmpty ]).
	violinPlot data: accessor.
	^ violinPlot open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyle [

	| violinPlot2 data2 paint |

	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}. {14. 14. 16. 12. 13. 10. 11. 14.}.}.

	violinPlot2 := self data: data2.
	paint := LinearGradientPaint fromArray: { 0 -> Color gray. 1 -> Color red }.
	paint start: 0@ -50.
	paint stop: 0@ 50.
	violinPlot2 violinShapes do: [:vs| vs area color: paint ].

	^ violinPlot2 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleBorder [

	| violinPlot2 data2 |

	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}.}.

	violinPlot2 := self data: data2.
	violinPlot2 borders do: [ :aRSBorder | aRSBorder color: Color red; dashArray: { 4. }. ].

	^ violinPlot2 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleBorderColorOfEachViolin [

	| violinPlot1 data1 |

	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.

	violinPlot1 := self data: data1.
	violinPlot1 borders first color: Color green.
	violinPlot1 violinShapes last borderColor: Color red.

	^ violinPlot1 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleBorderOfEachViolin [

	| violinPlot2 data2 |

	data2 := {{ 12. 12. 13. 15. 18. 20. 21. 24. }.{15. 15. 18. 12. 13. 10. 11. 14.}. {14. 14. 16. 12. 13. 10. 11. 14.}.}.

	violinPlot2 := self data: data2.
	violinPlot2 borders first color: Color red; dashArray: { 4. }. "way 1"
	violinPlot2 violinShapes second borderColor: Color orange. "way 2"
	violinPlot2 violinShapes third border color: Color green. "way 3"

	^ violinPlot2 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleBordersColor [

	| violinPlot1 data1 |

	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.

	violinPlot1 := self data: data1.
	violinPlot1 bordersColor: Color red.

	^ violinPlot1 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleBordersColors [

	| violinPlot1 data1 |

	data1 := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.

	violinPlot1 := self data: data1.
	violinPlot1 bordersColors: {Color red. Color purple.}.

	^ violinPlot1 open
]

{ #category : 'examples - styling' }
RSViolinPlot class >> exampleStyleColor [
	| violinPlot data |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot color: Color purple translucent.
	^ violinPlot open
]

{ #category : 'examples' }
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

	^ aRSClusterChart open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleViolinPlotColors [
	| violinPlot data |
	data := {{-5. 12. 12. 13. 14. 14. 15. 24. }. {-5. 12. 12. 13. 14. 14. 15. 24. }.}.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot colors: { Color green. Color blue }.

	"TO DO: Split violinShapes in compute and a defaultDensityArea"
	"violinPlot violinShapes first densityArea border: (RSBorder new color: Color red; dashArray: {4.})."
	^ violinPlot open
]

{ #category : 'examples' }
RSViolinPlot class >> exampleViolinPlotWithOutliers [
	| violinPlot data |
	data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	^ violinPlot open
]

{ #category : 'accessing' }
RSViolinPlot class >> model: aModel [
	| boxPlot |
	boxPlot := self new.
	boxPlot model: aModel.
	^ boxPlot
]

{ #category : 'accessing' }
RSViolinPlot class >> models: aCollectionOfModels [
	| boxPlot |
	boxPlot := self new.
	boxPlot models: aCollectionOfModels.
	^ boxPlot
]

{ #category : 'rendering' }
RSViolinPlot >> bandwidth: aNumber [
	self kernelBandwidth: aNumber
]

{ #category : 'accessing' }
RSViolinPlot >> borderColor [
	^ self bordersColor first
]

{ #category : 'styling' }
RSViolinPlot >> borderColor: aColor [
	self bordersColor: aColor
]

{ #category : 'styling' }
RSViolinPlot >> borderColors: aCollectionOfColors [
	self bordersColors: aCollectionOfColors
]

{ #category : 'accessing' }
RSViolinPlot >> borders [
	^ bandPlotShapes collect: [ :violin | violin border ]
]

{ #category : 'accessing' }
RSViolinPlot >> bordersColor [
	^ self borders collect: [ :border | border color ]
]

{ #category : 'styling' }
RSViolinPlot >> bordersColor: aColor [
	self borders do: [ :border | border color: aColor]
]

{ #category : 'styling' }
RSViolinPlot >> bordersColors: aCollectionOfColors [
	| borders |
	borders := self borders.
	aCollectionOfColors doWithIndex: [ :aColor :idx | (borders at: idx) color: aColor]
]

{ #category : 'rendering' }
RSViolinPlot >> boxes [
	^ RSGroup new addAll: (bandPlotShapes collect: [ :violin | violin box ]); yourself
]

{ #category : 'rendering' }
RSViolinPlot >> buildChart [
	chart add: self.
	chart
		extent: 360 @ 300;
		padding: 15.
	^ chart
]

{ #category : 'initialization' }
RSViolinPlot >> canHandleCluster [
	^ true
]

{ #category : 'accessing' }
RSViolinPlot >> colors: collectionOfColors [
	bandPlotShapes doWithIndex: [ :violinShape :idx | violinShape color: (collectionOfColors at: idx) ]
]

{ #category : 'initialization' }
RSViolinPlot >> computeState [
	self computeXValues.
	self computeYValues
]

{ #category : 'rendering' }
RSViolinPlot >> computeXValues [
	xValues := (1 to: self numberOfViolins)
]

{ #category : 'initialization' }
RSViolinPlot >> computeYValues [
	| yMax yMin |
	yMax := (bandPlotShapes collect: [ :violinShape | violinShape maxDataValue ]) max.
	yMin := (bandPlotShapes collect: [ :violinShape | violinShape minDataValue ]) min.
	yValues := {yMin. yMax.}
]

{ #category : 'accessing' }
RSViolinPlot >> createViolinShapeFor: anObject dataset: dataset [
	self assert: dataset notEmpty description: 'dataset can not be empty'.
	^ RSViolinPlotShape new
		data: dataset;
		model: anObject;
		yourself
]

{ #category : 'accessing' }
RSViolinPlot >> createViolinShapesWithDataSet: collectionOfDatasets [
	| groupOfModels newViolinShapes |
	groupOfModels := models.
	groupOfModels ifNil: [ groupOfModels := Array new: collectionOfDatasets size ].

	newViolinShapes := groupOfModels with: collectionOfDatasets collect: [ :anObject :dataset |
		self createViolinShapeFor: anObject dataset: dataset.
		 ].
	self violinShapes: newViolinShapes
]

{ #category : 'accessing' }
RSViolinPlot >> createdShapes [
	^ { bandPlotShapes }
]

{ #category : 'accessing' }
RSViolinPlot >> data [
	| collectionOfDatasets |
	collectionOfDatasets := bandPlotShapes collect: [ :violin | violin data ].
	collectionOfDatasets size = 1 ifTrue: [ collectionOfDatasets := collectionOfDatasets first].
	^ collectionOfDatasets
]

{ #category : 'accessing' }
RSViolinPlot >> data: dataset [

	"dataset could be:
	- aCollection of raw data (numbers)
	- aCollection of collections
	- aBlock to get the data from the model (previously stored in model)"

	| collectionOfDatasets |
	dataset isBlock ifTrue: [ dataBlock := dataset ].
	collectionOfDatasets := self extractDatasetsFrom: dataset.
	self createViolinShapesWithDataSet: collectionOfDatasets.
	self computeState
]

{ #category : 'accessing - computed' }
RSViolinPlot >> datasetsFromModels: data [
	models ifNil: [ ^ data ].
	^ models collect: [:anOjbect | data rsValue: anOjbect ]
]

{ #category : 'accessing - defaults' }
RSViolinPlot >> defaultShape [
	^ RSPolygon new
		noPaint
]

{ #category : 'accessing' }
RSViolinPlot >> errorMargin: aNumber [
	bandPlotShapes do: [ :vs | vs errorMargin: aNumber ]
]

{ #category : 'accessing - computed' }
RSViolinPlot >> extractDatasetsFrom: data [
	| result datasets |
	datasets := self datasetsFromModels: data.
	self assert: datasets isCollection description: 'use a collection of numbers'.
	self assert: datasets isNotEmpty description: 'You can not have empty collection'.
	result := datasets first isCollection
		ifTrue: [ datasets ]
		ifFalse: [ { datasets } ].
	^ result
]

{ #category : 'initialization' }
RSViolinPlot >> initialize [
	super initialize.
	bandPlotShapes := OrderedCollection new.
	horizontal := false
]

{ #category : 'rendering' }
RSViolinPlot >> kernelBandwidth: aNumber [
	bandPlotShapes do: [ :violin | violin kernelBandwidth: aNumber ].
	self computeState
]

{ #category : 'styling' }
RSViolinPlot >> medianLine: aRSLineModel [
	bandPlotShapes do: [ :bs | bs medianLine: aRSLineModel ]
]

{ #category : 'accessing' }
RSViolinPlot >> medianLines [
	^ RSGroup new addAll: (bandPlotShapes collect: [ :violin | violin medianLine ]); yourself
]

{ #category : 'rendering' }
RSViolinPlot >> model [
	^ model
]

{ #category : 'rendering' }
RSViolinPlot >> model: aModel [
	model := aModel
]

{ #category : 'rendering' }
RSViolinPlot >> models [
	^ models
]

{ #category : 'rendering' }
RSViolinPlot >> models: aCollectionOfModels [
	models := aCollectionOfModels
]

{ #category : 'rendering' }
RSViolinPlot >> numberOfViolins [
	^ bandPlotShapes size
]

{ #category : 'rendering' }
RSViolinPlot >> renderIn: canvas [
	super renderIn: canvas.
	offset ifNil: [ offset := 1 ].
	self computeBandsOffset.

	bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
	self computeBandsWidth.

	bandPlotShapes doWithIndex: [ :violinPlotShape :idx |
		violinPlotShape color ifNil: [ violinPlotShape color: self computeColor. ].
		violinPlotShape bandScale: bandScale.
		violinPlotShape dataScale: dataScale.
		violinPlotShape renderIn: canvas ]
]

{ #category : 'rendering' }
RSViolinPlot >> violinShapes [
	^ bandPlotShapes
]

{ #category : 'rendering' }
RSViolinPlot >> violinShapes: collectionOfRSViolinPlotShapes [
	bandPlotShapes := collectionOfRSViolinPlotShapes
]
