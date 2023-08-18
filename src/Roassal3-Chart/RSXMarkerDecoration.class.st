"
Set some markers along the X axis. 

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
	#name : #RSXMarkerDecoration,
	#superclass : #RSAbstractMarkerDecoration,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #'public - configuration' }
RSXMarkerDecoration >> average [
	getRelevantValueBlock := [ :aPlot | aPlot definedValuesX average ]
]

{ #category : #rendering }
RSXMarkerDecoration >> createMarkerLineFromPlot: aPlot [

	| value |
	value := self getValueToBeMarkedFromPlot: aPlot.

	^ self shape copy
			from: (aPlot xScale scale: value) @ 0;
			to: (aPlot xScale scale: value) @ chart extent y negated
]

{ #category : #'public - configuration' }
RSXMarkerDecoration >> max [
	getRelevantValueBlock := [ :p | p maxChartValueX ]
]

{ #category : #'public - configuration' }
RSXMarkerDecoration >> min [
	getRelevantValueBlock := [ :p | p minChartValueX ]
]

{ #category : #'public - configuration' }
RSXMarkerDecoration >> sumUpTo: ratio [
	self assert: (ratio between: 0 and: 1). 
	getRelevantValueBlock := [ :aPlot | | total |
		total := aPlot definedValuesY sum.
		(1 to: aPlot definedValuesY size) detect: [ :i |
			(aPlot definedValuesY first: i) sum >= (ratio * total) ] ]
]
