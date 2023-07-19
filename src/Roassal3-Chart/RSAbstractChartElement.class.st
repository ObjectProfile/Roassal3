"
Abstract class for all plot classes
"
Class {
	#name : #RSAbstractChartElement,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'xScale',
		'yScale',
		'styler'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #'private - adding' }
RSAbstractChartElement >> addedIn: anRSChart [
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractChartElement >> beforeRenderingIn: aChart [
]

{ #category : #accessing }
RSAbstractChartElement >> chart [
	^ chart
]

{ #category : #accessing }
RSAbstractChartElement >> chart: aChart [
	chart := aChart
]

{ #category : #'public - shape' }
RSAbstractChartElement >> color [
	^ self shape color
]

{ #category : #'public - shape' }
RSAbstractChartElement >> color: aColor [
	self shape color: aColor
]

{ #category : #rendering }
RSAbstractChartElement >> createXScale [
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
RSAbstractChartElement >> createYScale [
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
RSAbstractChartElement >> createdShapes [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartElement >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartElement >> defaultStyler [
	^ RSChartStyler new
]

{ #category : #initialization }
RSAbstractChartElement >> initialize [
	super initialize.
	shape := self defaultShape.
	styler := self defaultStyler
]

{ #category : #testing }
RSAbstractChartElement >> isDecoration [
	^ false
]

{ #category : #testing }
RSAbstractChartElement >> isHorizontalTick [
	^ false
]

{ #category : #testing }
RSAbstractChartElement >> isPlot [
	^ false
]

{ #category : #testing }
RSAbstractChartElement >> isVerticalTick [
	^ false
]

{ #category : #rendering }
RSAbstractChartElement >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractChartElement >> shape [
	^ shape
]

{ #category : #accessing }
RSAbstractChartElement >> shape: aRSShape [
	shape := aRSShape
]

{ #category : #rendering }
RSAbstractChartElement >> spine [
	"Return the roassal shape that describes the spine"
	^ chart spine
]

{ #category : #accessing }
RSAbstractChartElement >> styler [
	^ styler
]

{ #category : #accessing }
RSAbstractChartElement >> styler: anObject [

	styler := anObject
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
