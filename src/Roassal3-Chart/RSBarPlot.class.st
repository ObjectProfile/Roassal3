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
	#superclass : #RSAbstractPlot,
	#instVars : [
		'barWidth'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSBarPlot >> barScale [
	^ NSOrdinalScale new 
		domain: xValues;
		rangeBands: xScale range padding: 0.1.
]

{ #category : #accessing }
RSBarPlot >> barWidth [
	"Return the width of each bar"
	^ barWidth
]

{ #category : #accessing }
RSBarPlot >> barWidth: aBarWidth [
	"Set the width of the bar"
	barWidth := aBarWidth
]

{ #category : #rendering }
RSBarPlot >> beforeRenderingIn: aChart [
	super beforeRenderingIn: aChart.
	
	aChart xScale: self barScale.
]

{ #category : #initialization }
RSBarPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #rendering }
RSBarPlot >> definedValuesY [
	"Return the list Y values that are defined"
	^ yValues, {0} select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : #rendering }
RSBarPlot >> renderIn: canvas [
	| color width myScale |
	self checkAssertion.
	color := self computeColor.
"	myScale := self barScale."
	myScale := xScale.
	width := self barWidth.
	width ifNil: [ width := myScale rangeBand ].
	xValues doWithIndex: [ :xt : i | 
		| yt origin corner r |
		yt := yValues at: i.
		origin := (myScale scale: xt) @ (yScale scale: yt).
		corner := origin x @ (yScale scale: 0).
		((self isPointWellDefined: origin) and: [ self isPointWellDefined: corner ]) ifTrue: [
			r := Rectangle origin: origin corner: corner + (width@0).
			canvas add: (self shape copy
				color: color;
				fromRectangle: r;
				yourself).
			  ] ].

]
