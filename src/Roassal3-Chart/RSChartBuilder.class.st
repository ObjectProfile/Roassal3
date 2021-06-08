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
	#name : #RSChartBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'plots',
		'decorations',
		'extents',
		'generator',
		'colors'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
RSChartBuilder >> addDecoration: aDecoration [
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
	^ aDecoration
]

{ #category : #adding }
RSChartBuilder >> addPlot: aPlot [
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
	plots add: aPlot.
	aPlot chart: self
]

{ #category : #'public - plots' }
RSChartBuilder >> barHeights: aCollectionY [
	| res |
	self addPlot: (res := RSBarPlot new 
		x: (1 to: aCollectionY size) 
		y: aCollectionY).
	^ res
]

{ #category : #'public - plots' }
RSChartBuilder >> barWidths: aCollectionX [
	| res |
	self addPlot: (res := RSHorizontalBarPlot new 
		x: aCollectionX
		y: (1 to: aCollectionX size)).
	^ res
]

{ #category : #'accessing - extension' }
RSChartBuilder >> chartExtents [
	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #'accessing - extension' }
RSChartBuilder >> chartExtents: aRSChartExtents [
	extents := aRSChartExtents
]

{ #category : #color }
RSChartBuilder >> colorFor: aRSPlot [ 
	"Return a color for the given plot. Colors are defined as in #defaultPlotColors"
	^ colors scale: aRSPlot
]

{ #category : #accessing }
RSChartBuilder >> colors [
	"Return the palette"
	^ colors
]

{ #category : #accessing }
RSChartBuilder >> colors: someColors [
	"Set the palette to be use to plots"
	colors := someColors
]

{ #category : #accessing }
RSChartBuilder >> decorations [
	"Return the list of decorations used to annotate plots"
	^ decorations
]

{ #category : #defaults }
RSChartBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasControllerInteraction
]

{ #category : #color }
RSChartBuilder >> defaultPlotColors [
	^ NSScale category20
]

{ #category : #'accessing - extension' }
RSChartBuilder >> extent [
	^ self chartExtents extent
]

{ #category : #'accessing - extension' }
RSChartBuilder >> extent: aPoint [
	self chartExtents extent: aPoint
]

{ #category : #visualization }
RSChartBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self build; canvas ]
		
]

{ #category : #initialization }
RSChartBuilder >> initialize [
	super initialize.
	plots := OrderedCollection new.
	self extent: 200 @ 200.
	self initializeDecorations.
	colors := self defaultPlotColors.
]

{ #category : #initialization }
RSChartBuilder >> initializeDecorations [
	decorations := OrderedCollection new.
	self addDecoration: RSChartSpineDecoration new.
]

{ #category : #inspector }
RSChartBuilder >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	self build. 
	^ SpRoassal3InspectorPresenter new
		canvas: self canvas;
		yourself
]

{ #category : #inspector }
RSChartBuilder >> inspectorCanvasContext: aContext [
  
  aContext withoutEvaluator
]

{ #category : #'public - plots' }
RSChartBuilder >> lineX: aCollectionX y: aCollectionY [
	| res |
	self addPlot: (res := RSLinePlot new x: aCollectionX y: aCollectionY).
	^ res
]

{ #category : #'accessing - extension' }
RSChartBuilder >> maxValueX [
	^ self chartExtents maxValueX
		ifNil: [ | res |
			self chartExtents maxValueX: (res := (plots collect: #maxValueX) max).
			res ]
		ifNotNil: [:res | res ].
]

{ #category : #'accessing - extension' }
RSChartBuilder >> maxValueX: aNumber [
	self chartExtents maxValueX: aNumber
]

{ #category : #'accessing - extension' }
RSChartBuilder >> maxValueY [
	^ self chartExtents maxValueY
		ifNil: [ | res |
			self chartExtents maxValueY: (res := (plots collect: #maxValueY) max).
			res ]
		ifNotNil: [:res | res ].
		
]

{ #category : #'accessing - extension' }
RSChartBuilder >> maxValueY: aNumber [
	self chartExtents maxValueY: aNumber
]

{ #category : #'accessing - extension' }
RSChartBuilder >> minValueX [ 
	^ self chartExtents minValueX
		ifNil: [ | res |
			self chartExtents minValueX: (res := (plots collect: #minValueX) min).
			res ]
		ifNotNil: [:res | res ].
]

{ #category : #'accessing - extension' }
RSChartBuilder >> minValueX: aNumber [
	self chartExtents minValueX: aNumber
]

{ #category : #'accessing - extension' }
RSChartBuilder >> minValueY [
	^ self chartExtents minValueY
		ifNil: [ | res |
			self chartExtents minValueY: (res := (plots collect: #minValueY) min).
			res ]
		ifNotNil: [:res | res ].
]

{ #category : #'accessing - extension' }
RSChartBuilder >> minValueY: aNumber [
	self chartExtents minValueY: aNumber
]

{ #category : #'public - configuration' }
RSChartBuilder >> mustInclude0inX [
	"Make sure that the 0 value is in the chart"
	((self minValueX to: self maxValueX) includes: 0) ifTrue: [ ^ self ].
	
	self maxValueX > 0 
		ifTrue: [ self minValueX: 0 ]
		ifFalse: [ self maxValueX: 0 ]
]

{ #category : #'public - configuration' }
RSChartBuilder >> mustInclude0inY [
	"Make sure that the 0 value is in the chart"
	((self minValueY to: self maxValueY) includes: 0) ifTrue: [ ^ self ].
	
	self maxValueY > 0 
		ifTrue: [ self minValueY: 0 ]
		ifFalse: [ self maxValueY: 0 ]
]

{ #category : #accessing }
RSChartBuilder >> niceGenerator [
	"Produce a generator for nice labels. Whether nice labels are used or not is a choice made by the horizontal or vertical ticks."
	^ generator ifNil: [ 
		generator := RSLabelGenerator new.
		generator setLooseFlag: true.
		generator ].
]

{ #category : #accessing }
RSChartBuilder >> numberOfPlots [
	"Return the number of plots contained in the chart"
	^ plots size
]

{ #category : #public }
RSChartBuilder >> openOnce [
	self build.
	^ self canvas openOnce
]

{ #category : #'accessing - extension' }
RSChartBuilder >> padding [
	^ self chartExtents padding
		ifNil: [ | res |
			self chartExtents padding: (res := 0@0).
			res ]
		ifNotNil: [:res | res ].
]

{ #category : #'accessing - extension' }
RSChartBuilder >> padding: aPoint [
	self chartExtents padding: aPoint asPoint
]

{ #category : #accessing }
RSChartBuilder >> plots [
	^ plots
]

{ #category : #building }
RSChartBuilder >> renderDecorationIn: aCanvas [
	decorations do: [ :d | d renderIn: aCanvas ]
]

{ #category : #hooks }
RSChartBuilder >> renderIn: aCanvas [
	decorations, plots do: [ :e | e beforeRenderingIn: self ].
	self renderDecorationIn: aCanvas.
	self renderPlotsIn: aCanvas
]

{ #category : #building }
RSChartBuilder >> renderPlotsIn: aCanvas [
	plots do: [ :p | p renderIn: aCanvas ].
	
]

{ #category : #building }
RSChartBuilder >> show [
	^ self open
]

{ #category : #accessing }
RSChartBuilder >> title: aTitle [
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

{ #category : #'public - scales' }
RSChartBuilder >> xLinear [
	^ self xScale: NSScale linear
]

{ #category : #'public - scales' }
RSChartBuilder >> xLn [
	^ self xScale: NSScale ln
]

{ #category : #'public - scales' }
RSChartBuilder >> xLog [
	^ self xScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChartBuilder >> xRawLog [
	self xScale: NSScale log
]

{ #category : #'public - scales' }
RSChartBuilder >> xScale: aScale [
	plots, decorations do: [ :e | e xScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChartBuilder >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : #decoration }
RSChartBuilder >> xlabel: aTitle [
	"Set a label on the horizontal axis"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSChartBuilder >> xlabel: aTitle offset: aPointOrANumber [
	"Set a label on the horizontal axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; offset: aPointOrANumber)
]

{ #category : #decoration }
RSChartBuilder >> xlabelTop: aTitle [
	"Set a label on the horizontal top axis"
	^ self addDecoration: (RSXLabelDecoration new title: aTitle; above).
]

{ #category : #'public - scales' }
RSChartBuilder >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : #'public - scales' }
RSChartBuilder >> yLn [
	^ self yScale: NSScale ln
]

{ #category : #'public - scales' }
RSChartBuilder >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChartBuilder >> yRawLog [
	"ensure all your data and axis do not contains zero"
	^ self yScale: NSScale log
]

{ #category : #'public - scales' }
RSChartBuilder >> yScale: aScale [
	plots, decorations do: [ :e | e yScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChartBuilder >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : #decoration }
RSChartBuilder >> ylabel: aTitle [
	"Set a label on the vertical axis"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle)
]

{ #category : #decoration }
RSChartBuilder >> ylabel: aTitle offset: aPointOrANumber [
	"Set a label on the vertical axis, using an offset (useful to avoid overlap with axis labels)"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle ; offset: aPointOrANumber)
]

{ #category : #decoration }
RSChartBuilder >> ylabelRight: aTitle [
	"Set a label on the vertical axis"
	^ self addDecoration: (RSYLabelDecoration new title: aTitle; right; yourself)
]
