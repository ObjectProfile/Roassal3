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
		bottomWhiskerExtent < minVal 
			ifTrue: [ bottomWhiskerExtent := minVal. bottomOutliers := Array new ]
			ifFalse: [ bottomOutliers := i select: [ :j | j < bottomWhiskerExtent  ] ].
		
		topWhiskerExtent := quartile3 + (iqr * 1.5).
		topWhiskerExtent > maxVal 
			ifTrue: [ topWhiskerExtent := maxVal. topOutliers := Array new ]
			ifFalse: [ topOutliers := i select: [ :j | j > topWhiskerExtent  ] ].
			
		{ bottomOutliers . bottomWhiskerExtent . quartile1. i median. quartile3. topWhiskerExtent . topOutliers  }
	].

]

{ #category : #hooks }
RSBoxPlot >> computeRectagleAndLinesFor: index [
   "Convert the box and whisker extents to their positions in the plot using the scale"
	| box boxAndWhis origin corner sizeOffset offset zero aPoint topLeft bottomLeft bottomRight bottomCenter topCenter bottomWhiskerExtent topWhiskerExtent |
	
	boxAndWhis := boxAndWhisker at: index.
	aPoint := (xValues at: index) @ (boxAndWhis at: 5).
	zero := boxAndWhis at: 3.
	"origin is the top left of the rectangle"
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y + zero).
	corner := origin x @ (yScale scale: zero ).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	
	topLeft := origin + offset - sizeOffset.
	bottomLeft := topLeft x @ (yScale scale: zero ).
	
	bottomRight := bottomLeft + offset + sizeOffset.
	bottomCenter := (bottomRight x + origin x / 2) @ bottomRight y.
	topCenter := bottomCenter x @ (topLeft y).
	
	bottomWhiskerExtent := bottomCenter x @ (yScale scale: (boxAndWhis at: 2)).
	topWhiskerExtent := topCenter x @ (yScale scale: (boxAndWhis at: 6)).
	
	box := self shape copy
		model: (self modelFor: aPoint);
		color: self computeColor;
		fromRectangle: (Rectangle origin: topLeft corner: bottomRight );
		yourself.
	
	^{RSLine new startPoint: bottomCenter; endPoint: bottomWhiskerExtent . box. RSLine new startPoint: topCenter; endPoint: topWhiskerExtent}.
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
