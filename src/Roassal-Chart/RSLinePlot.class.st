"
RSLinePlot is a class to create an y vs x plot.
"
Class {
	#name : 'RSLinePlot',
	#superclass : 'RSAbstractPlot',
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'line'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RSLinePlot class >> example1 [
	| p |
	p := (self y: #(1 2 3 4)) format: 'or--'.
	^ p open
]

{ #category : 'instance creation' }
RSLinePlot class >> y: aCollection [
	| linePlot |
	linePlot := self new.
	linePlot y: aCollection.
	^ linePlot
]

{ #category : 'accessing' }
RSLinePlot >> createdShapes [
	^ { line }
]

{ #category : 'accessing - defaults' }
RSLinePlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : 'testing' }
RSLinePlot >> isLinePlot [
	^ true
]

{ #category : 'accessing' }
RSLinePlot >> line [
	^ line
]

{ #category : 'constants' }
RSLinePlot >> marker [
	^ self shape markers at: 1
]

{ #category : 'rendering' }
RSLinePlot >> renderIn: canvas [
	| controlPoints |
	super renderIn: canvas.
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
