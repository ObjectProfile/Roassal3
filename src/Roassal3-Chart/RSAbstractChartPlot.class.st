"
Abstract class for all plot classes
"
Class {
	#name : #RSAbstractChartPlot,
	#superclass : #RSChart,
	#instVars : [
		'chart',
		'xScale',
		'yScale',
		'shape',
		'styler'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractChartPlot >> addShape: aShape [
	"Add a shape to the canvas"
	self container add: aShape
]

{ #category : #rendering }
RSAbstractChartPlot >> beforeRenderingIn: aChart [
]

{ #category : #accessing }
RSAbstractChartPlot >> chartExtents [
	^ extents ifNil: [ extents := RSChartExtents new ]
]

{ #category : #'accessing - extension' }
RSAbstractChartPlot >> chartExtents: aRSChartExtents [
	extents := aRSChartExtents
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
	padding := self padding x.
	xScale
		domain:
			{self minValueX.
			self maxValueX};
		range:
			{0 + padding.
			self extent x - padding}
]

{ #category : #accessing }
RSAbstractChartPlot >> createdShapes [

	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartPlot >> initialize [
	super initialize.
	shape := self defaultShape.
	styler := self defaultStyler.
	self className = 'RSSpineDecoration' ifTrue: [ Transcript show: chart ].
]

{ #category : #testing }
RSAbstractChartPlot >> isPlot [

	^ false
]

{ #category : #'accessing - extension' }
RSAbstractChartPlot >> padding [
	^ self chartExtents padding
]

{ #category : #'accessing - extension' }
RSAbstractChartPlot >> padding: aPoint [
	self chartExtents padding: aPoint asPoint
]

{ #category : #accessing }
RSAbstractChartPlot >> styler: anObject [

	styler := anObject
]
