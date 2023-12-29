"
Class: RSAbstractMarkerDecoration
                                                                                                    
Set a marker in the chart. For example:

=-=-=-==-=-=-==-=-=-=
x := (-3.14 to: 3.14 by: 0.01).
c := RSCompositeChart new.

p := RSLinePlot new.
p x: x y: x sin * 0.22.
c addPlot: p.

p := RSLinePlot new.
p x: x y: x cos * 0.18.
c addPlot: p.

c verticalTick asFloat.
c addDecoration: (RSYMarkerDecoration new ).
c
=-=-=-==-=-=-==-=-=-=
"
Class {
	#name : 'RSAbstractMarkerDecoration',
	#superclass : 'RSAbstractChartDecoration',
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'markerColor',
		'getRelevantValueBlock',
		'lines'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'public - configuration' }
RSAbstractMarkerDecoration >> average [
	self subclassResponsibility
]

{ #category : 'public - shape' }
RSAbstractMarkerDecoration >> color: aColor [

	super color: aColor.
	markerColor := aColor
]

{ #category : 'rendering' }
RSAbstractMarkerDecoration >> createMarkerLineFromPlot: aPlot [
	"This method should be overriden to produce a line"
	self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractMarkerDecoration >> createdShapes [
	^ lines
]

{ #category : 'rendering' }
RSAbstractMarkerDecoration >> defaultDashStyle [
	^ #(2 2 2)
]

{ #category : 'initialization' }
RSAbstractMarkerDecoration >> defaultMarkerColor [
	^ Color red
]

{ #category : 'initialization' }
RSAbstractMarkerDecoration >> defaultShape [
	^ RSLine new
]

{ #category : 'rendering' }
RSAbstractMarkerDecoration >> getValueToBeMarkedFromPlot: p [

	^ getRelevantValueBlock rsValue: p
]

{ #category : 'initialization' }
RSAbstractMarkerDecoration >> initialize [

	super initialize.

	"Per default, mark the max value"
	self max.
	markerColor := self color ifNil: [ self defaultMarkerColor ] ifNotNil: [ self color ]
]

{ #category : 'accessing' }
RSAbstractMarkerDecoration >> lines [
	^ lines
]

{ #category : 'public - configuration' }
RSAbstractMarkerDecoration >> max [
	self subclassResponsibility
]

{ #category : 'public - configuration' }
RSAbstractMarkerDecoration >> min [
	self subclassResponsibility
]

{ #category : 'rendering' }
RSAbstractMarkerDecoration >> renderIn: canvas [

	| line |
	line := self createMarkerLineFromPlot: chart.
	line
		dashArray: self defaultDashStyle;
		color: markerColor.
	self addShape: line.
	lines := { line } as: RSGroup
]

{ #category : 'public - configuration' }
RSAbstractMarkerDecoration >> value: aValue [
	"Mark the value"
	getRelevantValueBlock := aValue
]
