"
<keyClass>
`RSBarPlot` is a plot for Roassal's chart that represents a bar chart.

*Responsibility*: display a bar chart, with adequate color & bar width value per default.

*Collaborators*: a bar plot is added to `RSChart`.

*Variables*:
- `barWidth`: width of a bar. A default computed value is assigned.

*Example*:
```Smalltalk
data := #(4 10 5 9).
c := RSChart new.

d := RSBarPlot new.
d color: Color green darker darker darker.
d y: data.
c addPlot: d.

c addDecoration: (RSVerticalTick new integer).
c addDecoration: (RSHorizontalTick new).

c addDecoration: (RSYLabelDecoration new title: 'Difference'; rotationAngle: -90; offset: -25 @ 0).
c addDecoration: (RSXLabelDecoration new title: 'Evolution').
c
```
"
Class {
	#name : #RSBarPlot,
	#superclass : #RSAbstractBarPlot,
	#category : #'Roassal3-Chart-Core'
}

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
	aChart xScale: barScale
]

{ #category : #hooks }
RSBarPlot >> computeRectagleFor: aPoint [
	| origin corner sizeOffset offset |
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y).
	corner := origin x @ (yScale scale: 0).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	^ Rectangle 
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : #rendering }
RSBarPlot >> definedValuesY [
	"Return the list Y values that are defined"
	^ yValues, {0} select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : #testing }
RSBarPlot >> isVerticalBarPlot [
	^ true
]

{ #category : #hooks }
RSBarPlot >> modelFor: aPoint [
	^ aPoint y
]
