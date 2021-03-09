"
TODO
"
Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#traits : 'RSTEdge',
	#classTraits : 'RSTEdge classTrait',
	#category : #'Roassal3-Chart-Core'
}

{ #category : #initialization }
RSLinePlot >> defaultShape [
	^ RSPolyline new color: nil.
]

{ #category : #testing }
RSLinePlot >> isLinePlot [
	^ true
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
	canvas add: (self shape
		color: self computeColor;
		controlPoints: controlPoints;
		yourself).
]

{ #category : #'public - shape' }
RSLinePlot >> shape [
	^ shape
]

{ #category : #'public - shape' }
RSLinePlot >> shape: aShape [
	self shouldNotImplement
]
