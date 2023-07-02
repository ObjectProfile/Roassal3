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
		'boxAndWhisker',
		'groups'
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
RSBoxPlot class >> exampleBoxPlot [
	| boxPlot data |
	data := { 12. 12. 13. 14. 15. 24. }.
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #accessing }
RSBoxPlot class >> exampleBoxPlotCustomColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot shape color: (Color r: 158 g: 202 b: 226  range: 255 ).
	^ boxPlot open.
]

{ #category : #accessing }
RSBoxPlot class >> exampleBoxPlotOfMultipleDatasets [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }.
			 { 1. 10. 10. 10. 10. 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #accessing }
RSBoxPlot >> + aRSBoxPlot [
	| groupsA groupsB offset maxCenterOfGroups |
	groupsA := self groups.
	groupsB := aRSBoxPlot groups.
	maxCenterOfGroups := (groupsA collect: [:group|group maxCenter]) max.
	offset := maxCenterOfGroups + 6.
	groupsB := groupsB collect: [ :aRSBoxGraphGroup | aRSBoxGraphGroup addOffsetToGroup: offset ].
	groupsA addAll: groupsB.
	groups := groupsA.
	self computeState.
	^ self.
]

{ #category : #rendering }
RSBoxPlot >> boxGraphics [
	| boxGraphics |
	boxGraphics := OrderedCollection new.
	groups do: [:boxGraphGroup | boxGraphics addAll: (boxGraphGroup boxGraphics) ].
	^ boxGraphics.
]

{ #category : #public }
RSBoxPlot >> buildChart [
	chart := RSChart new.
	chart add: self.
	chart
		extent: 250 @ 200.
	^ chart
]

{ #category : #rendering }
RSBoxPlot >> computeColor: plotIdx [
	^ self color ifNil: [ chart colorFor: plotIdx ]
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
	self computeXValues.
	self computeYValues.
]

{ #category : #rendering }
RSBoxPlot >> computeXValues [
	| maxXValue boxesMaxXValues |
	boxesMaxXValues := groups collect: [ :boxGraphGroup | boxGraphGroup maxXValue ].
	maxXValue := boxesMaxXValues max.
	xValues := {0. maxXValue. }.
]

{ #category : #rendering }
RSBoxPlot >> computeYValues [
	| yMax yMin |
	yMax := (groups collect: [ :boxGraphGroup | boxGraphGroup maxYValue ]) max.
	yMin := (groups collect: [ :boxGraphGroup | boxGraphGroup minYValue ]) min.
	yValues := {yMin. yMax.}.
]

{ #category : #public }
RSBoxPlot >> createBox: boxPoints withColor: colorIndex [
	| box boxIndex |
	boxIndex := boxPoints first x.
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: (self computeColor: colorIndex).
	box borderColor: Color black.
	box borderWidth: 1.
	^ box
]

{ #category : #accessing }
RSBoxPlot >> createdShapes [
	^ { self boxGraphics. }
]

{ #category : #rendering }
RSBoxPlot >> data: aCollection [
	| groupsCollection |
	groupsCollection := OrderedCollection new.
	groupsCollection add: ( RSBoxGraphGroup data: aCollection).
	self groups: groupsCollection.
	self computeState.
]

{ #category : #initialization }
RSBoxPlot >> defaultShape [
	^ RSPolygon new noPaint.
]

{ #category : #accessing }
RSBoxPlot >> groups [
	^ groups.
]

{ #category : #accessing }
RSBoxPlot >> groups: aCollectionOfRSBoxGraphs [
	groups := aCollectionOfRSBoxGraphs.
]

{ #category : #initialization }
RSBoxPlot >> initialize [
	super initialize.
]

{ #category : #testing }
RSBoxPlot >> isBoxPlot [
	^ true
]

{ #category : #rendering }
RSBoxPlot >> numberOfBoxes [
	^ self boxGraphics size.
]

{ #category : #public }
RSBoxPlot >> open [
	^ self buildChart open.
]

{ #category : #rendering }
RSBoxPlot >> renderIn: canvas [
	groups do: [ :aRSBoxGraphGroup |
		aRSBoxGraphGroup scales: {xScale. yScale.}. 
		aRSBoxGraphGroup renderIn: canvas 
	]
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
