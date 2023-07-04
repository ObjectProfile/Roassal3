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
		'groups',
		'collorPallete'
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
	data := { 12. 12. 13. 14. 15. 24. }.
	boxPlot := self data: data.
	^ boxPlot open.
]

{ #category : #examples }
RSBoxPlot class >> exampleBoxPlotCustomColor [
	| boxPlot data |
	data := { { 1. 2. 3. 4. 5. } .
			 { 5. 6. 7. 5. 10. }  .
			 { 12. 12. 13. 14. 15. 24. }  }.
	boxPlot := self data: data.
	boxPlot shape color: (Color r: 158 g: 202 b: 226  range: 255 ).
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
RSBoxPlot class >> exampleDays [
	| p p1 p2 p3 y1 y2 y3 |

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
	p := p1 + p2 + p3.
	p xTickLabels: { 'G1'. 'G2'. 'G3' }.
	^ p open.
]

{ #category : #accessing }
RSBoxPlot >> + aRSBoxPlot [
	| groupsA groupsB offset maxCenterOfGroups |
	groupsA := self groups.
	groupsB := aRSBoxPlot groups.
	maxCenterOfGroups := (groupsA collect: [:group|group maxCenter]) max.
	offset := maxCenterOfGroups + 3.
	"groupsB := groupsB collect: [ :aRSBoxGraphGroup | aRSBoxGraphGroup addOffsetToGroup: offset ]."
	groupsA addAll: groupsB.
	groups := groupsA.
	self computeGroupsOffsets.
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
		extent: 360 @ 300.
	^ chart
]

{ #category : #accessing }
RSBoxPlot >> color: aColor [
	groups do: [ :group | group color: aColor ].
]

{ #category : #accessing }
RSBoxPlot >> colorFor: aNumber [
	^ collorPallete scale: aNumber.
]

{ #category : #accessing }
RSBoxPlot >> colors: collectionOfColors [
	groups do:  [ :group | group colors: collectionOfColors ].
]

{ #category : #rendering }
RSBoxPlot >> computeBoxesWidths [
	| numberOfGroups boxWidth defaultBoxWidth |
	defaultBoxWidth := 0.5.
	numberOfGroups := self numberOfGroups.
	boxWidth := defaultBoxWidth / numberOfGroups.
	groups do: [ :boxGroup | boxGroup boxesWidth: boxWidth ].
]

{ #category : #rendering }
RSBoxPlot >> computeColor [
	groups doWithIndex: [ :group :index |
		group color: (self colorFor: index ).
	].
]

{ #category : #rendering }
RSBoxPlot >> computeGroupsOffsets [
	| numberOfGroups defaultBoxGroupSpace groupBoxSpace offsets |
	defaultBoxGroupSpace := 0.66.
	numberOfGroups := self numberOfGroups.
	groupBoxSpace := defaultBoxGroupSpace / numberOfGroups.
	
	offsets := OrderedCollection new.
	numberOfGroups odd ifTrue: [ 
		| indexOfTheMiddle currentIndex counter |
		indexOfTheMiddle := (numberOfGroups / 2) ceiling. 
		currentIndex := 1.
		counter := 1.
		[currentIndex < indexOfTheMiddle] whileTrue: [ 
			offsets addFirst: (0-(groupBoxSpace * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
		currentIndex := indexOfTheMiddle.
		counter := 0.
		[currentIndex <= numberOfGroups] whileTrue: [ 
			offsets add: (groupBoxSpace * counter).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
				
		"{ 0-groupBoxSpace. 0. 0+groupBoxSpace. } "
	].
	numberOfGroups even ifTrue: [ 
		| indexOfTheMiddle currentIndex counter |
		indexOfTheMiddle := (numberOfGroups / 2). 
		currentIndex := 1.
		counter := 0.
		[currentIndex <= indexOfTheMiddle] whileTrue: [ 
			offsets addFirst: (0-(groupBoxSpace/2)-(groupBoxSpace * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
		currentIndex := indexOfTheMiddle.
		counter := 0.
		[currentIndex < numberOfGroups] whileTrue: [ 
			offsets add: ((groupBoxSpace/2) + (groupBoxSpace * counter)).
			counter := counter + 1.
			currentIndex := currentIndex + 1.
		].
				
		"{ 0-groupBoxSpace. 0. 0+groupBoxSpace. } "
	].
	"numberOfGroups even ifTrue: [ 
		{ 0-groupBoxSpace-groupBoxSpace/2. 
		0+groupBoxSpace/2.
		0+groupBoxSpace/2. 
		0+groupBoxSpace+groupBoxSpace/2. } ].
	"
	groups doWithIndex: [ :boxGroup :idx | 
		boxGroup groupOffset: (offsets at: idx)
	].
]

{ #category : #accessing }
RSBoxPlot >> computeState [
	self computeColor.
	self computeBoxesWidths.
	self computeXValues.
	self computeYValues.
]

{ #category : #rendering }
RSBoxPlot >> computeXValues [
	| maxXValue boxesMaxXValues |
	boxesMaxXValues := groups collect: [ :boxGraphGroup | boxGraphGroup maxXValue ].
	maxXValue := boxesMaxXValues max.
	xValues := {0.5. maxXValue. }.
]

{ #category : #rendering }
RSBoxPlot >> computeYValues [
	| yMax yMin |
	yMax := (groups collect: [ :boxGraphGroup | boxGraphGroup maxYValue ]) max.
	yMin := (groups collect: [ :boxGraphGroup | boxGraphGroup minYValue ]) min.
	yValues := {yMin. yMax.}.
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
RSBoxPlot >> defaultPlotColors [
	^ NSScale category20
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
	collorPallete := self defaultPlotColors.
]

{ #category : #testing }
RSBoxPlot >> isBoxPlot [
	^ true
]

{ #category : #rendering }
RSBoxPlot >> numberOfBoxes [
	^ self boxGraphics size.
]

{ #category : #rendering }
RSBoxPlot >> numberOfGroups [
	^ groups size.
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
	].
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
