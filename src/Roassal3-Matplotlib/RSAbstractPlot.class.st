Class {
	#name : #RSAbstractPlot,
	#superclass : #RSAbstractChartElement,
	#instVars : [
		'label',
		'xValues',
		'yValues'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSAbstractPlot >> beforeRenderingIn: aChart [
	super beforeRenderingIn: aChart.
	self createXScale.
	self createYScale
]

{ #category : #testing }
RSAbstractPlot >> checkAssertion [
	self
		assert: [ xValues notNil and: [ yValues notNil ] ]
		description: 'X and Y values must be added'.
	self
		assert: [ xValues size = yValues size ]
		description: 'X and Y values have not the same size, and they should'
]

{ #category : #accessing }
RSAbstractPlot >> index [
	"Return the index of the plot within the list of plots to display in the plt object"
	^ chart plots indexOf: self
]

{ #category : #initialization }
RSAbstractPlot >> initialize [
	super initialize.
	label := ''
]

{ #category : #testing }
RSAbstractPlot >> isPointWellDefined: aPoint [
	"Indicate whether the point deserves to be displayed"
	^ (aPoint x isInfinite not and: [ aPoint y isInfinite not ])
		and: [ (aPoint x isNaN not and: [ aPoint y isNaN not ]) ]
]

{ #category : #rendering }
RSAbstractPlot >> maxValueX [
	"Return the maximum X value of the plot, excluding NaN and infinite"
	^ (xValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]) max
]

{ #category : #rendering }
RSAbstractPlot >> maxValueY [
	"Return the maximum Y value of the plot, excluding NaN and infinite"
	^ (yValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]) max
]

{ #category : #rendering }
RSAbstractPlot >> minValueX [
	"Return the minimum X value of the plot, excluding NaN and infinite"
	^ (xValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]) min
]

{ #category : #rendering }
RSAbstractPlot >> minValueY [
	"Return the minimum Y value of the plot, excluding NaN and infinite"
	^ (yValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]) min
]

{ #category : #public }
RSAbstractPlot >> x: aCollection y: aCollection2 [ 
	xValues := aCollection.
	yValues := aCollection2.
]

{ #category : #public }
RSAbstractPlot >> y: aCollection [
	self x: (1 to: aCollection size) y: aCollection
]
