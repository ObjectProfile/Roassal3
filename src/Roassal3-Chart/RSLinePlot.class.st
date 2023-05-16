"
TODO
"
Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'line',
		'format',
		'ylabel'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #'instance creation' }
RSLinePlot class >> y: aCollection [
	| linePlot |
	linePlot := self new.
	linePlot y: aCollection.
	^ linePlot
]

{ #category : #accessing }
RSLinePlot >> createdShapes [
	^ { line }
]

{ #category : #initialization }
RSLinePlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #formatting }
RSLinePlot >> format2 [
	^ format
]

{ #category : #formatting }
RSLinePlot >> format2: aString [
	format := aString
]

{ #category : #testing }
RSLinePlot >> isLinePlot [
	^ true
]

{ #category : #accessing }
RSLinePlot >> line [
	^ line
]

{ #category : #'instance creation' }
RSLinePlot >> open [
	| chartPlot marker colorDictionary colorChar color markerChar|
	colorDictionary := Dictionary newFrom: { $r -> Color red.}.
	chartPlot := RSChart new.
	chartPlot add: self.
	chartPlot ylabel: self ylabel.
	
	colorChar := self format2 at: 3.
	markerChar := self format2 copyFrom: 1 to: 1.
	color := colorDictionary at: colorChar.
	self color: color.
	
	marker := RSShapeFactory shapeFromString: markerChar.
	self shape marker: marker.
	chartPlot add: RSHorizontalTick new.
	chartPlot add: RSVerticalTick new.
	^ chartPlot open
]

{ #category : #rendering }
RSLinePlot >> renderIn: canvas [
	| controlPoints |
	self checkAssertion.
	controlPoints := OrderedCollection new.
	(1 to: xValues size) do: [ :i |
			| xt yt |
			xt := xValues at: i.
			yt := yValues at: i.
			(self isPointWellDefined: xt @ yt)
				ifTrue: [ controlPoints add: (self scalePoint: xt @ yt) ] ].
	canvas add: (line := self shape copy
		color: self computeColor;
		controlPoints: controlPoints;
		yourself)
]

{ #category : #accessing }
RSLinePlot >> ylabel [
	^ ylabel
]

{ #category : #decoration }
RSLinePlot >> ylabel: aString [
	ylabel := aString
]
