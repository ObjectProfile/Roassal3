"
TODO
"
Class {
	#name : #RSAbstractPlot,
	#superclass : #RSAbstractChartElement,
	#instVars : [
		'xValues',
		'yValues',
		'shape'
	],
	#category : #'Roassal3-Chart-Core'
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

{ #category : #'public - shape' }
RSAbstractPlot >> color [
	^ self shape color
]

{ #category : #'public - shape' }
RSAbstractPlot >> color: aColor [
	self shape color: aColor
]

{ #category : #public }
RSAbstractPlot >> computeColor [
	"Return the color used by the chart element. The color is computed from the chart and from the colorBlock variable"
	^ self color ifNil: [ chart colorFor: self ].
]

{ #category : #initialization }
RSAbstractPlot >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #rendering }
RSAbstractPlot >> definedValuesX [
	"Return the list of X values that are defined"
	^ xValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : #rendering }
RSAbstractPlot >> definedValuesY [
	"Return the list Y values that are defined"
	^ yValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : #accessing }
RSAbstractPlot >> index [
	"Return the index of the plot within the list of plots to display in the plt object"
	^ chart plots indexOf: self
]

{ #category : #initialization }
RSAbstractPlot >> initialize [
	super initialize.
	shape := self defaultShape
]

{ #category : #testing }
RSAbstractPlot >> isBarPlot [
	^ false
]

{ #category : #testing }
RSAbstractPlot >> isHorizontalBarPlot [
	^ false
]

{ #category : #testing }
RSAbstractPlot >> isLinePlot [
	^ false
]

{ #category : #testing }
RSAbstractPlot >> isPointWellDefined: aPoint [
	"Indicate whether the point deserves to be displayed"
	^ (aPoint x isInfinite not and: [ aPoint y isInfinite not ])
		and: [ (aPoint x isNaN not and: [ aPoint y isNaN not ]) ]
]

{ #category : #testing }
RSAbstractPlot >> isScatterPlot [
	^ false
]

{ #category : #testing }
RSAbstractPlot >> isVerticalBarPlot [
	^ false
]

{ #category : #rendering }
RSAbstractPlot >> maxValueX [
	"Return the maximum X value of the plot, excluding NaN and infinite"

	^ self definedValuesX max
]

{ #category : #rendering }
RSAbstractPlot >> maxValueY [
	"Return the maximum Y value of the plot, excluding NaN and infinite"

	^ self definedValuesY max
]

{ #category : #rendering }
RSAbstractPlot >> minValueX [
	"Return the minimum X value of the plot, excluding NaN and infinite"
	^ self definedValuesX min
]

{ #category : #rendering }
RSAbstractPlot >> minValueY [
	"Return the minimum Y value of the plot, excluding NaN and infinite"
	^ self definedValuesY min
]

{ #category : #'accessing - computed' }
RSAbstractPlot >> scalePoint: aPoint [
	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #'public - shape' }
RSAbstractPlot >> shape [
	^ shape
]

{ #category : #'public - shape' }
RSAbstractPlot >> shape: aShape [
	shape := aShape
]

{ #category : #public }
RSAbstractPlot >> x: aCollection y: aCollection2 [ 
	"Define a plot with the X and Y coordinates. Both X and Y are collections of the same size.
	
	For example:
```
x := (-3.14 to: 3.14 by: 0.01).
c := RSChart new.

p := RSLinePlot new.
p x: x y: x sin * 0.22.
c addPlot: p.

p := RSLinePlot new.
p x: x y: x cos * 0.18.
c addPlot: p.

c addDecoration: RSHorizontalTick new.
c addDecoration: RSVerticalTick new asFloat.
c addDecoration: RSYMarkerDecoration new.
c 
```
	"
	self assert: [ aCollection notNil ] description: 'Cannot be nil'.
	self assert: [ aCollection2 notNil ] description: 'Cannot be nil'.
	self assert: [ aCollection size = aCollection2 size ] description: 'The two collections must have the same size'.
 	
	xValues := aCollection.
	yValues := aCollection2
]

{ #category : #accessing }
RSAbstractPlot >> xValues [
	^ xValues
]

{ #category : #public }
RSAbstractPlot >> y: aCollection [
	"Define a plot with only a Y coordinate. The X coordinate is the index of the data point.
	
	For example:
-=-=-=-=-=-=-=-=-=
x := (-3.14 to: 3.14 by: 0.01).
c := RSChart new.

p := RSLinePlot new.
p y: x sin * 0.22.
c addPlot: p.

p := RSLinePlot new.
p y: x cos * 0.18.
c addPlot: p.

c addDecoration: RSHorizontalTick new.
c addDecoration: (RSVerticalTick new asFloat).
c 
-=-=-=-=-=-=-=-=-=
	"
	self x: (1 to: aCollection size) y: aCollection
]

{ #category : #accessing }
RSAbstractPlot >> yValues [
	^ yValues
]
