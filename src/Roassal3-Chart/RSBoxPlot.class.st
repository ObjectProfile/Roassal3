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
		'boxShapes',
		'bandWidth',
		'offset'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #'instance creation' }
RSBoxPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlot [
	| boxPlot data |
	data := { 1. 2. 3. 4. 5. } .
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotChangeBoxWidth [
	| boxPlot1   data1  |
	data1 := { 12. 12. 13. 14. 15. 24. }.
	boxPlot1 := self data: data1.
	boxPlot1 bandsWidth: 50.
	^ boxPlot1 open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotChangeSpaceBetweenBoxes [
	| clusterChart boxPlot1  boxPlot2 data1 data2  |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	clusterChart := boxPlot1 + boxPlot2.
	
	"bandsMargin value between 0 and 1"
	clusterChart clustersMargin: 0.5.
	
	^ clusterChart open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotChangeSpaceBetweenClusters [
	| clusterChart boxPlot1  boxPlot2 data1 data2  |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	clusterChart := boxPlot1 + boxPlot2.
	
	"clustersMargin value between 0 and 1"
	clusterChart clustersMargin: 0.5.
	
	^ clusterChart open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotCustomColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotGroups [
	| boxPlot boxPlot1  boxPlot2 boxPlot3 data1 data2 data3 |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	data3 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot3 := self data: data3.
	boxPlot := boxPlot1 + boxPlot2 + boxPlot3.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotGroupsEven [
	| boxPlot boxPlot1  boxPlot2 data1 data2  |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot := boxPlot1 + boxPlot2.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotGroupsEven4 [
	| boxPlot boxPlot1  boxPlot2 boxPlot3 data1 data2 boxPlot4 |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot3 := self data: data2.
	boxPlot4 := self data: data2.
	boxPlot := boxPlot1 + boxPlot2 + boxPlot3 + boxPlot4.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotGroupsOdd [
	| boxPlot boxPlot1  boxPlot2 boxPlot3 data1 data2 data3 |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	data3 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot3 := self data: data3.
	boxPlot := boxPlot1 + boxPlot2 + boxPlot3.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotGroupsOdd5 [
	| boxPlot boxPlot1  boxPlot2 boxPlot3 boxPlot4 boxPlot5 data1 data2 data3 |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	data3 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot3 := self data: data3.
	boxPlot4 := self data: data3.
	boxPlot5 := self data: data3.
	boxPlot := boxPlot1 + boxPlot2 + boxPlot3 + boxPlot4 + boxPlot5.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotOfMultipleDatasets [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }.
			 { 1. 10. 10. 10. 10. 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleBoxFillColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot color: Color red translucent.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleBoxFillColorsCollection [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot colors: {Color red. Color green. Color blue.}.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleMedianLine [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot medianLines do: [:ml | 
		ml dashArray: {4.}.
		ml color: Color red.
	].
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleMedianLineColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot medianLines color: Color red.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleOneMedianLineColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot medianLines last color: Color red.
	(boxPlot medianLines at: 2) color: Color white.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleOutlierShape [
	| boxPlot1  data1  |
	data1 := { { 12. 12. 13. 14. 15. 24. } .
			 { 12. 12. 13. 14. 15. 24. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot1 outlierMarker: '+'.
	"boxPlot1 boxShapes first outlier: (RSShapeFactory circle size: 10; color: Color red)."
	"boxPlot1 outlier: (RSShapeFactory circle size: 10; color: Color red)."
	^ boxPlot1 open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleOutliersColor [
	| boxPlot boxPlot1  boxPlot2 data1 data2  |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot1 outliers color: Color red.
	boxPlot2 := self data: data2.
	boxPlot2 outliers color: Color purple.
	boxPlot := boxPlot1 + boxPlot2.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotStyleWhiskerFormat [
	| boxPlot boxPlot1  boxPlot2 data1 data2  |
	data1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	data2 := { { 1. 2. 2. 2. 3. 4. 3. 5. 12. } .
			 { 1. 12. 7. 10. 11. 11. 15. 10. }  .
			 { 12. 12. 13. 15. 18. 20. 21. 24. }  }.
	boxPlot1 := self data: data1.
	boxPlot2 := self data: data2.
	boxPlot1 whiskerFormat: '--'.
	boxPlot2 whiskers do: [ :whiskerLine | whiskerLine format: '.'].
	boxPlot := boxPlot1 + boxPlot2.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleDays [
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
	^ chart open.
]

{ #category : #examples }
RSBoxPlot class >> exampleDaysShowBands [
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
	p1 showBands.
	p2 := self data: y2. "sky blue"
	p2 showBands.
	p3 := self data: y3. "orange"
	p3 showBands.
	chart := p1 + p2 + p3.
	chart xTickLabels: { 'Day 1'. 'Day 2'. 'Day 3' }.
	^ chart open.
]

{ #category : #examples }
RSBoxPlot class >> exampleSetYTicksLabels [
	| p1 y1 |

	y1 := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.

	p1 := self data: y1. "blue"
	p1 xTickLabels: { 'Day 1'. 'Day 2'. }.
	^ p1 open.
]

{ #category : #rendering }
RSBoxPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : #rendering }
RSBoxPlot >> bandsWidth: aNumber [
	bandWidth := aNumber.
]

{ #category : #rendering }
RSBoxPlot >> beforeRenderingIn: aChart [
	| bandScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	bandScale := NSScale ordinal
		domain: xValues;
		rangeBands: { 0. aChart extent x. }.
	aChart xScale: bandScale.
]

{ #category : #rendering }
RSBoxPlot >> boxShapes [
	^ boxShapes.
]

{ #category : #rendering }
RSBoxPlot >> boxShapes: collectionOfRSBoxPlotShape [
	boxShapes := collectionOfRSBoxPlotShape.
]

{ #category : #rendering }
RSBoxPlot >> boxes [
	^ RSGroup new addAll: (boxShapes collect: [ :boxShape | boxShape box ]); yourself.
]

{ #category : #public }
RSBoxPlot >> buildChart [
	chart add: self.
	chart
		extent: 360 @ 300;
		padding: 15;
		build.
	^ chart
]

{ #category : #testing }
RSBoxPlot >> canHandleCluster [
	^ true
]

{ #category : #accessing }
RSBoxPlot >> color: aColor [
	boxShapes do: [ :boxShape | boxShape color: aColor ].
]

{ #category : #accessing }
RSBoxPlot >> colors: collectionOfColors [
	boxShapes doWithIndex: [ :boxShape :idx | boxShape color: (collectionOfColors at: idx) ].
]

{ #category : #rendering }
RSBoxPlot >> computeBandsOffset [
	boxShapes doWithIndex: [ :boxShape :idx |
		boxShape bandOffset: (xScale scale: (xValues at: idx)) + offset
	].
]

{ #category : #rendering }
RSBoxPlot >> computeBandsWidth [
	boxShapes do: [ :boxShape | boxShape bandWidth: bandWidth ].
]

{ #category : #accessing }
RSBoxPlot >> computeBoxGraphicsCenters [
	| lastBoxCenter |
	lastBoxCenter := 1.
	self boxShapes: (boxShapes collect: [ :boxGraph | 
		boxGraph graphCenter: lastBoxCenter "+groupOffset".
		"lastBoxCenter := lastBoxCenter + self defaultOffset".
		boxGraph.
	]).
]

{ #category : #rendering }
RSBoxPlot >> computeDefualtXTicks [
	chart horizontalTick ticks ifNil: [ self xTickLabels: (1 to: self numberOfBoxes) ].
]

{ #category : #private }
RSBoxPlot >> computeState [
	self computeXValues.
	self computeYValues.
	self computeDefualtXTicks.
]

{ #category : #rendering }
RSBoxPlot >> computeXValues [
	xValues := (1 to: self numberOfBoxes).
]

{ #category : #rendering }
RSBoxPlot >> computeYValues [
	| yMax yMin |
	yMax := (boxShapes collect: [ :boxShape | boxShape maxYValue ]) max.
	yMin := (boxShapes collect: [ :boxGraph | boxGraph minYValue ]) min.
	yValues := {yMin. yMax.}.
]

{ #category : #accessing }
RSBoxPlot >> createdShapes [
	^ { self boxShapes. }
]

{ #category : #rendering }
RSBoxPlot >> data: aCollection [
	| collectionOfDatasets |
	
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	self boxShapes: (collectionOfDatasets collect: [ :dataSet | RSBoxPlotShape data: dataSet.]).
	self computeBoxGraphicsCenters.
	self computeState.
]

{ #category : #accessing }
RSBoxPlot >> defaultBandsWidth [
	^ xScale scale: 1
]

{ #category : #accessing }
RSBoxPlot >> defaultOffset [
	^ xScale scale: 0
]

{ #category : #initialization }
RSBoxPlot >> defaultShape [
	^ RSPolygon new noPaint.
]

{ #category : #initialization }
RSBoxPlot >> initialize [
	super initialize.
	chart := RSChart new.
]

{ #category : #testing }
RSBoxPlot >> isBoxPlot [
	^ true
]

{ #category : #rendering }
RSBoxPlot >> medianLines [
	^ RSGroup new addAll: (boxShapes collect: [ :box | box medianLine ]); yourself.
]

{ #category : #rendering }
RSBoxPlot >> numberOfBands [
	^ self numberOfBoxes
]

{ #category : #rendering }
RSBoxPlot >> numberOfBoxes [
	^ self boxShapes size.
]

{ #category : #public }
RSBoxPlot >> open [
	^ self buildChart open.
]

{ #category : #rendering }
RSBoxPlot >> outlier: markerShape [
	boxShapes do: [ :box | box outlier: markerShape ].
]

{ #category : #rendering }
RSBoxPlot >> outlierMarker: markerShapeString [
	boxShapes do: [ :box | box outlierMarker: markerShapeString ].
]

{ #category : #rendering }
RSBoxPlot >> outliers [
	^ RSGroup new addAll: (boxShapes collect: [ :box | box outliers ]); yourself.
]

{ #category : #rendering }
RSBoxPlot >> renderIn: canvas [
	
	offset ifNil: [ offset := 0 ].
	self computeBandsOffset.
	
	bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
	self computeBandsWidth.
	
	boxShapes doWithIndex: [ :aRSBoxPlotShape :idx |
		aRSBoxPlotShape color ifNil: [ aRSBoxPlotShape color: self computeColor. ].
		aRSBoxPlotShape scales: {
				self xScale.
				self yScale }.
		aRSBoxPlotShape renderIn: canvas ]
]

{ #category : #rendering }
RSBoxPlot >> showBands [
	boxShapes do: [ :box | box showBand ]
]

{ #category : #rendering }
RSBoxPlot >> whiskerFormat: aString [
	boxShapes do: [ :box | box whiskerFormat: aString ]
]

{ #category : #rendering }
RSBoxPlot >> whiskers [
	^ RSGroup new addAll: (boxShapes collect: [ :box | box whiskers ]); yourself.
]

{ #category : #accessing }
RSBoxPlot >> y: aCollection [
	self data: aCollection.
]
