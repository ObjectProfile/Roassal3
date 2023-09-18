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
	#superclass : #RSLineChartPopupBuilder,
	#instVars : [
		'labels',
		'icons'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot color: aColor [
	self for: aRSLinePlot icon: (RSEllipse new
		size: 10;
		color: aColor;
		yourself)
]

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot icon: aRSShape [
	icons at: aRSLinePlot put: aRSShape
]

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot text: aString [
	labels at: aRSLinePlot put: aString
]

{ #category : #public }
RSSimpleChartPopupBuilder >> for: aRSLinePlot text: aString color: aColor [
	self
		for: aRSLinePlot text: aString;
		for: aRSLinePlot color: aColor
]

{ #category : #initialization }
RSSimpleChartPopupBuilder >> initialize [
	super initialize.
	labels := Dictionary new.
	icons := Dictionary new
]

{ #category : #hooks }
RSSimpleChartPopupBuilder >> rowShapeFor: aRSLinePlot point: aPoint [
	| group |
	group := RSGroup new.

	icons at: aRSLinePlot ifPresent: [ :icon |
		group add: icon copy ].
	labels at: aRSLinePlot ifPresent: [ :label |
		group add: (RSLabel new text: label) ].
	group add: (RSLabel new text: aPoint y).
	RSHorizontalLineLayout new gapSize: 5; alignMiddle; on: group.
	^ group asShape
]
