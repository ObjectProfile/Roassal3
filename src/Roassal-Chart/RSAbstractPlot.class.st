"
<keyClass>
`RSAbstractPlot` is the abstract class that encompass plots.

*Responsibility*: maintain and render plots.

*Collaborators*: a plot closely interacts with decorations and can be added in a `RSCompositeChart`. 

*Variables*:
- chart: if the plot is added into a chart, refers to this chart, else refers to the plot itself
- shape: the shape of the plot
- xValues: the x values of the plot
- yValues: the y values of the plot
"
Class {
	#name : 'RSAbstractPlot',
	#superclass : 'RSAbstractChart',
	#instVars : [
		'chart',
		'shape',
		'xValues',
		'yValues',
		'rawData'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'testing' }
RSAbstractPlot class >> isAbstract [

	^ self == RSAbstractPlot
]

{ #category : 'instance creation' }
RSAbstractPlot class >> points: aCollectionOfPoints [
	^ self new
		x: (aCollectionOfPoints collect: #x) y: (aCollectionOfPoints collect: #y);
		yourself
]

{ #category : 'instance creation' }
RSAbstractPlot class >> x: collectionX y: collectionY [
	^ self new
		x: collectionX y: collectionY;
		yourself
]

{ #category : 'accessing' }
RSAbstractPlot >> + aRSPlot [
	| newChart |
	newChart := (aRSPlot canHandleCluster and: [ self canHandleCluster ])
		ifTrue: [ RSClusterChart new ]
		ifFalse: [ RSCompositeChart new ].
	newChart add: self.
	newChart add: aRSPlot.
	^ newChart
]

{ #category : 'rendering' }
RSAbstractPlot >> beforeRenderingIn: aChart [

	self createXScale.
	self createYScale
]

{ #category : 'testing' }
RSAbstractPlot >> canHandleCluster [
	^ false
]

{ #category : 'accessing' }
RSAbstractPlot >> chart [

	^ chart ifNil: [ self ]
]

{ #category : 'accessing' }
RSAbstractPlot >> chart: aChart [

	chart := aChart
]

{ #category : 'testing' }
RSAbstractPlot >> checkAssertion [

	self
		assert: [ xValues notNil and: [ yValues notNil ] ]
		description: 'X and Y values must be added'.
	self
		assert: [ xValues size = yValues size ]
		description:
		'X and Y values have not the same size, and they should'
]

{ #category : 'public - shape' }
RSAbstractPlot >> color [

	^ self shape color
]

{ #category : 'accessing - computed' }
RSAbstractPlot >> color: aColor [

	self shape color: aColor
]

{ #category : 'accessing - computed' }
RSAbstractPlot >> computeColor [
	"Return the color used by the chart element. The color is computed from the chart and from the colorBlock variable"

	^ self color ifNil: [ self chart colorFor: self ]
]

{ #category : 'accessing' }
RSAbstractPlot >> createdShapes [

	^ self subclassResponsibility
]

{ #category : 'accessing - defaults' }
RSAbstractPlot >> defaultShape [

	^ self subclassResponsibility
]

{ #category : 'rendering' }
RSAbstractPlot >> definedValuesX [
	"Return the list of X values that are defined"

	^ xValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : 'rendering' }
RSAbstractPlot >> definedValuesY [
	"Return the list Y values that are defined"

	^ yValues select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : 'initialization' }
RSAbstractPlot >> initialize [

	super initialize.
	shape := self defaultShape
]

{ #category : 'rendering' }
RSAbstractPlot >> invertCoordinates [
	| auxScale |
	auxScale := self yScale.
	self yScale: self xScale.
	self xScale: auxScale.
	self x: self y y: self x
]

{ #category : 'testing' }
RSAbstractPlot >> isBarPlot [

	^ false
]

{ #category : 'testing' }
RSAbstractPlot >> isBoxPlot [
	^ false
]

{ #category : 'testing' }
RSAbstractPlot >> isHorizontalBarPlot [

	^ false
]

{ #category : 'testing' }
RSAbstractPlot >> isLinePlot [

	^ false
]

{ #category : 'testing' }
RSAbstractPlot >> isPlot [

	^ true
]

{ #category : 'testing' }
RSAbstractPlot >> isPointWellDefined: aPoint [
	"Indicate whether the point deserves to be displayed"

	^ (aPoint x isInfinite not and: [ aPoint y isInfinite not ]) and: [
		  aPoint x isNaN not and: [ aPoint y isNaN not ] ]
]

{ #category : 'testing' }
RSAbstractPlot >> isScatterPlot [

	^ false
]

{ #category : 'testing' }
RSAbstractPlot >> isVerticalBarPlot [

	^ false
]

{ #category : 'accessing' }
RSAbstractPlot >> masterShape [
	^ self shape
]

{ #category : 'accessing' }
RSAbstractPlot >> masterShape: aShape [
	self shape: aShape
]

{ #category : 'accessing - extension' }
RSAbstractPlot >> maxChartValueX [
	"if not set before, returns the maximum x value of the plot"

	^ self chartExtents maxValueX
		  ifNil: [
			  | res |
			  self chartExtents maxValueX: (res := self maxValueX).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing - extension' }
RSAbstractPlot >> maxChartValueY [
	"if not set before, returns the maximum y value of the plot"

	^ self chartExtents maxValueY
		  ifNil: [
			  | res |
			  self chartExtents maxValueY: (res := self maxValueY).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'rendering' }
RSAbstractPlot >> maxValueX [
	"Return the maximum X value of the plot, excluding NaN and infinite"

	^ self definedValuesX max
]

{ #category : 'rendering' }
RSAbstractPlot >> maxValueY [
	"Return the maximum Y value of the plot, excluding NaN and infinite"

	^ self definedValuesY max
]

{ #category : 'accessing - extension' }
RSAbstractPlot >> minChartValueX [
	"if not set before, returns the minimum x value of the plot"

	^ self chartExtents minValueX
		  ifNil: [
			  | res |
			  self chartExtents minValueX: (res := self minValueX).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing - extension' }
RSAbstractPlot >> minChartValueY [
	"if not set before, returns the minimum y value of the plot"

	^ self chartExtents minValueY
		  ifNil: [
			  | res |
			  self chartExtents minValueY: (res := self minValueY).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'rendering' }
RSAbstractPlot >> minValueX [
	"Return the minimum X value of the plot, excluding NaN and infinite"

	^ self definedValuesX min
]

{ #category : 'rendering' }
RSAbstractPlot >> minValueY [
	"Return the minimum Y value of the plot, excluding NaN and infinite"

	^ self definedValuesY min
]

{ #category : 'public' }
RSAbstractPlot >> rawData: aCollection x: bloc1 y: bloc2 [

	rawData := aCollection.
	self x: (rawData collect: bloc1) y: (rawData collect: bloc2)
]

{ #category : 'rendering' }
RSAbstractPlot >> renderIn: aCanvas [

	self beforeRenderingIn: self chart.
	decorations do: [ :e | e beforeRenderingIn: self ].
	decorations do: [ :e | e renderIn: aCanvas ].
	shapes := decorations
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

{ #category : 'accessing - computed' }
RSAbstractPlot >> scalePoint: aPoint [

	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : 'accessing' }
RSAbstractPlot >> shape [

	^ shape
]

{ #category : 'accessing' }
RSAbstractPlot >> shape: aRSShape [

	shape := aRSShape
]

{ #category : 'accessing' }
RSAbstractPlot >> x [

	^ xValues
]

{ #category : 'public' }
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

	self
		assert: [ aCollection isCollection ]
		description: 'Should be a collection'.
	self
		assert: [ aCollection2 isCollection ]
		description: 'Should be a collection'.
	self
		assert: [ aCollection size = aCollection2 size ]
		description: 'The two collections must have the same size'.

	xValues := aCollection.
	yValues := aCollection2
]

{ #category : 'accessing' }
RSAbstractPlot >> xValues [

	^ xValues
]

{ #category : 'accessing' }
RSAbstractPlot >> y [

	^ yValues
]

{ #category : 'public' }
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

{ #category : 'accessing' }
RSAbstractPlot >> yValues [

	^ yValues
]
