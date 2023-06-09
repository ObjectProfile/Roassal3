"
RSLinePlot is a class to create an y vs x plot.
"
Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'line',
		'format',
		'ylabel',
		'xlabel'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #'instance creation' }
RSLinePlot class >> example1 [
	| p |
	p := (self y: #(1 2 3 4)) format: 'or--'.
	^ p open.
]

{ #category : #'instance creation' }
RSLinePlot class >> y: aCollection [
	| linePlot |
	linePlot := self new.
	linePlot y: aCollection.
	^ linePlot
]

{ #category : #building }
RSLinePlot >> buildChart [

	| chartPlot |
	chartPlot := RSChart new.
	chartPlot add: self.

	chartPlot
		ylabel: self ylabel;
		xlabel: self xlabel;
		extent: 250 @ 200;
		padding: 15 @ 10.
	^ chartPlot
]

{ #category : #accessing }
RSLinePlot >> createdShapes [
	^ { line }
]

{ #category : #initialization }
RSLinePlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #testing }
RSLinePlot >> isLinePlot [
	^ true
]

{ #category : #accessing }
RSLinePlot >> line [
	^ line
]

{ #category : #constants }
RSLinePlot >> marker [
	^ self shape markers at: 1
]

{ #category : #'instance creation' }
RSLinePlot >> open [
	^ self buildChart open
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
RSLinePlot >> xlabel [
	^ xlabel
]

{ #category : #decoration }
RSLinePlot >> xlabel: aString [
	xlabel := aString
]

{ #category : #accessing }
RSLinePlot >> ylabel [
	^ ylabel
]

{ #category : #decoration }
RSLinePlot >> ylabel: aString [
	ylabel := aString
]
