"
<keyClass>
`RSBarPlot` is a plot that represents a bar chart.

*Responsibility*: display a bar chart, with adequate color & bar width value per default.

*Collaborators*: a bar plot is added to `RSCompositeChart`.

*Variables*:
- `barWidth`: width of a bar. A default computed value is assigned.

*Example*:
```Smalltalk
data := #(4 10 5 9).

d := RSBarPlot new.
d color: Color green darker darker darker.
d y: data.

d verticalTick integer.

d addDecoration: (RSYLabelDecoration new title: 'Difference'; rotationAngle: -90; offset: -25 @ 0).
d addDecoration: (RSXLabelDecoration new title: 'Evolution').
d
```
"
Class {
	#name : #RSBarPlot,
	#superclass : #RSAbstractBarPlot,
	#instVars : [
		'bottom'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #examples }
RSBarPlot class >> exampleClusterBarPlots [
	| p1 p2 chart data1 data2 x |
	data1 := {  10. 9. 7 }. "blue"
	data2	:= { 20. 15. 8 }. "orange"
	x := { 1. 2. 3. }.
	p1 := self x: x y: data1.
	p2 := self x: x y: data2.
	chart := p1 + p2.
	^ chart open.
]

{ #category : #examples }
RSBarPlot class >> exampleClusterBarPlots4Bars [
	| p1 p2 chart data1 data2 x p3 p4|
	data1 := {  10. 9. 7 }. "blue"
	data2	:= { 20. 15. 8 }. "orange"
	x := { 1. 2. 3. }.
	p1 := self x: x y: data1.
	p2 := self x: x y: data2.
	p3 := self x: x y: data1.
	p4 := self x: x y: data2.
	chart := p1 + p2 + p3 + p4.
	^ chart open.
]

{ #category : #accessing }
RSBarPlot >> barScale [
	^ xScale
]

{ #category : #rendering }
RSBarPlot >> beforeRenderingIn: aChart [

	| barScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	barScale := NSOrdinalScale new
		domain: xValues;
		rangeBands: xScale range padding: gapRatio.
	aChart xScale: barScale.
]

{ #category : #accessing }
RSBarPlot >> bottom [
	^ bottom
]

{ #category : #accessing }
RSBarPlot >> bottom: aCollection [
	self
		assert: xValues size = aCollection size
		description: 'Invalid size'.
	bottom := aCollection
]

{ #category : #testing }
RSBarPlot >> canHandleCluster [
	^ true
]

{ #category : #hooks }
RSBarPlot >> computeRectagleFor: aPoint index: index [
	| origin corner sizeOffset offset zero |
	zero := 0.
	bottom ifNotNil: [ zero := bottom at: index ].
	origin := self scalePoint: aPoint + (0@ zero).
	corner := origin x @ (yScale scale: zero ).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	^ Rectangle
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : #rendering }
RSBarPlot >> definedValuesY [
	"Return the list Y values that are defined"
	| res |
	res := yValues.
	bottom ifNotNil: [ res := yValues + bottom ].
	^ res, {0}
]

{ #category : #testing }
RSBarPlot >> isVerticalBarPlot [
	^ true
]

{ #category : #hooks }
RSBarPlot >> modelFor: aPoint [
	^ aPoint y
]

{ #category : #hooks }
RSBarPlot >> numberOfBands [
	| bandScale |
	self beforeRenderingIn: chart.
	bandScale := NSOrdinalScale new
		domain: xValues;
		rangeBands: xScale range padding: gapRatio.
	^ bandScale range size.
]
