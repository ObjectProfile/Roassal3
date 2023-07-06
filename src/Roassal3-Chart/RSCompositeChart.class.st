"
<keyClass>
`RSChart` is the main class to build charts.

*Responsibility*: maintain and render plots

*Collaborators*: a chart closely interacts with plots and decorations. 

*Variables*:
- `plots`: the list of plots 
- `extent`: size of the produced chart. Note that this extent is for the area on which plots are draw. It does not comprise ticks and axis titles
- `decorations`: collection of decorations to annotate the chart
- `generator`: nice label generator, useful to have labels that are visually appealing
- `colors`: default color palette

*Example*:
Here is an example that adjust the font size used for the title, and axis labels:

```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; vertical).
c
```
"
Class {
	#name : #RSCompositeChart,
	#superclass : #RSChart,
	#instVars : [
		'elements',
		'extents',
		'colorPalette',
		'spineDecoration',
		'styler'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSCompositeChart >> add: aPlot [
	"Add a plot to the chart.

For example:
```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.
c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c
```
	"
	elements add: aPlot.
	aPlot chart: self.
	aPlot styler: self styler.
	^ aPlot
]

{ #category : #adding }
RSCompositeChart >> addAll: aCollection [

	aCollection do: [ :each | self add: each ]
]

{ #category : #hooks }
RSCompositeChart >> addDecoration: aDecoration [
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

{ #category : #adding }
RSCompositeChart >> addPlot: aPlot [
	"Add a plot to the chart.

For example:
```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.
c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c
```
	"
	elements add: aPlot.
	aPlot chart: self.
	aPlot styler: self styler.
	^ aPlot
]

{ #category : #'public - plots' }
RSCompositeChart >> barHeights: aCollectionY [
	| res |
	self addPlot: (res := RSBarPlot new
		x: (1 to: aCollectionY size)
		y: aCollectionY).
	^ res
]

{ #category : #'public - plots' }
RSCompositeChart >> barWidths: aCollectionX [
	| res |
	self addPlot: (res := RSHorizontalBarPlot new
		x: aCollectionX
		y: (1 to: aCollectionX size)).
	^ res
]

{ #category : #adding }
RSCompositeChart >> chart [

	^ self
]

{ #category : #'accessing - extension' }
RSCompositeChart >> chartExtents [
	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> chartExtents: aRSChartExtents [
	extents := aRSChartExtents
]

{ #category : #color }
RSCompositeChart >> colorFor: aRSPlot [
	"Return a color for the given plot. Colors are defined as in #defaultPlotColors"
	^ colorPalette scale: aRSPlot
]

{ #category : #accessing }
RSCompositeChart >> colors [
	"Return the palette"
	^ colorPalette
]

{ #category : #accessing }
RSCompositeChart >> colors: someColors [
	"Set the palette to be use to plots"
	colorPalette := someColors
]

{ #category : #accessing }
RSCompositeChart >> decorations [

	^ elements select: #isDecoration
]

{ #category : #'accessing - defaults' }
RSCompositeChart >> defaultContainer [
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
RSCompositeChart >> defaultPlotColors [
	^ NSScale category20
]

{ #category : #initialization }
RSCompositeChart >> defaultStyler [
	^ RSChartStyler new
]

{ #category : #accessing }
RSCompositeChart >> elements [

	^ elements
]

{ #category : #'accessing - extension' }
RSCompositeChart >> extent [
	^ self chartExtents extent
]

{ #category : #'accessing - extension' }
RSCompositeChart >> extent: aPoint [
	self chartExtents extent: aPoint
]

{ #category : #accessing }
RSCompositeChart >> horizontalTick [
	^ elements detect: [ :element | element isHorizontalTick ] ifNone: [ nil ]
]

{ #category : #initialization }
RSCompositeChart >> initialize [
	super initialize.
	styler := self defaultStyler.
	elements := OrderedCollection new.
	self extent: 200 @ 200.
	self initializeDecorations.
	colorPalette := self defaultPlotColors
]

{ #category : #initialization }
RSCompositeChart >> initializeDecorations [

	self spineDecoration: RSChartSpineDecoration new.
	self addDecoration: RSHorizontalTick new.
	self addDecoration: RSVerticalTick new
]

{ #category : #inspector }
RSCompositeChart >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	self update.
	^ SpRoassal3InspectorPresenter new
		canvas: self canvas;
		yourself
]

{ #category : #inspector }
RSCompositeChart >> inspectorCanvasContext: aContext [

  aContext withoutEvaluator
]

{ #category : #'public - plots' }
RSCompositeChart >> lineX: aCollectionX y: aCollectionY [
	| res |
	self addPlot: (res := RSLinePlot new x: aCollectionX y: aCollectionY).
	^ res
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxValueX [

	^ self chartExtents maxValueX
		  ifNil: [
			  | res |
			  self chartExtents maxValueX:
				  (res := (self plots collect: #maxValueX) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxValueX: aNumber [
	self chartExtents maxValueX: aNumber
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxValueY [

	^ self chartExtents maxValueY
		  ifNil: [
			  | res |
			  self chartExtents maxValueY:
				  (res := (self plots collect: #maxValueY) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxValueY: aNumber [
	self chartExtents maxValueY: aNumber
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minValueX [

	^ self chartExtents minValueX
		  ifNil: [
			  | res |
			  self chartExtents minValueX:
				  (res := (self plots collect: #minValueX) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minValueX: aNumber [
	self chartExtents minValueX: aNumber
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minValueY [

	^ self chartExtents minValueY
		  ifNil: [
			  | res |
			  self chartExtents minValueY:
				  (res := (self plots collect: #minValueY) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minValueY: aNumber [
	self chartExtents minValueY: aNumber
]

{ #category : #'public - configuration' }
RSCompositeChart >> mustInclude0inX [
	"Make sure that the 0 value is in the chart"
	((self minValueX to: self maxValueX) includes: 0) ifTrue: [ ^ self ].

	self maxValueX > 0
		ifTrue: [ self minValueX: 0 ]
		ifFalse: [ self maxValueX: 0 ]
]

{ #category : #'public - configuration' }
RSCompositeChart >> mustInclude0inY [
	"Make sure that the 0 value is in the chart"
	(self minValueY <= 0 and: [ 0 <= self maxValueY ]) ifTrue: [ ^ self ].

	self maxValueY > 0
		ifTrue: [ self minValueY: 0 ]
		ifFalse: [ self maxValueY: 0 ]
]

{ #category : #accessing }
RSCompositeChart >> numberOfPlots [
	"Return the number of plots contained in the chart"

	^ self plots size
]

{ #category : #public }
RSCompositeChart >> openOnce [

	self build.
	^ self canvas openOnce
]

{ #category : #'accessing - extension' }
RSCompositeChart >> padding [
	^ self chartExtents padding
]

{ #category : #'accessing - extension' }
RSCompositeChart >> padding: aPoint [
	self chartExtents padding: aPoint asPoint
]

{ #category : #accessing }
RSCompositeChart >> plots [

	^ elements select: #isPlot
]

{ #category : #removing }
RSCompositeChart >> removeAllTicks [
	"Remove both horizontal and vertical ticks"

	self removeHorizontalTicks.
	self removeVerticalTicks
]

{ #category : #removing }
RSCompositeChart >> removeHorizontalTicks [
	"Remove horizontal ticks from the chart"

	elements remove: self horizontalTick
]

{ #category : #removing }
RSCompositeChart >> removeVerticalTicks [
	"Remove vertical ticks from the chart"

	elements remove: self verticalTick
]

{ #category : #hooks }
RSCompositeChart >> renderIn: aCanvas [

	^ self subclassResponsibility
]

{ #category : #building }
RSCompositeChart >> show [

	^ self open
]

{ #category : #accessing }
RSCompositeChart >> spine [
	"returns the shape"
	^ self spineDecoration box
]

{ #category : #accessing }
RSCompositeChart >> spineDecoration [
	^ spineDecoration
]

{ #category : #accessing }
RSCompositeChart >> spineDecoration: aRSChartSpineDecoration [
	spineDecoration ifNotNil: [
		elements remove: spineDecoration.
		spineDecoration chart: nil ].
	spineDecoration := aRSChartSpineDecoration.
	elements addFirst: spineDecoration.
	spineDecoration chart: self
]

{ #category : #accessing }
RSCompositeChart >> styler [
	^ styler
]

{ #category : #accessing }
RSCompositeChart >> styler: anRSChartStyler [
	styler := anRSChartStyler.
	elements do: [ :each | each styler: styler ]
]

{ #category : #accessing }
RSCompositeChart >> title: aTitle [
	"Set the title of a chart. For example:

```Smalltalk
c := RSChart new.
c addPlot: (RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt).
c title: 'Square root'.
c
```
	"
	^ self addDecoration: (RSChartTitleDecoration new title: aTitle)
]

{ #category : #'accessing - defaults' }
RSCompositeChart >> updateChart: anEvent [
	| canvas camera |
	camera := anEvent camera.
	canvas := anEvent canvas.
	self extent: canvas extent.
	self update.
	canvas zoomToFit.
]

{ #category : #accessing }
RSCompositeChart >> verticalTick [
	^ elements detect: [ :element | element isVerticalTick ] ifNone: [ nil ]
]

{ #category : #'public - scales' }
RSCompositeChart >> xLinear [
	^ self xScale: NSScale linear
]

{ #category : #'public - scales' }
RSCompositeChart >> xLn [
	^ self xScale: NSScale ln
]

{ #category : #'public - scales' }
RSCompositeChart >> xLog [
	^ self xScale: NSScale symlog
]

{ #category : #'public - scales' }
RSCompositeChart >> xRawLog [
	
	self horizontalTick locator: RSLogLocator new.
	^ self xScale: NSScale log
]

{ #category : #'public - scales' }
RSCompositeChart >> xRawLog: aNumber [
	
	self horizontalTick locator: (RSLogLocator new base: aNumber).
	^ self xScale: (NSLogScale new base: aNumber) 
]

{ #category : #building }
RSCompositeChart >> xScale: aScale [

	super xScale: aScale.
	plots do: [ :e | e xScale: aScale ]
]

{ #category : #'public - scales' }
RSCompositeChart >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : #decoration }
RSCompositeChart >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSCompositeChart >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : #decoration }
RSCompositeChart >> xlabelTop: aTitle [
	"Set a label on the horizontal top axis"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; above)
]

{ #category : #'public - scales' }
RSCompositeChart >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : #'public - scales' }
RSCompositeChart >> yLn [
	^ self yScale: NSScale ln
]

{ #category : #'public - scales' }
RSCompositeChart >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : #'public - scales' }
RSCompositeChart >> yRawLog [
	"ensure all your data and axis do not contains zero"
	self verticalTick locator: RSLogLocator new.
	^ self yScale: NSScale log
]

{ #category : #'public - scales' }
RSCompositeChart >> yRawLog: aNumber [
	
	self verticalTick locator: (RSLogLocator new base: aNumber).
	^ self yScale: (NSLogScale new base: aNumber) 
]

{ #category : #building }
RSCompositeChart >> yScale: aScale [

	super yScale: aScale.
	plots do: [ :e | e yScale: aScale ]
]

{ #category : #'public - scales' }
RSCompositeChart >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : #decoration }
RSCompositeChart >> ylabel: aTitle [
	"Set a label on the vertical axis"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSCompositeChart >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : #decoration }
RSCompositeChart >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
