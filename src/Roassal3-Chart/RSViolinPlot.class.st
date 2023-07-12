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
		'kernelDensity',
		'densityAreaPoints',
		'densityArea',
		'statisticalMeasures',
		'boxPoints',
		'box',
		'medianLinePoints',
		'centerLinePoints',
		'centerLine',
		'boxWidth',
		'outlierPoints',
		'medianLine',
		'outliers'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| densityPlot |
	densityPlot := self new.
	densityPlot data: aCollection.
	^ densityPlot
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicViolinPlot [
	| violinPlot data |
	data := #(10 20 30 40 40 50).
	violinPlot := self data: data.
	^ violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotDataDomainDiffOf100 [
	| violinPlot data |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := self data: data.
	^ violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotSettingBandwidth [
	| violinPlot data |
	data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
	violinPlot := self data: data.
	violinPlot bandwidth: 5.
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

{ #category : #examples }
RSViolinPlot class >> exampleViolinWithLabels [
	| violinPlot data |
	data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
	violinPlot := self data: data.
	violinPlot
		bandwidth: 3;
		title: 'This is a RSViolinPlot';
		xlabel: 'Data frequency (distribution)';
		ylabel: 'Data domain'.
	^ violinPlot open.
]

{ #category : #accessing }
RSViolinPlot class >> kernelDensity: anRSKernelDensity [
	| densityPlot |
	densityPlot := self new.
	densityPlot kernelDensity: anRSKernelDensity.
	^ densityPlot
]

{ #category : #accessing }
RSViolinPlot >> area [
	^ densityArea
]

{ #category : #accessing }
RSViolinPlot >> areaColor [
	^ self computeColor.
]

{ #category : #accessing }
RSViolinPlot >> bandwidth [
	^ kernelDensity bandwidth.
	
]

{ #category : #accessing }
RSViolinPlot >> bandwidth: aNumber [
	kernelDensity bandwidth: aNumber.
	self computeState.
]

{ #category : #private }
RSViolinPlot >> box [
	^ box.
]

{ #category : #accessing }
RSViolinPlot >> boxWidth [
	^ boxWidth.
]

{ #category : #accessing }
RSViolinPlot >> centerLine [
	^ centerLine
]

{ #category : #private }
RSViolinPlot >> computeBoxPoints [
	| q025 q050 q075 quartiles upperLimit lowerLimit |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q050 := quartiles at: 2.
	q075 := quartiles at: 3.
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	boxWidth := (xValues max - xValues min) * 0.10.
	boxPoints := {(0-(boxWidth/2))@q025. (boxWidth/2)@q025. (boxWidth/2)@q075. (0-(boxWidth/2))@q075}.
	medianLinePoints := { (0-(boxWidth/2))@q050. (boxWidth/2)@q050. }.
	centerLinePoints := { 0@upperLimit. 0@lowerLimit. }.
	outlierPoints := statisticalMeasures outliers collect: [ :y | 0@y ].
]

{ #category : #private }
RSViolinPlot >> computeDensityAreaPoints [
	| densityCurve |
	densityCurve := (kernelDensity densityCurve) collect: [:point | (point y @ point x)].
	densityAreaPoints := densityCurve copy.
	densityCurve reversed do: [ :point | densityAreaPoints add: ((point x * -1) @ point y) ].
]

{ #category : #initialization }
RSViolinPlot >> computeState [
	self computeDensityAreaPoints.
	self computeXValues.
	self computeBoxPoints.
	self computeYValues.
]

{ #category : #initialization }
RSViolinPlot >> computeXValues [
	| xs xMax xMin |
	xs := densityAreaPoints collect: [ :point | point x ].
	xMax := xs max.
	xMin := xs min.
	xValues := {xMin*self defaultAreaMarginRatio. xMax*self defaultAreaMarginRatio. }.
]

{ #category : #private }
RSViolinPlot >> computeYValues [
	| densityCurve yMax yMin maxOutlier minOutlier densityCurveYs upperLimit diff margin |
	outliers := statisticalMeasures outliers.
	maxOutlier := 0.
	minOutlier := 0.
	(outliers isNotEmpty) ifTrue: [ 
		maxOutlier := outliers max.
		minOutlier := outliers min.
	].
	upperLimit := statisticalMeasures upperLimit.
	densityCurve := (kernelDensity densityCurve) collect: [:point | (point y @ point x)].
	densityCurveYs := densityCurve collect: [ :point | point y ].
	yMax := ((statisticalMeasures upperLimit) max: (densityCurveYs max)) max: maxOutlier.
	yMin := ((statisticalMeasures lowerLimit) min: (densityCurveYs min)) min: minOutlier.
	diff := yMax - yMin.
	margin := 0.1*diff.
	yValues := {yMin-margin. yMax+margin.}.
]

{ #category : #accessing }
RSViolinPlot >> createBox [
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: Color white.
	box borderColor: Color black.
]

{ #category : #accessing }
RSViolinPlot >> createCenterLine [
	centerLine := RSPolyline new.
	centerLine := centerLine controlPoints: (centerLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	centerLine width: 1.25.
	centerLine color: Color black.
]

{ #category : #accessing }
RSViolinPlot >> createDensityArea [
	densityArea := self shape copy.
	densityArea color: self computeColor.
	densityArea points: (densityAreaPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	densityArea borderColor: Color black.
]

{ #category : #accessing }
RSViolinPlot >> createMedianLine [
	medianLine := RSPolyline new.
	medianLine := medianLine controlPoints: (medianLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	medianLine width: 2.
	medianLine color: Color black.
]

{ #category : #accessing }
RSViolinPlot >> createOutliers [
	outliers := outlierPoints collect: [ :point | self scalePoint: point ].
	outliers := outliers collect: [ :out |
			| e |
			e := RSEllipse new
			radius: 2;
			color: Color black;
			yourself.
			e translateTo: out.
	] as: RSGroup.
]

{ #category : #accessing }
RSViolinPlot >> createdShapes [
	^ { densityArea. box. medianLine. centerLine. outliers. }
]

{ #category : #accessing }
RSViolinPlot >> data [
	^ kernelDensity data.
]

{ #category : #accessing }
RSViolinPlot >> data: aCollection [
	kernelDensity data: aCollection.
	self statisticalMeasures: (RSStatisticalMeasures data: self data).
	self computeState.
]

{ #category : #defaults }
RSViolinPlot >> defaultAreaColor [
	^ densityArea color.
	
]

{ #category : #defaults }
RSViolinPlot >> defaultAreaMarginRatio [
	^ 1.5.
]

{ #category : #defaults }
RSViolinPlot >> defaultKernelDensity [
	^ RSKernelDensity new.
]

{ #category : #defaults }
RSViolinPlot >> defaultLineColor [
	^ Color r:117 g:107 b:177 range: 255.
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [ 
	^ RSPolygon new
		noPaint.
]

{ #category : #accessing }
RSViolinPlot >> densityArea [
	^ densityArea.
]

{ #category : #defaults }
RSViolinPlot >> densityAreaPoints [
	^ densityAreaPoints.
	
]

{ #category : #private }
RSViolinPlot >> errorMargin: aFloat [
	kernelDensity errorMargin: aFloat.
	self computeState.
]

{ #category : #initialization }
RSViolinPlot >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity.
]

{ #category : #accessing }
RSViolinPlot >> kde: aNumber [
	^ kernelDensity kde: aNumber.
]

{ #category : #accessing }
RSViolinPlot >> kernel [
	^ kernelDensity kernel.
]

{ #category : #accessing }
RSViolinPlot >> kernel: anRSKernelFunction [
	kernelDensity kernel: anRSKernelFunction.
	self computeState.
]

{ #category : #accessing }
RSViolinPlot >> kernelDensity [
	^ kernelDensity.
]

{ #category : #accessing }
RSViolinPlot >> kernelDensity: anRSKernelDensity [
	kernelDensity := anRSKernelDensity.
	self computeState.
]

{ #category : #accessing }
RSViolinPlot >> median [
	^ statisticalMeasures median.
]

{ #category : #private }
RSViolinPlot >> medianLine [
	^ medianLine.
]

{ #category : #private }
RSViolinPlot >> outlierPoints [
	^ outlierPoints.
]

{ #category : #private }
RSViolinPlot >> outliers [
	^ outliers.
]

{ #category : #hooks }
RSViolinPlot >> renderIn: canvas [
	super renderIn: canvas.
	self createDensityArea.
	canvas add: densityArea.
	self createCenterLine.
	canvas add: centerLine.	
	self createBox.
	canvas add: box.
	self createMedianLine.
	canvas add: medianLine.
	self createOutliers.
	canvas addAll: outliers.
]

{ #category : #accessing }
RSViolinPlot >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #private }
RSViolinPlot >> upperWhiskerLimit [
	^ statisticalMeasures upperLimit.
]
