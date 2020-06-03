"
TODO
"
Class {
	#name : #RSAbstractChartElement,
	#superclass : #Object,
	#instVars : [
		'chart',
		'xScale',
		'yScale',
		'colorblock'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractChartElement >> addShape: aShape [
	"Add a shape to the canvas"
	chart canvas add: aShape
]

{ #category : #rendering }
RSAbstractChartElement >> beforeRenderingIn: aChart [
	"do nothing here"
]

{ #category : #accessing }
RSAbstractChartElement >> chart [
	^ chart
]

{ #category : #accessing }
RSAbstractChartElement >> chart: aChart [
	chart := aChart
]

{ #category : #public }
RSAbstractChartElement >> color: aColor [
	"Set the color of the plot.
	
For example:
-=-=-=-=-=-=-=-=-=
x := 0.0 to: 2 count: 10.
y := (x raisedTo: 2) - 2.
c := RSChart new.

c addPlot: (RSBarPlot new x: x y: y).
c addPlot: (RSLinePlot new x: x y: y; color: Color red).

c addDecoration: (RSHorizontalTick new  asFloat).
c addDecoration: (RSVerticalTick new 
	numberOfTicks: 10;
	asFloat).
c xlabel: 'X Axis'.
c ylabel: 'Y Axis'.
c title: 'Bar char'.
c
-=-=-=-=-=-=-=-=-=
"
	colorblock := [ :aColorGivenByChart | aColor ]
]

{ #category : #public }
RSAbstractChartElement >> computeColor [
	"Return the color used by the chart element. The color is computed from the chart and from the colorBlock variable"
	^ colorblock rsValue: (chart colorFor: self)
]

{ #category : #rendering }
RSAbstractChartElement >> createXScale [
	xScale ifNil: [ xScale := NSScale linear ].
	xScale
		domain:
			{chart minValueX.
			chart maxValueX};
		range:
			{0.
			chart extent x}
]

{ #category : #rendering }
RSAbstractChartElement >> createYScale [
	yScale ifNil: [ yScale := NSScale linear ].
	yScale
		domain:
			{chart minValueY.
			chart maxValueY};
		range:
			{0.
			chart extent y negated}

]

{ #category : #rendering }
RSAbstractChartElement >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractChartElement >> spine [
	"Return the Trachel shape that describe the spine"
	^ (chart decorations
		detect: [ :d | d class == RSChartSpineDecoration ]
		ifNone: [ self error: 'No spine is added in the plt, you need to add one' ])
		shape
]

{ #category : #public }
RSAbstractChartElement >> useColorFromChart [ 
	"The color of the plot is given by the chart"
	colorblock := [ :aColorGivenByChart | aColorGivenByChart ]
]

{ #category : #accessing }
RSAbstractChartElement >> xScale [
	^ xScale
]

{ #category : #accessing }
RSAbstractChartElement >> xScale: aScale [
	xScale := aScale
]

{ #category : #accessing }
RSAbstractChartElement >> yScale [
	^ yScale
]

{ #category : #accessing }
RSAbstractChartElement >> yScale: aScale [
	yScale := aScale
]
