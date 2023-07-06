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
		'xlabel',
		'xlabelTop',
		'ylabel',
		'ylabelRight',
		'title'
	],
	#category : #'Roassal3-Chart-Core'
}

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
RSChart >> chartExtents [
	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #'accessing - extension' }
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
				self minValueX.
				self maxValueX };
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
				self minValueY.
				self maxValueY };
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

{ #category : #'public - shape' }
RSChart >> extent [

	^ self chartExtents extent
]

{ #category : #'public - shape' }
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

{ #category : #rendering }
RSChart >> maxChartValueX [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> maxChartValueX: aNumber [

	self chartExtents maxValueX: aNumber
]

{ #category : #rendering }
RSChart >> maxChartValueY [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> maxChartValueY: aNumber [

	self chartExtents maxValueY: aNumber
]

{ #category : #rendering }
RSChart >> minChartValueX [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> minChartValueX: aNumber [

	self chartExtents minValueX: aNumber
]

{ #category : #rendering }
RSChart >> minChartValueY [

	^ self subclassResponsibility
]

{ #category : #rendering }
RSChart >> minChartValueY: aNumber [

	self chartExtents minValueY: aNumber
]

{ #category : #'accessing - extension' }
RSChart >> padding [
	^ self chartExtents padding
]

{ #category : #'accessing - extension' }
RSChart >> padding: aPoint [
	self chartExtents padding: aPoint asPoint
]

{ #category : #rendering }
RSChart >> scalePoint: aPoint [

	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
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

	spineDecoration ifNotNil: [ self removeSpine ].
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
RSChart >> xScale: aScale [

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
RSChart >> yScale: aScale [

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
