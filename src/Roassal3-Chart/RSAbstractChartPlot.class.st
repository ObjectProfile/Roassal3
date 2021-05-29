"
TODO
"
Class {
	#name : #RSAbstractChartPlot,
	#superclass : #Object,
	#instVars : [
		'chart',
		'xScale',
		'yScale'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractChartPlot >> addShape: aShape [
	"Add a shape to the canvas"
	chart canvas add: aShape
]

{ #category : #rendering }
RSAbstractChartPlot >> beforeRenderingIn: aChart [
	"do nothing here"
]

{ #category : #accessing }
RSAbstractChartPlot >> chart [
	^ chart
]

{ #category : #accessing }
RSAbstractChartPlot >> chart: aChart [
	chart := aChart
]

{ #category : #rendering }
RSAbstractChartPlot >> createXScale [
	| padding |
	xScale ifNil: [ xScale := NSScale linear ].
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding x.
	xScale
		domain:
			{chart minValueX.
			chart maxValueX};
		range:
			{0 + padding.
			chart extent x - padding}
]

{ #category : #rendering }
RSAbstractChartPlot >> createYScale [
	| padding |
	yScale ifNil: [ yScale := NSScale linear ].
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding y.
	yScale
		domain:
			{chart minValueY.
			chart maxValueY};
		range:
			{0 - padding.
			chart extent y negated + padding }

]

{ #category : #rendering }
RSAbstractChartPlot >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractChartPlot >> spine [
	"Return the Trachel shape that describe the spine"
	^ (chart decorations
		detect: [ :d | d class == RSChartSpineDecoration ]
		ifNone: [ self error: 'No spine is added in the plt, you need to add one' ])
		shape
]

{ #category : #accessing }
RSAbstractChartPlot >> xScale [
	^ xScale
]

{ #category : #accessing }
RSAbstractChartPlot >> xScale: aScale [
	xScale := aScale
]

{ #category : #accessing }
RSAbstractChartPlot >> yScale [
	^ yScale
]

{ #category : #accessing }
RSAbstractChartPlot >> yScale: aScale [
	yScale := aScale
]
