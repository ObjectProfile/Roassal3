Class {
	#name : #PLTAbstractPlot,
	#superclass : #PLTAbstractElement,
	#instVars : [
		'label',
		'xValues',
		'yValues'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTAbstractPlot >> checkAssertion [
	self
		assert: [ xValues notNil and: [ yValues notNil ] ]
		description: 'X and Y values must be added'.
	self
		assert: [ xValues size = yValues size ]
		description: 'X and Y values have not the same size, and they should'
]

{ #category : #rendering }
PLTAbstractPlot >> createXScale [
	^ TSScale linear
		domain:
			{plt minValueX.
			plt maxValueX};
		range:
			{0.
			plt extent x}
]

{ #category : #rendering }
PLTAbstractPlot >> createYScale [
	^ TSScale linear
		domain:
			{plt minValueY.
			plt maxValueY};
		range:
			{0.
			plt extent y negated}
]

{ #category : #accessing }
PLTAbstractPlot >> index [
	"Return the index of the plot within the list of plots to display in the plt object"
	^ plt plots indexOf: self
]

{ #category : #initialization }
PLTAbstractPlot >> initialize [
	super initialize.
	label := ''
]

{ #category : #rendering }
PLTAbstractPlot >> maxValueX [
	^ xValues max
]

{ #category : #rendering }
PLTAbstractPlot >> maxValueY [
	^ yValues max
]

{ #category : #rendering }
PLTAbstractPlot >> minValueX [
	^ xValues min
]

{ #category : #rendering }
PLTAbstractPlot >> minValueY [
	^ yValues min
]

{ #category : #public }
PLTAbstractPlot >> x: aCollection y: aCollection2 [ 
	xValues := aCollection.
	yValues := aCollection2.
]
