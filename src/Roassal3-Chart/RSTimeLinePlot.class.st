"
Define a time line, a bit like a Gantt diagram.
"
Class {
	#name : #RSTimeLinePlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'gapRatio',
		'bars',
		'barSize'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSTimeLinePlot >> barScale [
	^ yScale
]

{ #category : #accessing }
RSTimeLinePlot >> barSize [
	"Return the width of each bar"
	^ barSize ifNil: [ self barScale rangeBand ]
]

{ #category : #accessing }
RSTimeLinePlot >> barSize: aBarWidth [
	"Set the width of the bar"
	barSize := aBarWidth
]

{ #category : #accessing }
RSTimeLinePlot >> bars [ 
	^ bars
]

{ #category : #rendering }
RSTimeLinePlot >> beforeRenderingIn: aChart [
	| barScale |
	super beforeRenderingIn: aChart.
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	
	barScale := NSOrdinalScale new 
		domain: (aChart minValueY to: aChart maxValueY);
		rangeBands: yScale range padding: gapRatio.
	aChart yScale: barScale
]

{ #category : #initialization }
RSTimeLinePlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #accessing }
RSTimeLinePlot >> entries: aCollection at: aNumber [
	self 
		x: aCollection
		y: (Array new: aCollection size withAll: aNumber).
]

{ #category : #accessing }
RSTimeLinePlot >> gapRatio [
	^ gapRatio
]

{ #category : #accessing }
RSTimeLinePlot >> gapRatio: anObject [
	gapRatio := anObject
]

{ #category : #initialization }
RSTimeLinePlot >> initialize [
	super initialize.
	self gapRatio: 0.1.
]

{ #category : #rendering }
RSTimeLinePlot >> renderIn: canvas [
	bars := RSGroup new.
	1 to: xValues size by: 2 do: [ :index |	
		| x1 y1 x2 y2 origin corner rectangle sizeOffset |
		x1 := xValues at: index.
		y1 := yValues at: index.
		x2 := xValues at: index+1.
		y2 := yValues at: index+1.
		origin := self scalePoint: x1 @ y1.
		corner := self scalePoint: x2 @ y2.
		sizeOffset := 0@ self barSize / 2.0.
		rectangle := Rectangle
			origin: origin-sizeOffset
			corner: corner+sizeOffset.
		bars add: (self shape copy
			model: (x1 -> x2);
			color: self computeColor;
			fromRectangle: rectangle;
			yourself)
		].
	canvas addAll: bars. 
]
