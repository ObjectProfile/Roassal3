"
TODO
"
Class {
	#name : #RSAbstractChartDecoration,
	#superclass : #RSObject,
	#instVars : [
		'xScale',
		'yScale',
		'chart',
		'shape',
		'styler'
	],
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #accessing }
RSAbstractChartDecoration >> addShape: aShape [
	"Add a shape to the canvas"

	chart canvas add: aShape
]

{ #category : #'private - adding' }
RSAbstractChartDecoration >> addedIn: aPlot [
	aPlot addDecoration: self
]

{ #category : #accessing }
RSAbstractChartDecoration >> beforeRenderingIn: aChart [
]

{ #category : #accessing }
RSAbstractChartDecoration >> chart [

	^ chart
]

{ #category : #accessing }
RSAbstractChartDecoration >> chart: aChart [

	chart := aChart
]

{ #category : #accessing }
RSAbstractChartDecoration >> color [

	^ self shape color
]

{ #category : #accessing }
RSAbstractChartDecoration >> color: aColor [

	self shape color: aColor
]

{ #category : #rendering }
RSAbstractChartDecoration >> createXScale [

	| padding |
	xScale ifNil: [ xScale := NSScale linear ].
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding x.
	xScale
		domain: {
				chart minChartValueX.
				chart maxChartValueX };
		range: {
				(0 + padding).
				(chart extent x - padding) }
]

{ #category : #rendering }
RSAbstractChartDecoration >> createYScale [

	| padding |
	yScale ifNil: [ yScale := NSScale linear ].
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding y.
	yScale
		domain: {
				chart minChartValueY.
				chart maxChartValueY };
		range: {
				(0 - padding).
				(chart extent y negated + padding) }
]

{ #category : #accessing }
RSAbstractChartDecoration >> createdShapes [

	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractChartDecoration >> defaultShape [

	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractChartDecoration >> defaultStyler [

	^ RSChartStyler new
]

{ #category : #initialization }
RSAbstractChartDecoration >> initialize [

	super initialize.
	shape := self defaultShape.
	styler := self defaultStyler
]

{ #category : #testing }
RSAbstractChartDecoration >> isDecoration [

	^ true
]

{ #category : #accessing }
RSAbstractChartDecoration >> isHorizontalTick [

	^ false
]

{ #category : #accessing }
RSAbstractChartDecoration >> isPlot [

	^ false
]

{ #category : #testing }
RSAbstractChartDecoration >> isSpineDecoration [

	^ false
]

{ #category : #testing }
RSAbstractChartDecoration >> isTitle [

	^ false
]

{ #category : #accessing }
RSAbstractChartDecoration >> isVerticalTick [

	^ false
]

{ #category : #testing }
RSAbstractChartDecoration >> isXLabel [

	^ false
]

{ #category : #testing }
RSAbstractChartDecoration >> isYLabel [

	^ false
]

{ #category : #accessing }
RSAbstractChartDecoration >> shape [

	^ shape
]

{ #category : #testing }
RSAbstractChartDecoration >> shape: aRSShape [

	shape := aRSShape
]

{ #category : #rendering }
RSAbstractChartDecoration >> spine [
	"Return the roassal shape that describes the spine"
	^ chart spine
]

{ #category : #accessing }
RSAbstractChartDecoration >> styler [

 ^ styler
]

{ #category : #accessing }
RSAbstractChartDecoration >> styler: aStyler [

 styler := aStyler
]

{ #category : #accessing }
RSAbstractChartDecoration >> xScale [

	^ xScale
]

{ #category : #accessing }
RSAbstractChartDecoration >> xScale: aScale [

	xScale := aScale
]

{ #category : #accessing }
RSAbstractChartDecoration >> yScale [

	^ yScale
]

{ #category : #accessing }
RSAbstractChartDecoration >> yScale: aScale [

	yScale := aScale
]
