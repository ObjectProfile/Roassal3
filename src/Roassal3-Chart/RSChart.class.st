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

{ #category : #decorations }
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

{ #category : #accessing }
RSChart >> chartExtents [

	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #rendering }
RSChart >> chartExtents: aRSChartExtents [

	extents := aRSChartExtents
]

{ #category : #private }
RSChart >> colorFor: aRSPlot [
	"Return a color for the given plot. Colors are defined as in #defaultPlotColors"

	^ colorPalette scale: aRSPlot
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
				(self extent x - padding) }
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

{ #category : #decorations }
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

{ #category : #'accessing - defaults' }
RSChart >> defaultPlotColors [

	^ NSScale google20
]

{ #category : #'accessing - defaults' }
RSChart >> defaultStyler [
	^ RSChartStyler new
]

{ #category : #'public - shape' }
RSChart >> extent [

	^ self chartExtents extent
]

{ #category : #'public - shape' }
RSChart >> extent: aPoint [

	self chartExtents extent: aPoint
]

{ #category : #decorations }
RSChart >> horizontalTick [

	^ decorations detect: #isHorizontalTick ifNone: [ nil ]
]

{ #category : #initialization }
RSChart >> initialize [

	super initialize.
	styler := self defaultStyler.
	decorations := OrderedCollection new.
	self extent: 250 @ 200.
	self padding: 15 @ 10.
	self initializeDecorations.
	colorPalette := self defaultPlotColors
]

{ #category : #initialization }
RSChart >> initializeDecorations [

	self spineDecoration: RSChartSpineDecoration new.
	self addDecoration: RSHorizontalTick new.
	self addDecoration: RSVerticalTick new
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

{ #category : #accessing }
RSChart >> maxChartValueX [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> maxChartValueX: aNumber [

	self chartExtents maxValueX: aNumber
]

{ #category : #accessing }
RSChart >> maxChartValueY [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> maxChartValueY: aNumber [

	self chartExtents maxValueY: aNumber
]

{ #category : #accessing }
RSChart >> minChartValueX [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> minChartValueX: aNumber [

	self chartExtents minValueX: aNumber
]

{ #category : #accessing }
RSChart >> minChartValueY [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> minChartValueY: aNumber [

	self chartExtents minValueY: aNumber
]

{ #category : #rendering }
RSChart >> mustInclude0inX [
	"Make sure that the 0 value is in the chart"

	(0 between: self minChartValueX and: self maxChartValueX) ifTrue: [ ^ self ].

	self maxChartValueX > 0
		ifTrue: [ self minChartValueX: 0 ]
		ifFalse: [ self maxChartValueX: 0 ]
]

{ #category : #rendering }
RSChart >> mustInclude0inY [
	"Make sure that the 0 value is in the chart"

	(0 between: self minChartValueY and: self maxChartValueY) ifTrue: [ ^ self ].

	self maxChartValueY > 0
		ifTrue: [ self minChartValueY: 0 ]
		ifFalse: [ self maxChartValueY: 0 ]
]

{ #category : #accessing }
RSChart >> padding [
	^ self chartExtents padding
]

{ #category : #rendering }
RSChart >> padding: aPoint [
	self chartExtents padding: aPoint asPoint
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

{ #category : #rendering }
RSChart >> scalePoint: aPoint [

	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #building }
RSChart >> show [

	^ self open
]

{ #category : #decorations }
RSChart >> spine [
	"returns the shape"
	^ self spineDecoration box
]

{ #category : #decorations }
RSChart >> spineDecoration [
	^ spineDecoration
]

{ #category : #decorations }
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

{ #category : #rendering }
RSChart >> styler: anRSChartStyler [

	styler := anRSChartStyler.
	decorations do: [ :each | each styler: styler ]
]

{ #category : #decorations }
RSChart >> title [

 ^ title
]

{ #category : #decorations }
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

{ #category : #rendering }
RSChart >> updateChart: anEvent [
	| canvas camera |
	camera := anEvent camera.
	canvas := anEvent canvas.
	self extent: canvas extent.
	self update.
	canvas zoomToFit.
]

{ #category : #decorations }
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

{ #category : #decorations }
RSChart >> xlabel [
	
	^ xlabel
]

{ #category : #decorations }
RSChart >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	xlabel := aTitle.
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #decorations }
RSChart >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : #decorations }
RSChart >> xlabelTop [
	
	^ xlabelTop
]

{ #category : #decorations }
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

{ #category : #decorations }
RSChart >> ylabel [
	
	^ ylabel
]

{ #category : #decorations }
RSChart >> ylabel: aTitle [
	"Set a label on the vertical axis"
	ylabel := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : #decorations }
RSChart >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : #decorations }
RSChart >> ylabelRight [

	^ ylabelRight
]

{ #category : #decorations }
RSChart >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	ylabelRight := aTitle.
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
