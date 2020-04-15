"
Set a marker in the chart. For example:

=-=-=-==-=-=-==-=-=-=
c := RSChart new.

p := RSLinePlot new.
p x: x y: x sin * 0.22.
c addPlot: p.

p := RSLinePlot new.
p x: x y: x cos * 0.18.
c addPlot: p.

c addDecoration: RSHorizontalTick new.
c addDecoration: (RSVerticalTick new asFloat).
c addDecoration: (RSMarkerDecoration new ).
c 
=-=-=-==-=-=-==-=-=-=
"
Class {
	#name : #RSMarkerDecoration,
	#superclass : #RSChartDecoration,
	#instVars : [
		'markerColor'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #initialization }
RSMarkerDecoration >> initialize [
	super initialize.
	markerColor := Color red.
]

{ #category : #rendering }
RSMarkerDecoration >> renderIn: canvas [
	| value line |
	
	chart plots do: [ :p |
		value := p maxValueY.
		line := RSLine new
			from: 0 @ (p yScale scale: value);
			to: chart extent x @ (p yScale scale: value);
			dashArray: #(2 2 2);
			color: markerColor;
			yourself.
		chart canvas add: line.
	].
 
]
