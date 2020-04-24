"
I am the main class to build chart.

Here is an example that adjust the font size used for the title, and axis labels:
-=-=-=-=
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; vertical).
c
-=-=-=-=
"
Class {
	#name : #RSChart,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'plots',
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
	#category : #'Roassal3-Chart-Core'
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

{ #category : #defaults }
RSChart >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
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

{ #category : #'public - configuration' }
RSChart >> mustInclude0inX [
	"Make sure that the 0 value is in the chart"
	((self minValueX to: self maxValueX) includes: 0) ifTrue: [ ^ self ].
	
	self maxValueX > 0 
		ifTrue: [ self minValueX: 0 ]
		ifFalse: [ self maxValueX: 0 ]
]

{ #category : #'public - configuration' }
RSChart >> mustInclude0inY [
	"Make sure that the 0 value is in the chart"
	((self minValueY to: self maxValueY) includes: 0) ifTrue: [ ^ self ].
	
	self maxValueY > 0 
		ifTrue: [ self minValueY: 0 ]
		ifFalse: [ self maxValueY: 0 ]
]

{ #category : #accessing }
RSChart >> niceGenerator [
	^ generator ifNil: [ 
		generator := RSLabelGenerator new.
		generator setLooseFlag: true.
		generator ].
]

{ #category : #accessing }
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
	^ self canvas open
]

{ #category : #accessing }
RSChart >> plots [
	^ plots
]

{ #category : #building }
RSChart >> renderDecorationIn: aCanvas [
	decorations do: [ :d | d renderIn: aCanvas ]
]

{ #category : #hooks }
RSChart >> renderIn: aCanvas [
	decorations, plots do: [ :e | e beforeRenderingIn: self ].
	self renderDecorationIn: aCanvas.
	self renderPlotsIn: aCanvas
]

{ #category : #building }
RSChart >> renderPlotsIn: aCanvas [
	plots do: [ :p | p renderIn: aCanvas ].
	
]

{ #category : #building }
RSChart >> show [
	^ self open
]

{ #category : #accessing }
RSChart >> title: aTitle [
	"Set the title of a chart:
	
	-=-=-=-=-=-=-=-=
	c := RSChart new.
	c addPlot: (RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt).
	c title: 'Square root'.
	c
	-=-=-=-=-=-=-=-=
	"
	self addDecoration: (RSChartTitleDecoration new title: aTitle)
]

{ #category : #'public - scales' }
RSChart >> xLinear [
	^ self xScale: NSScale linear
]

{ #category : #'public - scales' }
RSChart >> xLog [
	^ self xScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChart >> xRawLog [
	self xScale: NSScale log
]

{ #category : #'public - scales' }
RSChart >> xScale: aScale [
	plots, decorations do: [ :e | e xScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChart >> xSqrt [
	^ self xScale: NSScale sqrt
]

{ #category : #decoration }
RSChart >> xlabel: aTitle [
	self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #'public - scales' }
RSChart >> yLinear [
	^ self yScale: NSScale linear
]

{ #category : #'public - scales' }
RSChart >> yLog [
	^ self yScale: NSScale symlog
]

{ #category : #'public - scales' }
RSChart >> yRawLog [
	"ensure all your data and axis do not contains zero"
	^ self yScale: NSScale log
]

{ #category : #'public - scales' }
RSChart >> yScale: aScale [
	plots, decorations do: [ :e | e yScale: aScale ].
	^ aScale
]

{ #category : #'public - scales' }
RSChart >> ySqrt [
	^ self yScale: NSScale sqrt
]

{ #category : #decoration }
RSChart >> ylabel: aTitle [
	self addDecoration: (RSYLabelDecoration new title: aTitle)
]
