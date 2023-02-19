"
Set a marker in the chart. For example:

=-=-=-==-=-=-==-=-=-=
x := (-3.14 to: 3.14 by: 0.01).
c := RSChart new.

p := RSLinePlot new.
p x: x y: x sin * 0.22.
c addPlot: p.

p := RSLinePlot new.
p x: x y: x cos * 0.18.
c addPlot: p.

c addDecoration: RSHorizontalTick new.
c addDecoration: (RSVerticalTick new asFloat).
c addDecoration: (RSYMarkerDecoration new ).
c 
=-=-=-==-=-=-==-=-=-=
"
Class {
	#name : #RSAbstractMarkerDecoration,
	#superclass : #RSAbstractChartDecoration,
	#instVars : [
		'markerColor',
		'getRelevantValueBlock',
		'lines'
	],
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #'public - configuration' }
RSAbstractMarkerDecoration >> average [
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractMarkerDecoration >> createMarkerLineFromPlot: aPlot [
	"This method should be overriden to produce a line"
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractMarkerDecoration >> createdShapes [
	^ lines
]

{ #category : #rendering }
RSAbstractMarkerDecoration >> defaultDashStyle [
	^ #(2 2 2)
]

{ #category : #initialization }
RSAbstractMarkerDecoration >> defaultMarkerColor [
	^ Color red
]

{ #category : #initialization }
RSAbstractMarkerDecoration >> defaultShape [
	^ RSLine new
]

{ #category : #rendering }
RSAbstractMarkerDecoration >> getValueToBeMarkedFromPlot: p [
	^ getRelevantValueBlock rsValue: p
]

{ #category : #initialization }
RSAbstractMarkerDecoration >> initialize [
	super initialize.

	"Per default, mark the max value"
	self max.
	markerColor := self defaultMarkerColor
]

{ #category : #accessing }
RSAbstractMarkerDecoration >> lines [
	^ lines
]

{ #category : #'public - configuration' }
RSAbstractMarkerDecoration >> max [
	self subclassResponsibility
]

{ #category : #'public - configuration' }
RSAbstractMarkerDecoration >> min [
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractMarkerDecoration >> renderIn: canvas [
	lines := chart plots collect: [ :p | | line |
		line := self createMarkerLineFromPlot: p.
		line
			dashArray: self defaultDashStyle;
			color: markerColor.
		self addShape: line.
		line
	] as: RSGroup
]

{ #category : #'public - configuration' }
RSAbstractMarkerDecoration >> value: aValue [
	"Mark the value"
	getRelevantValueBlock := aValue
]
