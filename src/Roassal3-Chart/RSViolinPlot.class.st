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
- `area`: an `RSPolygon` that represents the area under the density curve.
- `curvePoints`: an `OrderedCollection` of  `Point`s that store the result of evaluate the Kernel Density Estimation.
- `kernelDensity`: a `RSKernelDensity` object that made the calculation of the Kernel Density Estimation, several parametres are passed to this object to personalize the curve (bandwidth, kernel, etc.).
- `title`: aString that stores the title of the chart.
- `xlabel`:	aString that stores the label of x axis.
- `ylabel`: aString that stores the label of y axis.

**Example:**
```Smalltalk
| densityPlot data |
data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
densityPlot := RSDensityPlot data: data.
densityPlot bandwidth: 10.
densityPlot xlabel: 'X label'; ylabel: 'Y label'; title: 'Density plot (bandwidth:10)'.
densityPlot color: Color green.
densityPlot open.
```

Internal Representation and Key Implementation Points.

    Instance Variables
	box:		<Object>
	boxPoints:		<Object>
	boxWidth:		<Object>
	centerLinePoints:		<Object>
	densityArea:		<Object>
	densityAreaPoints:		<Object>
	kernelDensity:		<Object>
	medianLinePoints:		<Object>
	outlierPoints:		<Object>
	statisticalMeasures:		<Object>
	title:		<Object>
	xlabel:		<Object>
	ylabel:		<Object>


    Implementation Points
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
		'xlabel',
		'ylabel',
		'title',
		'centerLinePoints',
		'boxWidth',
		'outlierPoints'
	],
	#category : #'Roassal3-Chart-Plots'
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
	violinPlot := RSViolinPlot data: data.
	violinPlot bandwidth.
	violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicViolinPlot2 [
	| violinPlot data |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := self data: data.
	violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleViolinPlotWithOutliers [
	| violinPlot data |
	data := {-5. 12. 12. 13. 14. 14. 15. 24. }.
	violinPlot := self data: data.
	violinPlot bandwidth: 3.
	violinPlot open.
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

{ #category : #accessing }
RSViolinPlot >> boxWidth [
	^ boxWidth.
]

{ #category : #opening }
RSViolinPlot >> buildChart [
	chart := RSChart new.
	chart add: self.
	chart
		extent: 250 @ 200;
		ylabel: self ylabel;
		xlabel: self xlabel;
		title: self title.
	^ chart
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
RSViolinPlot >> computeCurvePoints [
	| densityCurve |
	densityCurve := (kernelDensity densityCurve) collect: [:point | (point y @ point x)].
	densityAreaPoints := densityCurve copy.
	densityCurve reversed do: [ :point | densityAreaPoints add: ((point x * -1) @ point y) ].
]

{ #category : #initialization }
RSViolinPlot >> computeState [
	self computeCurvePoints.
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
	| densityCurve yMax yMin maxOutlier minOutlier outliers densityCurveYs upperLimit diff margin |
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
RSViolinPlot >> createdShapes [
	^ { densityArea. box. }
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

{ #category : #opening }
RSViolinPlot >> open [
	^ self buildChart open
]

{ #category : #private }
RSViolinPlot >> outlierPoints [
	^ outlierPoints.
]

{ #category : #private }
RSViolinPlot >> outliers [
	^ statisticalMeasures outliers.
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	| medianLine centerLine outliers |
	densityArea := self shape copy.
	densityArea color: self computeColor.
	densityArea points: (densityAreaPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	densityArea borderColor: Color black.
	canvas add: densityArea.
	
	centerLine := RSPolyline new.
	centerLine := centerLine controlPoints: (centerLinePoints collect: [ :aPoint | self scalePoint: aPoint ]).
	centerLine width: 1.25.
	centerLine color: Color black.
	canvas add: centerLine.
	
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: Color white.
	box borderColor: Color black.
	canvas add: box.
	
	medianLine := RSPolyline new.
	medianLine := medianLine controlPoints: (medianLinePoints collect: [ :aPoint | self scalePoint: aPoint ]).
	medianLine width: 2.
	medianLine color: Color black.
	canvas add: medianLine.
	
	outliers := outlierPoints collect: [ :point | self scalePoint: point ].
	outliers do: [ :out |
			| e |
			e := RSEllipse new
			radius: 2;
			color: Color black;
			yourself.
			e translateTo: out.
			canvas add: e.
	].
]

{ #category : #accessing }
RSViolinPlot >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #accessing }
RSViolinPlot >> title [
	^ title.
]

{ #category : #accessing }
RSViolinPlot >> title: aString [
	title := aString.
]

{ #category : #private }
RSViolinPlot >> upperWhiskerLimit [
	^ statisticalMeasures upperLimit.
]

{ #category : #accessing }
RSViolinPlot >> xlabel [
	^ xlabel
]

{ #category : #accessing }
RSViolinPlot >> xlabel: aString [
	xlabel := aString
]

{ #category : #accessing }
RSViolinPlot >> ylabel [
	^ ylabel
]

{ #category : #accessing }
RSViolinPlot >> ylabel: aString [
	ylabel := aString
]
