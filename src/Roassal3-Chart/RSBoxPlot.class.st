"
I am a box and whisker plot used for comparing the distributions of datasets.

I require a 2D collection where the first dimension are the individual box-and-whisker and the inner 
collection are the data points. 

```
| c p y |

""With PolyMath loaded SortedCollection responds to the quantile: message""
y := { { 1. 2. 3. 4. 5. } . 
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }. 
c := RSChart new.
p := RSBoxPlot new y: y.
	
c addPlot: p.
	
c addDecoration: (RSHorizontalTick new 
		numberOfTicks: y size).
c xlabel: 'X Axis'.
c addDecoration: (RSVerticalTick new 
		numberOfTicks: 10;
		asFloat).
c ylabel: 'Y Axis'.
c title: 'Box Plot'.
c openOnce.
```
"
Class {
	#name : #RSBoxPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'barSize',
		'bars',
		'gapRatio',
		'barOffset',
		'boxAndWhisker',
		'statisticalMeasures',
		'boxWidth',
		'boxesPoints',
		'medianLinesPoints',
		'centerLinesPoints',
		'outlierPoints',
		'boxes',
		'outliers',
		'medianLines',
		'centerLines'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #accessing }
RSBoxPlot >> barOffset [
	^ barOffset
]

{ #category : #accessing }
RSBoxPlot >> barOffset: aNumber [
	barOffset := aNumber
]

{ #category : #accessing }
RSBoxPlot >> barScale [
	^ xScale
]

{ #category : #accessing }
RSBoxPlot >> barSize [
	"Return the width of each bar"
	^ barSize ifNil: [ self barScale rangeBand ]
]

{ #category : #accessing }
RSBoxPlot >> barSize: aBarWidth [
	"Set the width of the bar"
	barSize := aBarWidth
]

{ #category : #accessing }
RSBoxPlot >> bars [
	^ bars
]

{ #category : #accessing }
RSBoxPlot >> boxes [
	^ boxes
]

{ #category : #accessing }
RSBoxPlot >> boxesPoints [
	^ boxesPoints
]

{ #category : #public }
RSBoxPlot >> buildChart [
	chart := RSChart new.
	chart add: self.
	chart
		extent: 250 @ 200.
	^ chart
]

{ #category : #accessing }
RSBoxPlot >> centerLines [
	^ centerLines.
]

{ #category : #accessing }
RSBoxPlot >> centerLinesPoints [
	^ centerLinesPoints
]

{ #category : #private }
RSBoxPlot >> computeBoxAndWhiskerExtent: aCollection [
	"Converts a 2D collection of data points into the poisition of the 1 and 3 quartile, the whiskers, and outlieing points.

	Returns an array with the following:
	1. An array of the lower outlying data
	2. The y value of the bottom whisker
	3. The y value of the bottom of the box
	4. The y value of the median
	5. The y value of the top of the box
	6. The y value of the top whisker
	7. An array of the upper outlying data
	"
	boxAndWhisker := aCollection collect: [ :i |
		|iSort quartile1 quartile3 minVal maxVal bottomWhiskerExtent topWhiskerExtent iqr bottomOutliers topOutliers |

		iSort := i asSortedCollection .

		minVal := iSort min.
		maxVal := iSort max.
		quartile1 := self quantile: 0.25 for: iSort.
		quartile3 := self quantile: 0.75 for: iSort.
		iqr := quartile3 - quartile1 .

		bottomWhiskerExtent := quartile1 - (iqr * 1.5).
		bottomWhiskerExtent <= minVal
			ifTrue: [ bottomWhiskerExtent := minVal. bottomOutliers := Array new ]
			ifFalse: [ bottomOutliers := i select: [ :j | j < bottomWhiskerExtent  ] ].

		topWhiskerExtent := quartile3 + (iqr * 1.5).
		topWhiskerExtent >= maxVal
			ifTrue: [ topWhiskerExtent := maxVal. topOutliers := Array new ]
			ifFalse: [ topOutliers := i select: [ :j | j > topWhiskerExtent  ] ].

		{ bottomOutliers . bottomWhiskerExtent . quartile1. iSort median. quartile3. topWhiskerExtent . topOutliers  }
	]
]

{ #category : #accessing }
RSBoxPlot >> computeBoxPoints: aRSStatisticalMeasures [
	| q025 q075 quartiles boxPoints |
	quartiles := aRSStatisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	boxWidth := 1 * 0.10.
	boxPoints := {(0-(boxWidth/2))@q025. (boxWidth/2)@q025. (boxWidth/2)@q075. (0-(boxWidth/2))@q075}.
	^ boxPoints.
]

{ #category : #accessing }
RSBoxPlot >> computeBoxPoints: aRSStatisticalMeasures boxIndex: aNumber [
	| q025 q075 quartiles boxPoints |
	quartiles := aRSStatisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	boxWidth := 7 * 0.10.
	boxPoints := {(aNumber-(boxWidth/2))@q025. (aNumber+(boxWidth/2))@q025. (aNumber+(boxWidth/2))@q075. (aNumber-(boxWidth/2))@q075}.
	^ boxPoints.
]

{ #category : #accessing }
RSBoxPlot >> computeBoxesPoints [
	boxesPoints := statisticalMeasures collectWithIndex: [ :sm :idx | self computeBoxPoints: sm boxIndex: idx ].
	^ boxesPoints.
]

{ #category : #accessing }
RSBoxPlot >> computeCenterLinePoints: aRSStatisticalMeasures boxIndex: aNumber [
	| upperLimit lowerLimit centerLinePoints |
	upperLimit := self upperLimits at: aNumber.
	lowerLimit := self lowerLimits at: aNumber.
	centerLinePoints := { aNumber@upperLimit. aNumber@lowerLimit. }.
	^ centerLinePoints.
]

{ #category : #accessing }
RSBoxPlot >> computeCenterLinesPoints [
	centerLinesPoints := statisticalMeasures collectWithIndex: [ :sm :idx | self computeCenterLinePoints: sm boxIndex: idx ].
	^ centerLinesPoints.
]

{ #category : #accessing }
RSBoxPlot >> computeMedianLinePoints: aRSStatisticalMeasures boxIndex: aNumber [
	| q050 medianLinePoints |
	q050 := aRSStatisticalMeasures quartiles second.
	medianLinePoints := { (aNumber-(boxWidth/2))@q050. (aNumber+(boxWidth/2))@q050. }.
	^ medianLinePoints.
]

{ #category : #accessing }
RSBoxPlot >> computeMedianLinesPoints [
	medianLinesPoints := statisticalMeasures collectWithIndex: [ :sm :idx | 
		self computeMedianLinePoints: sm boxIndex:  idx ].
	^ medianLinesPoints .
]

{ #category : #rendering }
RSBoxPlot >> computeOutliersFor: points at: xValue [

	"Translates a collection of points to the plot coordinates and returns a collection of RSEllipse"
	"xValue has already been converted into the xscale but points are still in the original data scale"

	^points collect: [ :i |
		| newPoint |
		newPoint := xValue @ (yScale scale: i).
		RSEllipse new
				radius: 2;
				color: self computeColor;
				translateTo: newPoint .
	]
]

{ #category : #rendering }
RSBoxPlot >> computeRectagleAndLinesFor: index [
   "Convert the box and whisker extents to their positions in the plot using the scale"
	| lowerOutliers upperOutliers boxAndWhis origin sizeOffset offset zero aPoint topLeft bottomRight bottomWhiskerExtent topWhiskerExtent corner center |

	boxAndWhis := boxAndWhisker at: index.
	aPoint := (xValues at: index) @ (boxAndWhis at: 5).
	zero := boxAndWhis at: 3.
	"origin is the top left of the rectangle"
	origin := self scalePoint: aPoint.
	corner := origin x @ (yScale scale: zero ).

	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.

	topLeft := origin + offset - sizeOffset.

	bottomRight := corner + offset + sizeOffset.

	center := (topLeft x + bottomRight x) / 2.

	"These are a collection of RSEllipse for the outlying points of the dataset"
	lowerOutliers := self computeOutliersFor: (boxAndWhis at: 1) at: center.
	upperOutliers := self computeOutliersFor: (boxAndWhis at: 7) at: center.

	bottomWhiskerExtent := center @ (yScale scale: (boxAndWhis at: 2)).
	topWhiskerExtent := center @ (yScale scale: (boxAndWhis at: 6)).


	^{ 	self shape copy
		model: (self modelFor: aPoint);
		color: self computeColor;
		fromRectangle: (Rectangle origin: topLeft corner: bottomRight );
		yourself.
		RSLine new
			startPoint: (topLeft x  @ (yScale scale: (boxAndWhis at: 4)));
			endPoint: (bottomRight x @(yScale scale: (boxAndWhis at: 4))).
		RSLine new
			startPoint: center @ corner y;
			endPoint: bottomWhiskerExtent .
		RSLine new
			startPoint: center @ origin y;
			endPoint: topWhiskerExtent},
		lowerOutliers,
		upperOutliers
]

{ #category : #accessing }
RSBoxPlot >> computeState [
	self computeBoxesPoints.
	self computeMedianLinesPoints.
	self computeCenterLinesPoints.
	self computeXValues.
	self computeYValues.
]

{ #category : #rendering }
RSBoxPlot >> computeXValues [
	| numberOfBoxes |
	numberOfBoxes := statisticalMeasures size.
	xValues := {0. numberOfBoxes + 1. }.
]

{ #category : #rendering }
RSBoxPlot >> computeYValues [
	| yMax yMin maxUpperLimit minLowerLimit diff margin |
	"outliers := statisticalMeasures outliers.
	maxOutlier := 0.
	minOutlier := 0.
	(outliers isNotEmpty) ifTrue: [ 
		maxOutlier := outliers max.
		minOutlier := outliers min.
	]."
	maxUpperLimit := (statisticalMeasures collect: [ :sm | sm upperLimit ]) max.
	minLowerLimit := (statisticalMeasures collect: [ :sm | sm lowerLimit ]) min.
	yMax := maxUpperLimit." max: maxOutlier."
	yMin := minLowerLimit." min: minOutlier."
	diff := yMax - yMin.
	margin := 0.1*diff.
	yValues := {yMin. yMax.}.
]

{ #category : #public }
RSBoxPlot >> createBox: boxPoints [
	| box |
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: Color white.
	box borderColor: Color black.
	^ box
]

{ #category : #public }
RSBoxPlot >> createBoxes [
	boxes := boxesPoints collect: [ :boxPoints | self createBox: boxPoints ].
	^ boxes.
]

{ #category : #public }
RSBoxPlot >> createCenterLine: centerLinePoints [
	| centerLine |
	centerLine :=  RSPolyline new.
	centerLine controlPoints: (centerLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	centerLine width: 2.
	centerLine color: Color black.
	^ centerLine.
]

{ #category : #public }
RSBoxPlot >> createCenterLines [
	centerLines := centerLinesPoints collect: [ :centerLinePoints | self createCenterLine: centerLinePoints ].
	^ centerLines.
]

{ #category : #public }
RSBoxPlot >> createMedianLine: medianLinePoints [
	| medianLine |
	medianLine := RSPolyline new.
	medianLine := medianLine controlPoints: (medianLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	medianLine width: 2.
	medianLine color: Color black.
	^ medianLine.
]

{ #category : #public }
RSBoxPlot >> createMedianLines [
	medianLines := medianLinesPoints collect: [ :medianLinePoints | self createMedianLine: medianLinePoints ].
	^ medianLines.
]

{ #category : #accessing }
RSBoxPlot >> createdShapes [
	^ { boxes. }
]

{ #category : #rendering }
RSBoxPlot >> data [
	| collectionOfDatasets |
	(statisticalMeasures size = 1) ifTrue: [ ^statisticalMeasures first data ].
	collectionOfDatasets := statisticalMeasures collect: [
		                        :aRSStatiscalMeasures |
		                        aRSStatiscalMeasures data ].
	^ collectionOfDatasets
]

{ #category : #rendering }
RSBoxPlot >> data: aCollection [

	| statisticalMeasuresArray collectionOfDatasets |
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	statisticalMeasuresArray := collectionOfDatasets collect: [ :dataSet |
		                            RSStatisticalMeasures data: dataSet ].
	self statisticalMeasures: statisticalMeasuresArray.
	self computeState.
]

{ #category : #initialization }
RSBoxPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #accessing }
RSBoxPlot >> gapRatio [
	^ gapRatio
]

{ #category : #accessing }
RSBoxPlot >> gapRatio: aNumber [
	"aNumber between 0 and 1"
	gapRatio := aNumber
]

{ #category : #initialization }
RSBoxPlot >> initialize [
	super initialize.
	self
		gapRatio: 0.1;
		barOffset: 0
]

{ #category : #testing }
RSBoxPlot >> isBoxPlot [
	^ true
]

{ #category : #accessing }
RSBoxPlot >> lowerLimits [
	^ statisticalMeasures collect: [ :sm | sm lowerLimit ].
]

{ #category : #private }
RSBoxPlot >> medianLines [
	^ medianLines.
]

{ #category : #public }
RSBoxPlot >> medianLinesPoints [
	^ medianLinesPoints.
]

{ #category : #accessing }
RSBoxPlot >> medians [
	^ statisticalMeasures collect: [ :sm | sm median ].
]

{ #category : #'math functions' }
RSBoxPlot >> modeBased [
	"Initialize the quantile calculation with this input"
	^ Array with: 1 with: -1 with: 0 with: 1
]

{ #category : #hooks }
RSBoxPlot >> modelFor: aPoint [
	^ aPoint y
]

{ #category : #public }
RSBoxPlot >> open [
	^ self buildChart open.
]

{ #category : #'math functions' }
RSBoxPlot >> quantile: aProbability for: aSortedCollection [
	"returns the expected quantile only, if I use my standard initialization method"

	^ self quantile: aProbability for: aSortedCollection withProbs: self modeBased
]

{ #category : #'math functions' }
RSBoxPlot >> quantile: aProbability for: aSortedCollection withProbs: anArray [
	| a b c d p f |
	a := anArray at: 1.
	b := anArray at: 2.
	c := anArray at: 3.
	d := anArray at: 4.
	p := (aSortedCollection size + b) * aProbability + a.
	p := p < 1
		ifTrue: [ 1 ]
		ifFalse: [ p min: aSortedCollection size ].
	^ p truncated = p
		ifTrue: [ aSortedCollection at: p asInteger ]
		ifFalse: [ (f := aSortedCollection at: p floor)
				+ (((aSortedCollection at: p ceiling) - f) * (p fractionPart * d + c)) ]
]

{ #category : #rendering }
RSBoxPlot >> renderIn: canvas [
	self createCenterLines.
	canvas addAll: centerLines.
	self createBoxes.
	canvas addAll: boxes.
	self createMedianLines.
	canvas addAll: medianLines.
	"| index |
	self checkAssertion.
	index := 1.
	bars := xValues flatCollect: [ :xt |
		| bar |
		bar := self computeRectagleAndLinesFor: index.
		index := index + 1.
		bar ] as: RSGroup.
	canvas addAll: bars"
]

{ #category : #accessing }
RSBoxPlot >> statisticalMeasures [
	(statisticalMeasures size = 1) ifTrue: [ ^ statisticalMeasures first ].
	^ statisticalMeasures.
]

{ #category : #accessing }
RSBoxPlot >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures
]

{ #category : #accessing }
RSBoxPlot >> upperLimits [
	^ statisticalMeasures collect: [ :sm | sm upperLimit ].
]

{ #category : #public }
RSBoxPlot >> x: aCollection y: aCollection2 [
	xValues := aCollection.
	yValues := aCollection2.
	self computeBoxAndWhiskerExtent: aCollection2
]

{ #category : #accessing }
RSBoxPlot >> y: aCollection [
	self data: aCollection.
]
