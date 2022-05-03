"
Set some markers along the X axis. 

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
	getRelevantValueBlock := [ :p | p maxValueX ]
]

{ #category : #'public - configuration' }
RSXMarkerDecoration >> min [
	getRelevantValueBlock := [ :p | p minValueX ]
]
