"
Set some markers along the Y axis. 

-=-=-=-=-=-=-=-=-=
x := (-3.14 to: 3.14 by: 0.01).
c := RSChart new.

p := RSLinePlot new.
p x: x y: x sin * 0.22 + 0.5.
c addPlot: p.


c addDecoration: RSHorizontalTick new.
c addDecoration: (RSVerticalTick new asFloat).

c addDecoration: (RSYMarkerDecoration new average).
c addDecoration: (RSYMarkerDecoration new min).
c addDecoration: (RSYMarkerDecoration new max).

c addDecoration: (RSXMarkerDecoration new max).
c addDecoration: (RSXMarkerDecoration new min).
c addDecoration: (RSXMarkerDecoration new value: 0).
c 
-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSYMarkerDecoration,
	#superclass : #RSAbstractMarkerDecoration,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #'public - configuration' }
RSYMarkerDecoration >> average [
	getRelevantValueBlock := [ :aPlot | aPlot definedValuesY average ]
]

{ #category : #rendering }
RSYMarkerDecoration >> createMarkerLineFromPlot: aPlot [

	| value |
	value := self getValueToBeMarkedFromPlot: aPlot.
	^ RSLine new
			from: 0 @ (aPlot yScale scale: value);
			to: chart extent x @ (aPlot yScale scale: value)
]

{ #category : #'public - configuration' }
RSYMarkerDecoration >> max [
	getRelevantValueBlock := [ :p | p maxValueY ]
]

{ #category : #'public - configuration' }
RSYMarkerDecoration >> min [
	getRelevantValueBlock := [ :p | p minValueY ]
]
