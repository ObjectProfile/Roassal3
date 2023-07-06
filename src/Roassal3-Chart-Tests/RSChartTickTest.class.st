Class {
	#name : #RSChartTickTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSChartTickTest >> testDefaultFont [
	| chart plot canvas ticks labels |
	chart := RSCompositeChart new.
	plot := RSLinePlot y: #(1 2 3).
	chart add: RSVerticalTick new.
	chart add: plot.
	chart build.
	canvas := chart container.
	ticks := chart verticalTick.
	labels := ticks labels.
	self assert: (labels allSatisfy: [ :label | label font = label class defaultFont ]).
]

{ #category : #tests }
RSChartTickTest >> testDoNotUseNiceLabel [

	| x c numberOfTicks vertical |
	x := -10.0 to: 20.0 count: 100.
	numberOfTicks := 2.
	c := RSCompositeChart new
		     addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		     addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		     yourself.
	c horizontalTick numberOfTicks: 20;
				      integer.
	vertical := c verticalTick integer numberOfTicks: numberOfTicks.
	c build.
	self assert: vertical labels size equals: numberOfTicks
]

{ #category : #tests }
RSChartTickTest >> testFromNames [

	| dates y data x chart horizontal |
	dates := OrderedCollection new.
	y := OrderedCollection new.
	data := { '04-jun-2020'. 800. '03-jun-2020'. 900. '02-jun-2020'. 850 } reverse.
	data pairsDo: [ :f :d |
		dates add: d.
		y add: f ].
	x := 1 to: dates size.
	chart := RSCompositeChart new.
	chart extent: 300 @ 200.

	chart addPlot: (RSLinePlot new x: x y: y).

	horizontal := chart horizontalTick fromNames: dates.
	chart verticalTick numberOfTicks: 10;
			 asFloat.
	chart build.
	self assert: horizontal labels size equals: dates size
]

{ #category : #tests }
RSChartTickTest >> testFromNamesWithEmptyData [
	| dates x y chart |
	dates := {}.
	x := {}.
	y := {}.
	chart := RSCompositeChart new.
	chart add: (RSHorizontalBarPlot new
		x: y y: x;
		yourself).
	self should: [ chart horizontalTick fromNames: dates ] raise: Error
]

{ #category : #tests }
RSChartTickTest >> testFromNamesWithOneData [
	| names indices values chart |
	names := { 'Simple'.}.
	indices := { 1 }.
	values := {100}.

	chart := RSCompositeChart new.
	chart add: (RSHorizontalBarPlot new
		x: indices y: values;
		yourself).
	chart horizontalTick fromNames: names.
	chart removeVerticalTicks.
	chart build
]

{ #category : #tests }
RSChartTickTest >> testSetFontSize [
	| chart plot canvas ticks labels |
	chart := RSCompositeChart new.
	plot := RSLinePlot y: #(1 2 3).
	chart add: RSVerticalTick new.
	chart add: plot.
	canvas := chart container.
	ticks := chart verticalTick.
	ticks configuration fontSize: 12.
	chart build.
	labels := ticks labels.
	self assert: (labels allSatisfy: [ :label | label fontSize = 12 ]).
]
