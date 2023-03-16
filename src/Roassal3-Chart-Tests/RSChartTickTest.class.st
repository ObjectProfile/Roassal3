Class {
	#name : #RSChartTickTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSChartTickTest >> testDoNotUseNiceLabel [
	| x c numberOfTicks vertical |
	x := -10.0 to: 20.0 count: 100.
	numberOfTicks := 2.
	c := RSChart new
		addPlot: (RSScatterPlot new x: x y: (x raisedTo: 3));
		addPlot: (RSLinePlot new x: x y: (x raisedTo: 2));
		addDecoration: (RSHorizontalTick new
			numberOfTicks: 20;
			integer);
		addDecoration: (vertical := RSVerticalTick new integer
			numberOfTicks: numberOfTicks;
			doNotUseNiceLabel);
		yourself.
	c build.
	self assert: vertical labels size equals: numberOfTicks+1
]

{ #category : #tests }
RSChartTickTest >> testFromNames [
	| dates y data x c horizontal |
	dates := OrderedCollection new.
	y := OrderedCollection new.
	data :=
	{'04-jun-2020'.800.
	'03-jun-2020'.	900.
	'02-jun-2020'.	850} reverse.
		data pairsDo: [ :f :d |
			dates add: d.
			y add: f ].
	x := 1 to: dates size.
	c := RSChart new.
	c extent: 300@200.

	c addPlot: (RSLinePlot new x: x y: y).

	c addDecoration: ( horizontal := RSHorizontalTick new fromNames: dates).
	c addDecoration: (RSVerticalTick new numberOfTicks: 10; asFloat).
	c build.
	self assert: horizontal labels size equals: dates size
]

{ #category : #tests }
RSChartTickTest >> testFromNamesWithEmptyData [
	| dates x y chart |
	dates := {}.
	x := {}.
	y := {}.
	chart := RSChart new.
	chart add: (RSHorizontalBarPlot new
		x: y y: x;
		yourself).
	self should: [ chart add: (RSHorizontalTick new
		fromNames: dates;
		yourself) ] raise: Error
]

{ #category : #tests }
RSChartTickTest >> testFromNamesWithOneData [
	| names indices values chart |
	names := { 'Simple'.}.
	indices := { 1 }.
	values := {100}.

	chart := RSChart new.
	chart add: (RSHorizontalBarPlot new
		x: indices y: values;
		yourself).
	chart add: (RSHorizontalTick new
		fromNames: names;
		yourself).
	chart build
]
