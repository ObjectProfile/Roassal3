"
I am a box and whisker plot. 

I am responsible for calculating the extent of the box and whisker parts of the plot, and determining the outliers.

```
| c p y |
""The inner collections must respond to quantile: which is added to added to SortedCollection by PolyMath""
y := { { 1. 2. 3. 4. 5. } asSortedCollection. 
		 { 5. 6. 7. 5. 10. } asSortedCollection .
		 { 12. 12. 13. 14. 15. 24. } asSortedCollection }. 
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

My input must be a 2D collection; the first dimension will be an individual box and whisker and the second 
dimension is a collection of points. This inner collection must respond to a `quantile:` message, which 
is used to calculate the first and third quartiles. Currently this method can be loaded onto `SortedCollection`
as part of the `Math-Quantile` package that is part of PolyMath.
"
Class {
	#name : #RSBoxPlot,
	#superclass : #RSAbstractBoxPlot,
	#instVars : [
		'boxAndWhisker'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSBoxPlot >> barScale [
	^ xScale.
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
		|quartile1 quartile3 minVal maxVal bottomWhiskerExtent topWhiskerExtent iqr bottomOutliers topOutliers |
		minVal := i min.
		maxVal := i max.
		quartile1 := i quantile: 0.25.
		quartile3 := i quantile: 0.75.
		iqr := quartile3 - quartile1 .
		
		bottomWhiskerExtent := quartile1 - (iqr * 1.5).
		bottomWhiskerExtent <= minVal 
			ifTrue: [ bottomWhiskerExtent := minVal. bottomOutliers := Array new ]
			ifFalse: [ bottomOutliers := i select: [ :j | j < bottomWhiskerExtent  ] ].
		
		topWhiskerExtent := quartile3 + (iqr * 1.5).
		topWhiskerExtent >= maxVal 
			ifTrue: [ topWhiskerExtent := maxVal. topOutliers := Array new ]
			ifFalse: [ topOutliers := i select: [ :j | j > topWhiskerExtent  ] ].
			
		{ bottomOutliers . bottomWhiskerExtent . quartile1. i median. quartile3. topWhiskerExtent . topOutliers  }
	].

]

{ #category : #rendering }
RSBoxPlot >> computeOutliersFor: points at: xValue [
	
	^points collect: [ :i |
		| newPoint |
		newPoint := (xScale scale: xValue) @ (yScale scale: i).
		RSEllipse new
				radius: 2;
				color: self computeColor;
				translateTo: newPoint .
	].
]

{ #category : #rendering }
RSBoxPlot >> computeRectagleAndLinesFor: index [ 
   "Convert the box and whisker extents to their positions in the plot using the scale"
	| lowerOutliers upperOutliers box boxAndWhis origin sizeOffset offset zero aPoint topLeft bottomLeft bottomRight bottomWhiskerExtent topWhiskerExtent corner center |
	
	boxAndWhis := boxAndWhisker at: index.
	aPoint := (xValues at: index) @ (boxAndWhis at: 5).
	zero := boxAndWhis at: 3.
	"origin is the top left of the rectangle"
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y).
	corner := origin x @ (yScale scale: zero ).
	
	
	lowerOutliers := self computeOutliersFor: (boxAndWhis at: 1) at: (xValues at: index)	.
	upperOutliers := self computeOutliersFor: (boxAndWhis at: 7) at: (xValues at: index). 
	
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	
	topLeft := origin + offset - sizeOffset.
	bottomLeft := topLeft x @ (yScale scale: zero ).
	
	bottomRight := corner + offset + sizeOffset.
	
	center := (topLeft x + bottomRight x) / 2.
	
	bottomWhiskerExtent := center @ (yScale scale: (boxAndWhis at: 2)).
	topWhiskerExtent := center @ (yScale scale: (boxAndWhis at: 6)).
	
	box := self shape copy
		model: (self modelFor: aPoint);
		color: self computeColor;
		fromRectangle: (Rectangle origin: topLeft corner: bottomRight );
		yourself.
	
	^{RSLine new startPoint: center @ corner y; endPoint: bottomWhiskerExtent . box. RSLine new startPoint: center @ origin y; endPoint: topWhiskerExtent}, lowerOutliers, upperOutliers.
]

{ #category : #rendering }
RSBoxPlot >> definedValuesY [
	"Return the list Y values that are defined"
	| res |
	res := yValues flatCollect: [ :i | i]. 
	^ res, {0}
]

{ #category : #hooks }
RSBoxPlot >> modelFor: aPoint [
	^ aPoint y
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
