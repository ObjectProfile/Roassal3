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
		'boxAndWhisker'
	],
	#category : #'Roassal3-Chart-Core'
}

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
	^ xScale.
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

{ #category : #rendering }
RSBoxPlot >> beforeRenderingIn: aChart [
	| barScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	barScale := NSOrdinalScale new 
		domain: xValues;
		rangeBands: xScale range padding: gapRatio.
	aChart xScale: barScale
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
	].

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
	].
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
		upperOutliers.
]

{ #category : #initialization }
RSBoxPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #rendering }
RSBoxPlot >> definedValuesY [
	"Return the list Y values that are defined"
	| res |
	res := yValues flatCollect: [ :i | i]. 
	^ res, {0}
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
		barOffset: 0.
]

{ #category : #testing }
RSBoxPlot >> isBoxPlot [
	^ true
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

{ #category : #'math functions' }
RSBoxPlot >> quantile: aProbability for: aSortedCollection [
	"returns the expected quantile only, if I use my standard initialization method"

	^ self quantile: aProbability for: aSortedCollection withProbs: self modeBased.
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
	| index |
	self checkAssertion.
	index := 1.
	bars := xValues flatCollect: [ :xt | 
		| bar |
		bar := self computeRectagleAndLinesFor: index.
		index := index + 1.
		bar ] as: RSGroup.
	canvas addAll: bars.


]

{ #category : #public }
RSBoxPlot >> x: aCollection y: aCollection2 [
	xValues := aCollection.
	yValues := aCollection2.
	self computeBoxAndWhiskerExtent: aCollection2.
]
