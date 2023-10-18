"
Set some markers along the Y axis. 

-=-=-=-=-=-=-=-=-=
x := (-3.14 to: 3.14 by: 0.01).

p := RSLinePlot new.
p x: x y: x sin * 0.22 + 0.5.


p verticalTick asFloat.

p addDecoration: (RSYMarkerDecoration new average).
p addDecoration: (RSYMarkerDecoration new min).
p addDecoration: (RSYMarkerDecoration new max).

p addDecoration: (RSXMarkerDecoration new max).
p addDecoration: (RSXMarkerDecoration new min).
p addDecoration: (RSXMarkerDecoration new value: 0).
p 
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : 'RSYMarkerDecoration',
	#superclass : 'RSAbstractMarkerDecoration',
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'public - configuration' }
RSYMarkerDecoration >> average [
	getRelevantValueBlock := [ :aPlot | aPlot definedValuesY average ]
]

{ #category : 'rendering' }
RSYMarkerDecoration >> createMarkerLineFromPlot: aPlot [

	| value |
	value := self getValueToBeMarkedFromPlot: aPlot.
	^ RSLine new
			from: 0 @ (aPlot yScale scale: value);
			to: chart extent x @ (aPlot yScale scale: value)
]

{ #category : 'public - configuration' }
RSYMarkerDecoration >> max [
	getRelevantValueBlock := [ :p | p maxChartValueY ]
]

{ #category : 'public - configuration' }
RSYMarkerDecoration >> min [
	getRelevantValueBlock := [ :p | p minChartValueY ]
]
