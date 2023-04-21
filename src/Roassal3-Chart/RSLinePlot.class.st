"
TODO
"
Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'line'
	],
	#category : #'Roassal3-Chart-Plots'
}

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
