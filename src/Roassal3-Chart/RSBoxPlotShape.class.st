"
`RSBoxPlotShape` is a visual representation of the distribution of one dataset. It provides a visual summary of the data's spread, central tendency, and the presence of outliers.
- The box represents the interquartile range (IQR) of the data, which is the middle 50% of the dataset. It spans from the first quartile (Q1) to the third quartile (Q3).
- The central line marks the median value.
- The whiskers extend from the edges of the box and indicate the data range. The upper whisker extends to the maximum value within a certain limit (by default, 1.5 times the IQR), and the lower whisker extends to the minimum value within the same limit.
- The outliers are data points that fall outside the whiskers.

**Responsibility:**
- This class plots one box and their corresponding whiskers and outliers given a dataset.
- It provides options to customize the box.
- Note: the data will be sorted by the class.

**Collaborators:** 
- **`RSStatisticalMeasures`:** The instance variable `statisticalMeasures` is an object which given a dataset store the data sorted, calculates and returns the statistical measures (median, mean, quartiles, etc.).

**Public API and Key Messages**
- `TO DO`

**Instance Variables:**
- `bandWidth`: a `Number` expressed in pixels (scaled) that determine the box width.
- `bandOffset`: a `Number` expressed in pixels (scaled) that determine the offset of the box in the plot.

**Example:**
Instance creation
```Smalltalk
| boxPlotShape data |
data := { 1. 2. 3. 4. 5. } .
boxPlotShape := RSBoxPlotShape data: data.
```
"
Class {
	#name : #RSBoxPlotShape,
	#superclass : #RSComposite,
	#instVars : [
		'bandWidth',
		'statisticalMeasures',
		'box',
		'medianLine',
		'outliers',
		'color',
		'xScale',
		'yScale',
		'graphCenter',
		'bandOffset',
		'outlier',
		'shouldShowBand',
		'upperWhisker',
		'lowerWhisker',
		'whisker',
		'medianConfidencePercentage',
		'notched',
		'notchWidthPercentage'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxPlotShape class >> data: collectionOfData1D [
	| boxGraph |
	boxGraph := self new.
	boxGraph data: collectionOfData1D.
	^ boxGraph
]

{ #category : #accessing }
RSBoxPlotShape class >> data: collectionOfData1D scales: collectionOfNSScales [
	| boxGraph |
	boxGraph := self data: collectionOfData1D.
	boxGraph scales: collectionOfNSScales.
	^ boxGraph.
]

{ #category : #accessing }
RSBoxPlotShape >> addChildrenToComposite [
	| shapesToRender |
	shapesToRender := self shapesToRender.
	self addAll: shapesToRender.
	self adjustToChildren.
	^ self.
]

{ #category : #accessing }
RSBoxPlotShape >> bandOffset: aNumber [
	bandOffset := aNumber.
]

{ #category : #accessing }
RSBoxPlotShape >> bandWidth: aNumber [
	bandWidth := aNumber
]

{ #category : #accessing }
RSBoxPlotShape >> box [
	^ box
]

{ #category : #accessing }
RSBoxPlotShape >> boxWidth [
	^ bandWidth.
]

{ #category : #accessing }
RSBoxPlotShape >> center [
	^ graphCenter
]

{ #category : #accessing }
RSBoxPlotShape >> color [
	^ color
]

{ #category : #accessing }
RSBoxPlotShape >> color: aColor [
	color := aColor.
]

{ #category : #accessing }
RSBoxPlotShape >> computeBandRectangle [
	^ RSPolygon new
			points: { 
			(graphCenter-(bandWidth/2)) @ 0. 
			(graphCenter+(bandWidth/2)) @ 0.
			(graphCenter+(bandWidth/2)) @ yScale range last. 
			(graphCenter-(bandWidth/2)) @ yScale range last
			};
			color: Color blue translucent.
]

{ #category : #accessing }
RSBoxPlotShape >> confidenceInterval [
	^ statisticalMeasures confidenceInterval.
	
]

{ #category : #accessing }
RSBoxPlotShape >> confidencePercentage [
	^ medianConfidencePercentage 
]

{ #category : #accessing }
RSBoxPlotShape >> confidencePercentage: aNumber [
	medianConfidencePercentage := aNumber.
]

{ #category : #accessing }
RSBoxPlotShape >> createBoxShape [
	| boxPoints q025 q075 quartiles median medianConfidenceInterval medianCIMax medianCIMin notchWidth |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	
	boxPoints := { 
		(graphCenter-(bandWidth/2)) @ (yScale scale: q025)."bottom left" 
		(graphCenter+(bandWidth/2)) @ (yScale scale: q025)."bottom right"
	} asOrderedCollection.
	
	notchWidth := bandWidth * notchWidthPercentage.
	median := quartiles at: 2.
	medianConfidenceInterval := self medianConfidenceInterval.
	medianCIMax := medianConfidenceInterval max.
	medianCIMin := medianConfidenceInterval min.
	
	notched ifTrue: [ 
		boxPoints addAll: { 
		(graphCenter+(bandWidth/2))@(yScale scale: medianCIMin).
		(graphCenter+(notchWidth/2))@(yScale scale: median).
		(graphCenter+(bandWidth/2))@(yScale scale: medianCIMax).}	
	].
	
	boxPoints addAll: { 
		(graphCenter+(bandWidth/2)) @ (yScale scale: q075)."top right"
		(graphCenter-(bandWidth/2)) @ (yScale scale: q075)."top left" }.

	notched ifTrue: [ 
		boxPoints addAll: { 
		(graphCenter-(bandWidth/2))@(yScale scale: medianCIMax).
		(graphCenter-(notchWidth/2))@(yScale scale: median).
		(graphCenter-(bandWidth/2))@(yScale scale: medianCIMin). }	
	].
	
	box points: boxPoints.
]

{ #category : #accessing }
RSBoxPlotShape >> createMedianLine [
	| q050 medianLinePoints lineWidth |
	q050 := statisticalMeasures quartiles second.
	"graphCenter was already computed in shapesWithCenterAt"
	lineWidth := bandWidth * notchWidthPercentage.
	
	medianLinePoints := { 
		(graphCenter-(lineWidth/2))@ (yScale scale: q050). 
		(graphCenter+(lineWidth/2))@ (yScale scale: q050). }.
	medianLine := medianLine controlPoints: medianLinePoints.
]

{ #category : #accessing }
RSBoxPlotShape >> createOutliersShapes [
	| outliersPoints |
	"graphCenter was already computed in shapesWithCenterAt"
	outliersPoints := statisticalMeasures outliers collect: [ :y | graphCenter@ (yScale scale: y) ].
	outlier extent x isZero ifTrue: [ outlier size: bandWidth * 0.15 ].
	outliers := outliersPoints collect: [ :out |
			| e |
			e := outlier copy.
			e translateTo: out.
	] as: RSGroup.
]

{ #category : #accessing }
RSBoxPlotShape >> createWhiskerLines [
	| upperLimit lowerLimit q1 q3 upperWhiskerPoints lowerWhiskerPoints |
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	q1 := statisticalMeasures quartiles first.
	q3 := statisticalMeasures quartiles third.
	"graphCenter was already computed in shapesWithCenterAt"
	upperWhiskerPoints := { graphCenter@(yScale scale: q3). graphCenter@ (yScale scale: upperLimit). }.
	lowerWhiskerPoints := { graphCenter@(yScale scale: q1). graphCenter@ (yScale scale: lowerLimit). }.
	upperWhisker := whisker copy.
	lowerWhisker := whisker copy.
	upperWhisker controlPoints: upperWhiskerPoints.
	lowerWhisker controlPoints: lowerWhiskerPoints.
]

{ #category : #accessing }
RSBoxPlotShape >> data [
	^ self statisticalMeasures data.
]

{ #category : #accessing }
RSBoxPlotShape >> data: collectionOfData1D [
	self statisticalMeasures: (RSStatisticalMeasures data: collectionOfData1D).
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBandPadding [
	^ 0.2
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBox [
	^ RSPolygon new
		color: color;
		border: (RSBorder new color: Color black; joinRound).
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBoxWidth [
	^ 0.7
]

{ #category : #defaults }
RSBoxPlotShape >> defaultGraphCenter [
	^ 1
]

{ #category : #defaults }
RSBoxPlotShape >> defaultMedianConfidencePercentage [
	^ 95
]

{ #category : #defaults }
RSBoxPlotShape >> defaultMedianLine [
	^ RSPolyline new
		width: 2;
		color: Color black.
]

{ #category : #defaults }
RSBoxPlotShape >> defaultNotched [
	^ false.
]

{ #category : #defaults }
RSBoxPlotShape >> defaultOutlier [
	^ RSEllipse new
		radius: 4;
		color: Color black;
		size: 0.
]

{ #category : #defaults }
RSBoxPlotShape >> defaultShouldShowBand [
	^ false
]

{ #category : #defaults }
RSBoxPlotShape >> defaultWhisker [
	^ RSPolyline new
		width: 1;
		color: Color black.
]

{ #category : #accessing }
RSBoxPlotShape >> graphCenter [
	^ graphCenter.
]

{ #category : #accessing }
RSBoxPlotShape >> graphCenter: aNumber [
	graphCenter := aNumber.
]

{ #category : #defaults }
RSBoxPlotShape >> hasOutliers [
	^ self outlierValues isNotEmpty
]

{ #category : #initialization }
RSBoxPlotShape >> initialize [
	super initialize.
	graphCenter := self defaultGraphCenter.
	whisker := self defaultWhisker.
	upperWhisker := self defaultWhisker.
	lowerWhisker := self defaultWhisker.
	medianLine := self defaultMedianLine.
	box := self defaultBox.
	outlier := self defaultOutlier.
	shouldShowBand := self defaultShouldShowBand.
	medianConfidencePercentage := self defaultMedianConfidencePercentage.
	notched := self defaultNotched.
	notchWidthPercentage := 1.
]

{ #category : #accessing }
RSBoxPlotShape >> iqr [
	^ statisticalMeasures iqr.
]

{ #category : #accessing }
RSBoxPlotShape >> lowerLimit [
	^ statisticalMeasures lowerLimit.
]

{ #category : #accessing }
RSBoxPlotShape >> lowerWhisker [
	^ lowerWhisker
]

{ #category : #accessing }
RSBoxPlotShape >> maxYValue [
	| maxValue |
	maxValue := self upperLimit.
	notched ifTrue: [ maxValue := maxValue max: self medianConfidenceInterval max ].
	self hasOutliers 
		ifTrue: [ maxValue := maxValue max: (self outlierValues max) ].
	^ maxValue.
]

{ #category : #accessing }
RSBoxPlotShape >> median [
	^ statisticalMeasures median.
]

{ #category : #accessing }
RSBoxPlotShape >> medianConfidenceInterval [
	^ statisticalMeasures medianConfidenceInterval.
	
]

{ #category : #accessing }
RSBoxPlotShape >> medianConfidencePercentage: aNumber [
	medianConfidencePercentage := aNumber.
]

{ #category : #accessing }
RSBoxPlotShape >> medianLine [
	^ medianLine.
]

{ #category : #accessing }
RSBoxPlotShape >> minYValue [
	| minValue |
	minValue := self lowerLimit.
	notched ifTrue: [ minValue := minValue min: (self medianConfidenceInterval min) ].
	self hasOutliers 
		ifTrue: [ minValue := minValue min: (self outlierValues min) ].
	^ minValue.
]

{ #category : #accessing }
RSBoxPlotShape >> notch: aBoolean [
	notched := aBoolean
]

{ #category : #accessing }
RSBoxPlotShape >> outlier: markerShape [
	outlier := markerShape
]

{ #category : #accessing }
RSBoxPlotShape >> outlierMarker: markerShapeString [
	outlier := (RSShapeFactory shapeFromString: markerShapeString) color: Color black.
]

{ #category : #accessing }
RSBoxPlotShape >> outlierSize: aDimensionInPixels [
	outlier size: aDimensionInPixels.
]

{ #category : #accessing }
RSBoxPlotShape >> outlierValues [
	^ statisticalMeasures outliers.
]

{ #category : #accessing }
RSBoxPlotShape >> outliers [
	^ outlier.
]

{ #category : #accessing }
RSBoxPlotShape >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
]

{ #category : #accessing }
RSBoxPlotShape >> quartiles [
	^ statisticalMeasures quartiles.
]

{ #category : #accessing }
RSBoxPlotShape >> renderIn: canvas [
	self addChildrenToComposite.
	canvas add: self.
]

{ #category : #accessing }
RSBoxPlotShape >> scalePoint: aPoint [
	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #accessing }
RSBoxPlotShape >> scales: collectionOfNSScales [
	self xScale: collectionOfNSScales first.
	self yScale: collectionOfNSScales second.
]

{ #category : #accessing }
RSBoxPlotShape >> shapesToRender [
	| band shapes |
	self graphCenter: bandOffset.
	notched ifTrue: [ notchWidthPercentage := 0.5 ].
	self createWhiskerLines.
	self createMedianLine.
	self createBoxShape.
	box color: color.
	self createOutliersShapes.
	shapes := OrderedCollection withAll: {
			          upperWhisker.
						 lowerWhisker.
			          box.
			          medianLine. }.
	shapes addAll: outliers.
	shouldShowBand ifTrue: [
		band := self computeBandRectangle.
		shapes add: band ].
	^ shapes
]

{ #category : #accessing }
RSBoxPlotShape >> shouldShowBand: aBoolean [
	shouldShowBand := aBoolean.
]

{ #category : #accessing }
RSBoxPlotShape >> showBand [
	self shouldShowBand: true.
]

{ #category : #accessing }
RSBoxPlotShape >> statisticalMeasures [
	^ statisticalMeasures.
]

{ #category : #accessing }
RSBoxPlotShape >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #accessing }
RSBoxPlotShape >> upperLimit [
	^ statisticalMeasures upperLimit.
]

{ #category : #accessing }
RSBoxPlotShape >> upperWhisker [
	^ upperWhisker
]

{ #category : #public }
RSBoxPlotShape >> whiskerFormat: aString [
	whisker format: aString.
]

{ #category : #accessing }
RSBoxPlotShape >> whiskers [
	^ whisker.
]

{ #category : #accessing }
RSBoxPlotShape >> xScale [
	^ xScale.
]

{ #category : #accessing }
RSBoxPlotShape >> xScale: aNSScale [
	xScale := aNSScale
]

{ #category : #accessing }
RSBoxPlotShape >> yScale [
	^ yScale.
]

{ #category : #accessing }
RSBoxPlotShape >> yScale: aNSScale [
	yScale := aNSScale
]
