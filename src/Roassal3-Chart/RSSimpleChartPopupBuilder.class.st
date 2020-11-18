"
I am a simple chart popup builder. I create a row for each line bar plot.
Then I apply a vertical line layout to each row.

Users can create a subclass and override `rowShapefor:`

This class is a simple demo of how to create a basic popup for a RSChart with lines plots.

It could be different, in that case feel free extend classes like `RSPopupDecoration`
or `RSMarkerPopupChart`

```Smalltalk
| x cumsum c  y error popup |
x := 1 to: 100.
cumsum := [:arr | | sum |
	sum := 0.
	arr collect: [ :v | sum := sum + v. sum ] ].

c := RSChart new.
c extent: 800@400.

popup := RSPopupDecoration new.
c addDecoration: popup.

#(
series1 red
series2 blue) pairsDo: [ :label :color |
	| col plot |
	y := (x collect: [ :i | 50 atRandom - 25 ]).
	y := cumsum value: y.
	error := x.
	col := color value: Color.
	
	c addPlot: (RSAreaPlot new 
		x: x y1: y + error y2: y - error;
		color: col translucent).
	c addPlot: (plot := RSLinePlot new x: x y: y; fmt: 'o';
		color: col;
		yourself).
	popup chartPopupBuilder
		for: plot text: label color: col.
	 ].

c build.

^ c canvas.
```
"
Class {
	#name : #RSSimpleChartPopupBuilder,
	#superclass : #RSAbstractChartPopupBuilder,
	#instVars : [
		'labels',
		'colors'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot color: aColor [
	colors at: aRSLinePlot put: aColor
]

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot text: aString [
	labels at: aRSLinePlot put: aString
]

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot text: aString color: aColor [
	self 
		for: aRSLinePlot text: aString;
		for: aRSLinePlot color: aColor.
]

{ #category : #initialization }
RSSimpleChartPopupBuilder >> initialize [
	super initialize.
	labels := Dictionary new.
	colors := Dictionary new.
]

{ #category : #hooks }
RSSimpleChartPopupBuilder >> rowShapeFor: aRSLinePlot [
	"override this method to get different results"
	| valuePoint group |
	valuePoint := self valuePointFor: aRSLinePlot.
	valuePoint ifNil: [ ^ nil ].
	group := RSGroup new.
	
	colors at: aRSLinePlot ifPresent: [ :color |
		group add: (RSEllipse new color: color; size: 10) ].
	labels at: aRSLinePlot ifPresent: [ :label |
		group add: (RSLabel new text: label) ].
	group add: (RSLabel new text: valuePoint y).
	RSHorizontalLineLayout new gapSize: 5; alignMiddle; on: group.
	^ group asShape
		 
]

{ #category : #hooks }
RSSimpleChartPopupBuilder >> shapeFor: aRSChart [
	| plots |
	plots := aRSChart plots select: #isLinePlot.
	plots := plots 
		collect: [ :plot | self rowShapeFor: plot ]
		as: RSGroup.
	plots := plots reject: #isNil.
	RSVerticalLineLayout new gapSize: 0; on: plots.
	^ plots asShape
		padding: 10;
		color: (Color white alpha: 0.8);
		withBorder;
		yourself.
]

{ #category : #hooks }
RSSimpleChartPopupBuilder >> valuePointFor: aRSLinePlot [
	| xValue yValue |
	xValue := (aRSLinePlot xScale invert: position x) asInteger.
	yValue := aRSLinePlot yValues at: xValue.
	^ xValue @ yValue
	
]
