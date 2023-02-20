"
Abstract class for all plot classes
"
Class {
	#name : #RSAbstractChartPlot,
	#superclass : #Object,
	#instVars : [
		'chart',
		'xScale',
		'yScale',
		'shape'
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
]

{ #category : #accessing }
RSAbstractChartPlot >> chart [
	^ chart
]

{ #category : #accessing }
RSAbstractChartPlot >> chart: aChart [
	chart := aChart
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> color [
	^ self shape color
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> color: aColor [
	self shape color: aColor
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

{ #category : #accessing }
RSAbstractChartPlot >> createdShapes [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartPlot >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartPlot >> initialize [
	super initialize.
	shape := self defaultShape
]

{ #category : #testing }
RSAbstractChartPlot >> isDecoration [
	^ false
]

{ #category : #testing }
RSAbstractChartPlot >> isHorizontalTick [
	^ false
]

{ #category : #testing }
RSAbstractChartPlot >> isPlot [
	^ false
]

{ #category : #testing }
RSAbstractChartPlot >> isVerticalTick [
	^ false
]

{ #category : #rendering }
RSAbstractChartPlot >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractChartPlot >> shape [
	^ shape
]

{ #category : #accessing }
RSAbstractChartPlot >> shape: aRSShape [
	shape := aRSShape
]

{ #category : #rendering }
RSAbstractChartPlot >> spine [
	"Return the roassal shape that describes the spine"
	^ chart spine
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
