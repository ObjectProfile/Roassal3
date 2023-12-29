Class {
	#name : 'RSChartTickTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
RSChartTickTest >> testDefaultFont [
	| plot canvas ticks labels defaultFont |
	plot := RSLinePlot y: #(1 2 3).
	plot build.
	canvas := plot container.
	ticks := plot verticalTick.
	labels := ticks labels.
	defaultFont := labels anyOne class familyFontName .
	self assert: (labels allSatisfy: [ :label | label fontName = defaultFont ])
]

{ #category : 'tests' }
RSChartTickTest >> testDoNotUseNiceLabel [

	| x p numberOfTicks vertical |
	x := -10.0 to: 20.0 count: 100.
	numberOfTicks := 2.
	p := RSScatterPlot new x: x y: (x raisedTo: 3).
	p horizontalTick numberOfTicks: 20;
				      integer.
	vertical := p verticalTick integer numberOfTicks: numberOfTicks.
	p build.
	self assert: vertical labels size equals: numberOfTicks
]

{ #category : 'tests' }
RSChartTickTest >> testFromNames [

	| dates y data x plot horizontal |
	dates := OrderedCollection new.
	y := OrderedCollection new.
	data := { '04-jun-2020'. 800. '03-jun-2020'. 900. '02-jun-2020'. 850 } reverse.
	data pairsDo: [ :f :d |
		dates add: d.
		y add: f ].
	x := 1 to: dates size.

	plot := RSLinePlot new x: x y: y.
	plot extent: 300 @ 200.

	horizontal := plot horizontalTick fromNames: dates.
	plot verticalTick numberOfTicks: 10;
			 asFloat.
	plot build.
	self assert: horizontal labels size equals: dates size
]

{ #category : 'tests' }
RSChartTickTest >> testFromNamesWithEmptyData [
	| dates x y plot |
	dates := {}.
	x := {}.
	y := {}.
	plot := RSHorizontalBarPlot new
		x: y y: x;
		yourself.
	self should: [ plot horizontalTick fromNames: dates ] raise: Error
]

{ #category : 'tests' }
RSChartTickTest >> testFromNamesWithOneData [
	| names indices values plot |
	names := { 'Simple'.}.
	indices := { 1 }.
	values := {100}.

	plot := RSHorizontalBarPlot new
		x: indices y: values;
		yourself.
	plot horizontalTick fromNames: names.
	plot removeVerticalTicks.
	plot build
]

{ #category : 'tests' }
RSChartTickTest >> testSetFontSize [
	| plot canvas ticks labels |
	plot := RSLinePlot y: #(1 2 3).
	canvas := plot container.
	ticks := plot verticalTick.
	ticks configuration fontSize: 12.
	plot build.
	labels := ticks labels.
	self assert: (labels allSatisfy: [ :label | label fontSize = 12 ])
]
