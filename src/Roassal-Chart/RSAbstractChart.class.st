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
	#name : 'RSAbstractChart',
	#superclass : 'RSBuilder',
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
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'public - plots' }
RSAbstractChart class >> barHeights: aCollectionY [

	^ RSBarPlot new x: (1 to: aCollectionY size) y: aCollectionY
]

{ #category : 'public - plots' }
RSAbstractChart class >> barWidths: aCollectionX [

	^ RSHorizontalBarPlot new
		  x: aCollectionX
		  y: (1 to: aCollectionX size)
]

{ #category : 'testing' }
RSAbstractChart class >> isAbstract [

	^ self == RSAbstractChart
]

{ #category : 'public - plots' }
RSAbstractChart class >> lineX: aCollectionX y: aCollectionY [

	^ RSLinePlot new x: aCollectionX y: aCollectionY
]

{ #category : 'adding' }
RSAbstractChart >> addDecoration: aDecoration [
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

{ #category : 'accessing' }
RSAbstractChart >> chart [

	^ self subclassResponsibility
]

{ #category : 'accessing - extension' }
RSAbstractChart >> chartExtents [

	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : 'accessing - extension' }
RSAbstractChart >> chartExtents: aRSChartExtents [

	extents := aRSChartExtents
]

{ #category : 'color' }
RSAbstractChart >> colorFor: aRSPlot [
	"Return a color for the given plot. Colors are defined as in #defaultPlotColors"

	^ colorPalette scale: aRSPlot
]

{ #category : 'accessing' }
RSAbstractChart >> colors [

	^ colorPalette
]

{ #category : 'accessing' }
RSAbstractChart >> colors: someColors [

	colorPalette := someColors
]

{ #category : 'rendering' }
RSAbstractChart >> createXScale [

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

{ #category : 'rendering' }
RSAbstractChart >> createYScale [

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

{ #category : 'accessing' }
RSAbstractChart >> decorations [
	"Return the list of decorations used to annotate plots"

	^ decorations
]

{ #category : 'accessing - defaults' }
RSAbstractChart >> defaultContainer [
	^ RSCanvas new
		in: [ :canvas | canvas inspectorContext interactionsToBeRegistered first noPushFront ];
		addInteraction: (RSCanvasController new
			in: [ :controller |
				controller zoomToFitInteraction useZoomToFitOnExtentChanged.
				controller configuration	maxScale: 20.
				 ];
			yourself);
		yourself
]

{ #category : 'accessing - color' }
RSAbstractChart >> defaultPlotColors [

	^ NSScale category20
]

{ #category : 'accessing - defaults' }
RSAbstractChart >> defaultStyler [
	^ RSChartStyler new
]

{ #category : 'accessing - extension' }
RSAbstractChart >> extent [

	^ self chartExtents extent
]

{ #category : 'accessing - extension' }
RSAbstractChart >> extent: aPoint [

	self chartExtents extent: aPoint
]

{ #category : 'accessing' }
RSAbstractChart >> horizontalTick [

	^ decorations detect: #isHorizontalTick ifNone: [ nil ]
]

{ #category : 'initialization' }
RSAbstractChart >> initialize [

	super initialize.
	styler := self defaultStyler.
	decorations := OrderedCollection new.
	self initializeRenderOptions.
	self initializeDecorations.
	colorPalette := self defaultPlotColors
]

{ #category : 'initialization' }
RSAbstractChart >> initializeDecorations [
	"adds the basis decorations to the chart"

	self spineDecoration: RSChartSpineDecoration new.
	self addDecoration: RSHorizontalTick new.
	self addDecoration: RSVerticalTick new
]

{ #category : 'initialization' }
RSAbstractChart >> initializeRenderOptions [
	"extent is 250@200 to have a bit larger chart, and a small padding not to make plots
	overlap with spine decoration, for better visibility"

	self extent: 250 @ 200.
	self padding: 5 @ 5
]

{ #category : 'inspector' }
RSAbstractChart >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	self update.
	^ SpRoassalInspectorPresenter new
		canvas: self canvas;
		yourself
]

{ #category : 'inspector' }
RSAbstractChart >> inspectorCanvasContext: aContext [

  aContext withoutEvaluator
]

{ #category : 'accessing - extension' }
RSAbstractChart >> maxChartValueX [
	"the maximum value displayed on the x-axis of the chart"

	^ self subclassResponsibility
]

{ #category : 'accessing - extension' }
RSAbstractChart >> maxChartValueX: aNumber [
	"sets the maximum value displayed on the x-axis of the chart"

	self chartExtents maxValueX: aNumber
]

{ #category : 'accessing - extension' }
RSAbstractChart >> maxChartValueY [
	"the maximum value displayed on the y-axis of the chart"

	^ self subclassResponsibility
]

{ #category : 'accessing - extension' }
RSAbstractChart >> maxChartValueY: aNumber [
	"sets the maximum value displayed on the y-axis of the chart"

	self chartExtents maxValueY: aNumber
]

{ #category : 'accessing - extension' }
RSAbstractChart >> minChartValueX [
	"the minimum value displayed on the x-axis of the chart"

	^ self subclassResponsibility
]

{ #category : 'accessing - extension' }
RSAbstractChart >> minChartValueX: aNumber [
	"sets the minimum value displayed on the x-axis of the chart"

	self chartExtents minValueX: aNumber
]

{ #category : 'accessing - extension' }
RSAbstractChart >> minChartValueY [
	"the minimum value displayed on the y-axis of the chart"

	^ self subclassResponsibility
]

{ #category : 'accessing - extension' }
RSAbstractChart >> minChartValueY: aNumber [
	"sets the minimum value displayed on the y-axis of the chart"

	self chartExtents minValueY: aNumber
]

{ #category : 'public - configuration' }
RSAbstractChart >> mustInclude0inX [
	"Make sure that the 0 value is in the x-axis of the chart"

	(0 between: self minChartValueX and: self maxChartValueX) ifTrue: [ ^ self ].

	self maxChartValueX > 0
		ifTrue: [ self minChartValueX: 0 ]
		ifFalse: [ self maxChartValueX: 0 ]
]

{ #category : 'public - configuration' }
RSAbstractChart >> mustInclude0inY [
	"Make sure that the 0 value is in the y-axis of the chart"

	(0 between: self minChartValueY and: self maxChartValueY) ifTrue: [ ^ self ].

	self maxChartValueY > 0
		ifTrue: [ self minChartValueY: 0 ]
		ifFalse: [ self maxChartValueY: 0 ]
]

{ #category : 'accessing - extension' }
RSAbstractChart >> padding [
	"the space between the spine and the plots"

	^ self chartExtents padding
]

{ #category : 'accessing - extension' }
RSAbstractChart >> padding: aPoint [
	"adds a space corresponding to aPoint between the spine and plots"

	self chartExtents padding: aPoint asPoint
]

{ #category : 'accessing' }
RSAbstractChart >> plots [

	^ self
]

{ #category : 'removing' }
RSAbstractChart >> removeAllTicks [
	"Remove both horizontal and vertical ticks"

	self removeHorizontalTicks.
	self removeVerticalTicks
]

{ #category : 'removing' }
RSAbstractChart >> removeHorizontalTicks [
	"Remove horizontal ticks from the chart"

	decorations remove: self horizontalTick
]

{ #category : 'removing' }
RSAbstractChart >> removeVerticalTicks [
	"Remove vertical ticks from the chart"

	decorations remove: self verticalTick
]

{ #category : 'building' }
RSAbstractChart >> show [

	^ self open
]

{ #category : 'accessing' }
RSAbstractChart >> spine [
	"returns the shape"
	^ self spineDecoration box
]

{ #category : 'accessing' }
RSAbstractChart >> spineDecoration [
	^ spineDecoration
]

{ #category : 'accessing' }
RSAbstractChart >> spineDecoration: aRSChartSpineDecoration [

	spineDecoration ifNotNil: [
		decorations remove: spineDecoration.
		spineDecoration chart: nil ].
	spineDecoration := aRSChartSpineDecoration.
	decorations addFirst: spineDecoration.
	aRSChartSpineDecoration chart: self
]

{ #category : 'accessing' }
RSAbstractChart >> styler [

	^ styler
]

{ #category : 'accessing' }
RSAbstractChart >> styler: anRSChartStyler [

	styler := anRSChartStyler.
	decorations do: [ :each | each styler: styler ]
]

{ #category : 'accessing' }
RSAbstractChart >> title [

 ^ title
]

{ #category : 'accessing' }
RSAbstractChart >> title: aTitle [
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

{ #category : 'updating' }
RSAbstractChart >> updateChart: anEvent [
	| canvas camera |
	camera := anEvent camera.
	canvas := anEvent canvas.
	self extent: canvas extent.
	self update.
	canvas zoomToFit
]

{ #category : 'accessing' }
RSAbstractChart >> verticalTick [

	^ decorations detect: #isVerticalTick ifNone: [ nil ]
]

{ #category : 'public - scales' }
RSAbstractChart >> xLinear [

	^ self xScale: NSScale linear
]

{ #category : 'public - scales' }
RSAbstractChart >> xLn [

	^ self xScale: NSScale ln
]

{ #category : 'public - scales' }
RSAbstractChart >> xLog [

	^ self xScale: NSScale symlog
]

{ #category : 'public - scales' }
RSAbstractChart >> xRawLog [
	"ensure all your data and axis do not contains zero"

	self horizontalTick locator: RSLogLocator new.
	^ self xScale: NSScale log
]

{ #category : 'public - scales' }
RSAbstractChart >> xRawLog: aNumber [

	self horizontalTick locator: (RSLogLocator new base: aNumber).
	^ self xScale: (NSLogScale new base: aNumber)
]

{ #category : 'public - scales' }
RSAbstractChart >> xScale [

	^ xScale
]

{ #category : 'public - scales' }
RSAbstractChart >> xScale: aScale [

	xScale := aScale.
	decorations do: [ :e | e xScale: aScale ].
	^ aScale
]

{ #category : 'public - scales' }
RSAbstractChart >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : 'decoration' }
RSAbstractChart >> xTickLabels: aCollection [
	self horizontalTick fromNames: aCollection
]

{ #category : 'decoration' }
RSAbstractChart >> xTicks: collectionOfNumbers labels: aCollection [
	self horizontalTick ticks: collectionOfNumbers labels: aCollection
]

{ #category : 'decoration' }
RSAbstractChart >> xlabel [

	^ xlabel
]

{ #category : 'decoration' }
RSAbstractChart >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	xlabel := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : 'decoration' }
RSAbstractChart >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : 'decoration' }
RSAbstractChart >> xlabelTop [

	^ xlabelTop
]

{ #category : 'decoration' }
RSAbstractChart >> xlabelTop: aTitle [
	"Set a label on the horizontal top axis"
	xlabelTop := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; above)
]

{ #category : 'public - scales' }
RSAbstractChart >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : 'public - scales' }
RSAbstractChart >> yLn [
	^ self yScale: NSScale ln
]

{ #category : 'public - scales' }
RSAbstractChart >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : 'public - scales' }
RSAbstractChart >> yRawLog [
	"ensure all your data and axis do not contains zero"
	self verticalTick locator: RSLogLocator new.
	^ self yScale: NSScale log
]

{ #category : 'public - scales' }
RSAbstractChart >> yRawLog: aNumber [

	self verticalTick locator: (RSLogLocator new base: aNumber).
	^ self yScale: (NSLogScale new base: aNumber)
]

{ #category : 'public - scales' }
RSAbstractChart >> yScale [

	^ yScale
]

{ #category : 'public - scales' }
RSAbstractChart >> yScale: aScale [

	yScale := aScale.
	decorations do: [ :e | e yScale: aScale ].
	^ aScale
]

{ #category : 'public - scales' }
RSAbstractChart >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : 'decoration' }
RSAbstractChart >> yTickLabels: aCollection [
	self verticalTick fromNames: aCollection
]

{ #category : 'decoration' }
RSAbstractChart >> yTicks: collectionOfNumbers labels: aCollection [
	self verticalTick ticks: collectionOfNumbers labels: aCollection
]

{ #category : 'decoration' }
RSAbstractChart >> ylabel [

	^ ylabel
]

{ #category : 'decoration' }
RSAbstractChart >> ylabel: aTitle [
	"Set a label on the vertical axis"
	ylabel := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : 'decoration' }
RSAbstractChart >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : 'decoration' }
RSAbstractChart >> ylabelRight [

	^ ylabelRight
]

{ #category : 'decoration' }
RSAbstractChart >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	ylabelRight := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
