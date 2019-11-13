Class {
	#name : #RSAbstractPlot,
	#superclass : #RSAbstractChartElement,
	#instVars : [
		'label',
		'xValues',
		'yValues'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSAbstractPlot >> checkAssertion [
	self
		assert: [ xValues notNil and: [ yValues notNil ] ]
		description: 'X and Y values must be added'.
	self
		assert: [ xValues size = yValues size ]
		description: 'X and Y values have not the same size, and they should'
]

{ #category : #rendering }
RSAbstractPlot >> createXScale [
	^ TSScale linear
		domain:
			{plt minValueX.
			plt maxValueX};
		range:
			{0.
			plt extent x}
]

{ #category : #rendering }
RSAbstractPlot >> createYScale [
	^ TSScale linear
		domain:
			{plt minValueY.
			plt maxValueY};
		range:
			{0.
			plt extent y negated}
]

{ #category : #accessing }
RSAbstractPlot >> index [
	"Return the index of the plot within the list of plots to display in the plt object"
	^ plt plots indexOf: self
]

{ #category : #initialization }
RSAbstractPlot >> initialize [
	super initialize.
	label := ''
]

{ #category : #rendering }
RSAbstractPlot >> maxValueX [
	^ xValues max
]

{ #category : #rendering }
RSAbstractPlot >> maxValueY [
	^ yValues max
]

{ #category : #rendering }
RSAbstractPlot >> minValueX [
	^ xValues min
]

{ #category : #rendering }
RSAbstractPlot >> minValueY [
	^ yValues min
]

{ #category : #public }
RSAbstractPlot >> x: aCollection y: aCollection2 [ 
	xValues := aCollection.
	yValues := aCollection2.
]
