"
<keyClass>
`RSChart` is the abstract class that encompass plots and charts.

*Responsibility*: maintain and render plots.

*Collaborators*: a chart closely interacts with plots and decorations. 

*Variables*:
- xScale:	 the scale of the x-axis
- yScale:	 the scale of the y-axis
- extents: the size of the chart
- styler:	 contains information for the chart like its decorations color or text size
- colorPalette: the colors used to render plots
- decorations: the collection of all decorations (spine, ticks, labels, etc)
- spineDecoration: the spine decoration of the chart
- title: the tilte of the chart
- xlabel: the text used as label for the x-axis
- xlabelTop: the text used as label for the top x-axis
- ylabel: the text used as label for the y-axis
- ylabelRight: the text used as label for the right y-axis

"
Class {
	#name : #RSChart,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'xScale',
		'yScale',
		'extents',
		'styler',
		'colorPalette',
		'decorations',
		'spineDecoration',
		'title',
		'xlabel',
		'xlabelTop',
		'ylabel',
		'ylabelRight'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #'public - plots' }
RSChart class >> barHeights: aCollectionY [

	^ RSBarPlot new x: (1 to: aCollectionY size) y: aCollectionY
]

{ #category : #'public - plots' }
RSChart class >> barWidths: aCollectionX [

	^ RSHorizontalBarPlot new
		  x: aCollectionX
		  y: (1 to: aCollectionX size)
]

{ #category : #testing }
RSChart class >> isAbstract [

	^ self == RSChart
]

{ #category : #'public - plots' }
RSChart class >> lineX: aCollectionX y: aCollectionY [

	^ RSLinePlot new x: aCollectionX y: aCollectionY
]

{ #category : #adding }
RSChart >> addDecoration: aDecoration [
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

	decorations add: aDecoration.
	aDecoration chart: self.
	aDecoration styler: self styler.
	^ aDecoration
]

{ #category : #accessing }
RSChart >> chart [

	^ self subclassResponsibility
]

{ #category : #'accessing - extension' }
RSChart >> chartExtents [

	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #'accessing - extension' }
RSChart >> chartExtents: aRSChartExtents [

	extents := aRSChartExtents
]

{ #category : #color }
RSChart >> colorFor: aRSPlot [
	"Return a color for the given plot. Colors are defined as in #defaultPlotColors"

	^ colorPalette scale: aRSPlot
]

{ #category : #accessing }
RSChart >> colors [

	^ colorPalette
]

{ #category : #accessing }
RSChart >> colors: someColors [

	colorPalette := someColors
]

{ #category : #rendering }
RSChart >> createXScale [

	| padding |
	xScale ifNil: [ xScale := NSScale linear ].
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := self padding x.
	xScale
		domain: {
				self chart minChartValueX.
				self chart maxChartValueX };
		range: {
				(0 + padding).
				(self chart extent x - padding) }
]

{ #category : #rendering }
RSChart >> createYScale [

	| padding |
	yScale ifNil: [ yScale := NSScale linear ].
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := self padding y.
	yScale
		domain: {
				self chart minChartValueY.
				self chart maxChartValueY };
		range: {
				(0 - padding).
				(self extent y negated + padding) }
]

{ #category : #accessing }
RSChart >> decorations [
	"Return the list of decorations used to annotate plots"

	^ decorations
]

{ #category : #'accessing - defaults' }
RSChart >> defaultContainer [
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
RSChart >> defaultPlotColors [

	^ NSScale google20
]

{ #category : #initialization }
RSChart >> defaultStyler [
	^ RSChartStyler new
]

{ #category : #'accessing - extension' }
RSChart >> extent [

	^ self chartExtents extent
]

{ #category : #'accessing - extension' }
RSChart >> extent: aPoint [

	self chartExtents extent: aPoint
]

{ #category : #accessing }
RSChart >> horizontalTick [

	^ decorations detect: #isHorizontalTick ifNone: [ nil ]
]

{ #category : #initialization }
RSChart >> initialize [

	super initialize.
	styler := self defaultStyler.
	decorations := OrderedCollection new.
	self initializeRenderOptions.
	self initializeDecorations.
	colorPalette := self defaultPlotColors
]

{ #category : #initialization }
RSChart >> initializeDecorations [
	"adds the basis decorations to the chart"

	self spineDecoration: RSChartSpineDecoration new.
	self addDecoration: RSHorizontalTick new.
	self addDecoration: RSVerticalTick new
]

{ #category : #initialization }
RSChart >> initializeRenderOptions [
	"extent is 250@200 to have a bit larger chart, and a small padding not to make plots
	overlap with spine decoration, for better visibility"

	self extent: 250 @ 200.
	self padding: 5 @ 5
]

{ #category : #inspector }
RSChart >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	self update.
	^ SpRoassal3InspectorPresenter new
		canvas: self canvas;
		yourself
]

{ #category : #inspector }
RSChart >> inspectorCanvasContext: aContext [

  aContext withoutEvaluator
]

{ #category : #'accessing - extension' }
RSChart >> maxChartValueX [
	"the maximum value displayed on the x-axis of the chart"

	^ self subclassResponsibility
]

{ #category : #'accessing - extension' }
RSChart >> maxChartValueX: aNumber [
	"sets the maximum value displayed on the x-axis of the chart"

	self chartExtents maxValueX: aNumber
]

{ #category : #'accessing - extension' }
RSChart >> maxChartValueY [
	"the maximum value displayed on the y-axis of the chart"

	^ self subclassResponsibility
]

{ #category : #'accessing - extension' }
RSChart >> maxChartValueY: aNumber [
	"sets the maximum value displayed on the y-axis of the chart"

	self chartExtents maxValueY: aNumber
]

{ #category : #'accessing - extension' }
RSChart >> minChartValueX [
	"the minimum value displayed on the x-axis of the chart"

	^ self subclassResponsibility
]

{ #category : #'accessing - extension' }
RSChart >> minChartValueX: aNumber [
	"sets the minimum value displayed on the x-axis of the chart"

	self chartExtents minValueX: aNumber
]

{ #category : #'accessing - extension' }
RSChart >> minChartValueY [
	"the minimum value displayed on the y-axis of the chart"

	^ self subclassResponsibility
]

{ #category : #'accessing - extension' }
RSChart >> minChartValueY: aNumber [
	"sets the minimum value displayed on the y-axis of the chart"

	self chartExtents minValueY: aNumber
]

{ #category : #'public - configuration' }
RSChart >> mustInclude0inX [
	"Make sure that the 0 value is in the x-axis of the chart"

	(0 between: self minChartValueX and: self maxChartValueX) ifTrue: [ ^ self ].

	self maxChartValueX > 0
		ifTrue: [ self minChartValueX: 0 ]
		ifFalse: [ self maxChartValueX: 0 ]
]

{ #category : #'public - configuration' }
RSChart >> mustInclude0inY [
	"Make sure that the 0 value is in the y-axis of the chart"

	(0 between: self minChartValueY and: self maxChartValueY) ifTrue: [ ^ self ].

	self maxChartValueY > 0
		ifTrue: [ self minChartValueY: 0 ]
		ifFalse: [ self maxChartValueY: 0 ]
]

{ #category : #'accessing - extension' }
RSChart >> padding [
	"the space between the spine and the plots"

	^ self chartExtents padding
]

{ #category : #'accessing - extension' }
RSChart >> padding: aPoint [
	"adds a space corresponding to aPoint between the spine and plots"

	self chartExtents padding: aPoint asPoint
]

{ #category : #accessing }
RSChart >> plots [

	^ self
]

{ #category : #removing }
RSChart >> removeAllTicks [
	"Remove both horizontal and vertical ticks"

	self removeHorizontalTicks.
	self removeVerticalTicks
]

{ #category : #removing }
RSChart >> removeHorizontalTicks [
	"Remove horizontal ticks from the chart"

	decorations remove: self horizontalTick
]

{ #category : #removing }
RSChart >> removeVerticalTicks [
	"Remove vertical ticks from the chart"

	decorations remove: self verticalTick
]

{ #category : #'accessing - computed' }
RSChart >> scalePoint: aPoint [

	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #building }
RSChart >> show [

	^ self open
]

{ #category : #accessing }
RSChart >> spine [
	"returns the shape"
	^ self spineDecoration box
]

{ #category : #accessing }
RSChart >> spineDecoration [
	^ spineDecoration
]

{ #category : #accessing }
RSChart >> spineDecoration: aRSChartSpineDecoration [

	spineDecoration ifNotNil: [
		decorations remove: spineDecoration.
		spineDecoration chart: nil ].
	spineDecoration := aRSChartSpineDecoration.
	decorations addFirst: spineDecoration.
	aRSChartSpineDecoration chart: self
]

{ #category : #accessing }
RSChart >> styler [

	^ styler
]

{ #category : #accessing }
RSChart >> styler: anRSChartStyler [

	styler := anRSChartStyler.
	decorations do: [ :each | each styler: styler ]
]

{ #category : #accessing }
RSChart >> title [

 ^ title
]

{ #category : #accessing }
RSChart >> title: aTitle [
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
RSChart >> updateChart: anEvent [
	| canvas camera |
	camera := anEvent camera.
	canvas := anEvent canvas.
	self extent: canvas extent.
	self update.
	canvas zoomToFit.
]

{ #category : #accessing }
RSChart >> verticalTick [

	^ decorations detect: #isVerticalTick ifNone: [ nil ]
]

{ #category : #'public - scales' }
RSChart >> xLinear [

	^ self xScale: NSScale linear
]

{ #category : #'public - scales' }
RSChart >> xLn [

	^ self xScale: NSScale ln
]

{ #category : #'public - scales' }
RSChart >> xLog [

	^ self xScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChart >> xRawLog [
	"ensure all your data and axis do not contains zero"

	self horizontalTick locator: RSLogLocator new.
	^ self xScale: NSScale log
]

{ #category : #'public - scales' }
RSChart >> xRawLog: aNumber [

	self horizontalTick locator: (RSLogLocator new base: aNumber).
	^ self xScale: (NSLogScale new base: aNumber)
]

{ #category : #'public - scales' }
RSChart >> xScale [

	^ xScale
]

{ #category : #'public - scales' }
RSChart >> xScale: aScale [

	xScale := aScale.
	decorations do: [ :e | e xScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChart >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : #decoration }
RSChart >> xlabel [
	
	^ xlabel
]

{ #category : #decoration }
RSChart >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	xlabel := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSChart >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : #decoration }
RSChart >> xlabelTop [
	
	^ xlabelTop
]

{ #category : #decoration }
RSChart >> xlabelTop: aTitle [
	"Set a label on the horizontal top axis"
	xlabelTop := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; above)
]

{ #category : #'public - scales' }
RSChart >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : #'public - scales' }
RSChart >> yLn [
	^ self yScale: NSScale ln
]

{ #category : #'public - scales' }
RSChart >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChart >> yRawLog [
	"ensure all your data and axis do not contains zero"
	self verticalTick locator: RSLogLocator new.
	^ self yScale: NSScale log
]

{ #category : #'public - scales' }
RSChart >> yRawLog: aNumber [
	
	self verticalTick locator: (RSLogLocator new base: aNumber).
	^ self yScale: (NSLogScale new base: aNumber) 
]

{ #category : #'public - scales' }
RSChart >> yScale [

	^ yScale
]

{ #category : #'public - scales' }
RSChart >> yScale: aScale [

	yScale := aScale.
	decorations do: [ :e | e yScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChart >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : #decoration }
RSChart >> ylabel [
	
	^ ylabel
]

{ #category : #decoration }
RSChart >> ylabel: aTitle [
	"Set a label on the vertical axis"
	ylabel := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSChart >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : #decoration }
RSChart >> ylabelRight [

	^ ylabelRight
]

{ #category : #decoration }
RSChart >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	ylabelRight := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
