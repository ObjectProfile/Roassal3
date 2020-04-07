Class {
	#name : #RSChart,
	#superclass : #Object,
	#instVars : [
		'plots',
		'canvas',
		'width',
		'extent',
		'plot',
		'decorations',
		'maxValueX',
		'maxValueY',
		'minValueX',
		'minValueY',
		'generator',
		'colors'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #adding }
RSChart >> addDecoration: aDecoration [
	"Maybe use a double dispatch"
	decorations add: aDecoration.
	aDecoration chart: self
]

{ #category : #adding }
RSChart >> addPlot: aPlot [
	plots add: aPlot.
	aPlot chart: self
]

{ #category : #building }
RSChart >> build [
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	decorations, plots do: [ :e | e beforeRenderingIn: self ].
	self renderDecorationIn: canvas.
	self renderPlotsIn: canvas
]

{ #category : #building }
RSChart >> canvas [
	^ canvas
]

{ #category : #color }
RSChart >> colorFor: aRSLinePlot [ 
	^ colors scale: aRSLinePlot
]

{ #category : #accessing }
RSChart >> colors [
	"Return the palette"
	^ colors
]

{ #category : #accessing }
RSChart >> colors: someColors [
	"Set the palette to be use to plots"
	colors := someColors
]

{ #category : #accessing }
RSChart >> decorations [
	^ decorations
]

{ #category : #color }
RSChart >> defaultPlotColors [
	^ NSScale category20c
]

{ #category : #accessing }
RSChart >> extent [
	^ extent
]

{ #category : #accessing }
RSChart >> extent: aPoint [
	extent := aPoint
]

{ #category : #visualization }
RSChart >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self build; canvas ]
		
]

{ #category : #initialization }
RSChart >> initialize [
	super initialize.
	plots := OrderedCollection new.
	extent := 200 @ 200.
	self initializeDecorations.
	colors := self defaultPlotColors.
]

{ #category : #initialization }
RSChart >> initializeDecorations [
	decorations := OrderedCollection new.
	self addDecoration: RSChartSpineDecoration new.
]

{ #category : #accessing }
RSChart >> maxValueX [ 
	^ maxValueX ifNil: [ maxValueX := (plots collect: #maxValueX) max ].
]

{ #category : #accessing }
RSChart >> maxValueX: aNumber [
	maxValueX := aNumber
]

{ #category : #accessing }
RSChart >> maxValueY [
	^ maxValueY ifNil: [ maxValueY := (plots collect: #maxValueY) max ]
]

{ #category : #accessing }
RSChart >> maxValueY: aNumber [
	maxValueY := aNumber
]

{ #category : #accessing }
RSChart >> minValueX [ 
	^ minValueX ifNil: [ minValueX := (plots collect: #minValueX) min ]
]

{ #category : #accessing }
RSChart >> minValueX: aNumber [
	minValueX := aNumber
]

{ #category : #accessing }
RSChart >> minValueY [
	
	^ minValueY ifNil: [ minValueY := (plots collect: #minValueY) min ]
]

{ #category : #accessing }
RSChart >> minValueY: aNumber [
	minValueY := aNumber
]

{ #category : #accessing }
RSChart >> niceGenerator [
	^ generator ifNil: [ 
		generator := RSLabelGenerator new.
		generator setLooseFlag: true.
		generator ].
]

{ #category : #'as yet unclassified' }
RSChart >> numberOfPlots [
	^ plots size
]

{ #category : #public }
RSChart >> open [
	"Open the chart in a new window. For example

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
x := (-3.14 to: 3.14 by: 0.1).
y := x sin * 0.22.
c := RSChart new.

p := RSLinePlot new.
p x: x y: y.
c addPlot: p.

c addDecoration: RSHorizontalTick new.
c addDecoration: (RSVerticalTick new asFloat).
c open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	"
	self build.
	^ canvas open
]

{ #category : #accessing }
RSChart >> plots [
	^ plots
]

{ #category : #building }
RSChart >> renderDecorationIn: aCanvas [
	decorations do: [ :d | d renderIn: aCanvas ]
]

{ #category : #building }
RSChart >> renderPlotsIn: aCanvas [
	plots do: [ :p | p renderIn: canvas ].
	
]

{ #category : #building }
RSChart >> show [
	self build.
	^ canvas open
]

{ #category : #accessing }
RSChart >> title: aTitle [
	self addDecoration: (RSChartTitleDecoration new title: aTitle)
]

{ #category : #'public - configuration' }
RSChart >> xLog [
	self xScale: NSScale log
]

{ #category : #'public - configuration' }
RSChart >> xScale: aScale [
	plots, decorations do: [ :e | e xScale: aScale ].
]

{ #category : #'public - configuration' }
RSChart >> xSqrt [
	self xScale: NSScale sqrt
]

{ #category : #'as yet unclassified' }
RSChart >> xlabel: aTitle [
	self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #'public - configuration' }
RSChart >> yLog [
	self yScale: NSScale log
]

{ #category : #'public - configuration' }
RSChart >> yScale: aScale [
	plots, decorations do: [ :e | e yScale: aScale ].
]

{ #category : #'public - configuration' }
RSChart >> ySqrt [
	self yScale: NSScale sqrt
]

{ #category : #'as yet unclassified' }
RSChart >> ylabel: aTitle [
	self addDecoration: (RSYLabelDecoration new title: aTitle)
]
