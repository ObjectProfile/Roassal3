"
TODO
"
Class {
	#name : #RSAbstractPlot,
	#superclass : #RSAbstractChartPlot,
	#instVars : [
		'xValues',
		'yValues'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSAbstractPlot >> addDecoration: aDecoration [
	"Add a decoration to the chart

For example:
```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.
c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSHorizontalTick new).
c addDecoration: (RSVerticalTick new).
c
```"
	elements add: aDecoration.
	aDecoration chart: self.
	aDecoration styler: self styler.
	^ aDecoration
]

{ #category : #'public - plots' }
RSAbstractPlot >> barHeights: aCollectionY [
	| res |
	self addPlot: (res := RSBarPlot new
		x: (1 to: aCollectionY size)
		y: aCollectionY).
	^ res
]

{ #category : #'public - plots' }
RSAbstractPlot >> barWidths: aCollectionX [
	| res |
	self addPlot: (res := RSHorizontalBarPlot new
		x: aCollectionX
		y: (1 to: aCollectionX size)).
	^ res
]

{ #category : #rendering }
RSAbstractPlot >> beforeRenderingIn: aChart [

	self createXScale.
	self createYScale
]

{ #category : #accessing }
RSAbstractPlot >> chart [

	^ chart
]

{ #category : #accessing }
RSAbstractPlot >> chart: aChart [

	chart := aChart
]

{ #category : #testing }
RSAbstractPlot >> checkAssertion [

	self
		assert: [ xValues notNil and: [ yValues notNil ] ]
		description: 'X and Y values must be added'.
	self
		assert: [ xValues size = yValues size ]
		description:
		'X and Y values have not the same size, and they should'
]

{ #category : #accessing }
RSAbstractPlot >> decorations [
	"Return the list of decorations used to annotate plots"
	^ elements select: #isDecoration
]

{ #category : #'accessing - defaults' }
RSAbstractPlot >> defaultContainer [
	^ RSCanvas new
		"when: RSExtentChangedEvent send:#updateChart: to: self;"
		addInteraction: (RSCanvasController new
			in: [ :controller |
				controller zoomToFitInteraction useZoomToFitOnExtentChanged.
				controller configuration	maxScale: 20.
				 ];
			yourself);
		yourself
]

{ #category : #color }
RSAbstractPlot >> defaultPlotColors [
	^ NSScale category20
]

{ #category : #initialization }
RSAbstractPlot >> defaultShape [

	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractPlot >> defaultStyler [
	^ RSChartStyler new
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
RSAbstractPlot >> elements [
	^ elements
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> extent [
	^ self chartExtents extent
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> extent: aPoint [
	self chartExtents extent: aPoint
]

{ #category : #accessing }
RSAbstractPlot >> horizontalTick [
	^ elements detect: [ :element | element isHorizontalTick ] ifNone: [ nil ]
]

{ #category : #inspector }
RSAbstractPlot >> initialize [

	super initialize.
	shape := self defaultShape
]

{ #category : #initialization }
RSAbstractPlot >> initializeDecorations [

	self spineDecoration: RSChartSpineDecoration new.
	"self addDecoration: RSHorizontalTick new.
	self addDecoration: RSVerticalTick new"
]

{ #category : #inspector }
RSAbstractPlot >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	self update.
	^ SpRoassal3InspectorPresenter new
		canvas: self canvas;
		yourself
]

{ #category : #inspector }
RSAbstractPlot >> inspectorCanvasContext: aContext [

  aContext withoutEvaluator
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
RSAbstractPlot >> isPlot [

	^ true
]

{ #category : #testing }
RSAbstractPlot >> isPointWellDefined: aPoint [
	"Indicate whether the point deserves to be displayed"

	^ (aPoint x isInfinite not and: [ aPoint y isInfinite not ]) and: [
		  aPoint x isNaN not and: [ aPoint y isNaN not ] ]
]

{ #category : #testing }
RSAbstractPlot >> isScatterPlot [

	^ false
]

{ #category : #testing }
RSAbstractPlot >> isVerticalBarPlot [

	^ false
]

{ #category : #'public - plots' }
RSAbstractPlot >> lineX: aCollectionX y: aCollectionY [
	| res |
	self addPlot: (res := RSLinePlot new x: aCollectionX y: aCollectionY).
	^ res
]

{ #category : #rendering }
RSAbstractPlot >> maxValueX [
	"Return the maximum X value of the plot, excluding NaN and infinite"

	^ self definedValuesX max
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> maxValueX: aNumber [
	self chartExtents maxValueX: aNumber
]

{ #category : #rendering }
RSAbstractPlot >> maxValueY [
	"Return the maximum Y value of the plot, excluding NaN and infinite"

	^ self definedValuesY max
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> maxValueY: aNumber [
	self chartExtents maxValueY: aNumber
]

{ #category : #rendering }
RSAbstractPlot >> minValueX [
	"Return the minimum X value of the plot, excluding NaN and infinite"

	^ self definedValuesX min
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> minValueX: aNumber [
	self chartExtents minValueX: aNumber
]

{ #category : #rendering }
RSAbstractPlot >> minValueY [
	"Return the minimum Y value of the plot, excluding NaN and infinite"

	^ self definedValuesY min
]

{ #category : #'accessing - extension' }
RSAbstractPlot >> minValueY: aNumber [
	self chartExtents minValueY: aNumber
]

{ #category : #accessing }
RSAbstractPlot >> numberOfPlots [

	^ 1
]

{ #category : #rendering }
RSAbstractPlot >> renderIn: aCanvas [

	self beforeRenderingIn: self.
	self decorations do: [ :e |
		e beforeRenderingIn: self.
		e renderIn: aCanvas ].
	shapes := decorations
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

{ #category : #accessing }
RSAbstractPlot >> shape [

	^ shape
]

{ #category : #accessing }
RSAbstractPlot >> shape: aRSShape [

	shape := aRSShape
]

{ #category : #accessing }
RSAbstractPlot >> spine [
	"returns the shape"
	^ self spineDecoration box
]

{ #category : #accessing }
RSAbstractPlot >> spineDecoration [
	^ spineDecoration
]

{ #category : #accessing }
RSAbstractPlot >> spineDecoration: aRSChartSpineDecoration [

	spineDecoration ifNotNil: [ self removeSpine ].
	spineDecoration := aRSChartSpineDecoration.
	decorations addFirst: spineDecoration.
	aRSChartSpineDecoration chart: self
]

{ #category : #accessing }
RSAbstractPlot >> styler: anRSChartStyler [
	styler := anRSChartStyler.
	elements do: [ :each | each styler: styler ]
]

{ #category : #accessing }
RSAbstractPlot >> title [

 ^ title
]

{ #category : #accessing }
RSAbstractPlot >> title: aTitle [
	"Set the title of a chart. For example:

```Smalltalk
c := RSChart new.
c addPlot: (RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt).
c title: 'Square root'.
c
```
	"
	title := aTitle.
	^ self addDecoration: (RSChartTitleDecoration new title: aTitle)
]

{ #category : #'accessing - defaults' }
RSAbstractPlot >> updateChart: anEvent [
	| canvas camera |
	camera := anEvent camera.
	canvas := anEvent canvas.
	self extent: canvas extent.
	self update.
	canvas zoomToFit.
]

{ #category : #accessing }
RSAbstractPlot >> verticalTick [
	^ elements detect: [ :element | element isVerticalTick ] ifNone: [ nil ]
]

{ #category : #accessing }
RSAbstractPlot >> x [

	^ xValues
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

{ #category : #'public - scales' }
RSAbstractPlot >> xScale: aScale [
	elements do: [ :e | e xScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSAbstractPlot >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : #accessing }
RSAbstractPlot >> xValues [

	^ xValues
]

{ #category : #decoration }
RSAbstractPlot >> xlabel [
	
	^ xlabel
]

{ #category : #decoration }
RSAbstractPlot >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	xlabel := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSAbstractPlot >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : #decoration }
RSAbstractPlot >> xlabelTop [
	
	^ xlabelTop
]

{ #category : #decoration }
RSAbstractPlot >> xlabelTop: aTitle [
	"Set a label on the horizontal top axis"
	xlabelTop := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; above)
]

{ #category : #accessing }
RSAbstractPlot >> y [

	^ yValues
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

{ #category : #'public - scales' }
RSAbstractPlot >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : #'public - scales' }
RSAbstractPlot >> yLn [
	^ self yScale: NSScale ln
]

{ #category : #'public - scales' }
RSAbstractPlot >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : #'public - scales' }
RSAbstractPlot >> yRawLog [
	"ensure all your data and axis do not contains zero"
	self verticalTick locator: RSLogLocator new.
	^ self yScale: NSScale log
]

{ #category : #'public - scales' }
RSAbstractPlot >> yRawLog: aNumber [
	
	self verticalTick locator: (RSLogLocator new base: aNumber).
	^ self yScale: (NSLogScale new base: aNumber) 
]

{ #category : #'public - scales' }
RSAbstractPlot >> yScale: aScale [
	elements do: [ :e | e yScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSAbstractPlot >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : #accessing }
RSAbstractPlot >> yValues [

	^ yValues
]

{ #category : #decoration }
RSAbstractPlot >> ylabel [
	
	^ ylabel
]

{ #category : #decoration }
RSAbstractPlot >> ylabel: aTitle [
	"Set a label on the vertical axis"
	ylabel := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSAbstractPlot >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : #decoration }
RSAbstractPlot >> ylabelRight [

	^ ylabelRight
]

{ #category : #decoration }
RSAbstractPlot >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	ylabelRight := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
