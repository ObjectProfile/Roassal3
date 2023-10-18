"
<keyClass>
`RSAbstractChartDecoration` is the abstract class for chart decorations.

*Responsibility*: manage decorations for charts.

*Collaborators*: interacts with charts. 

*Variables*:
- xScale:	 the scale of the x-axis
- yScale:	 the scale of the y-axis
- chart: the chart in which the decoration is
- shape: the shape of the decoration
- styler: the style of the decoration
"
Class {
	#name : 'RSAbstractChartDecoration',
	#superclass : 'RSObject',
	#instVars : [
		'xScale',
		'yScale',
		'chart',
		'styler',
		'masterShape'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'rendering' }
RSAbstractChartDecoration >> addShape: aShape [
	"Add a shape to the canvas"

	chart canvas add: aShape
]

{ #category : 'private - adding' }
RSAbstractChartDecoration >> addedIn: aPlot [
	aPlot addDecoration: self
]

{ #category : 'rendering' }
RSAbstractChartDecoration >> beforeRenderingIn: aChart [
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> chart [

	^ chart
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> chart: aChart [

	chart := aChart
]

{ #category : 'public - shape' }
RSAbstractChartDecoration >> color [

	^ self shape color
]

{ #category : 'public - shape' }
RSAbstractChartDecoration >> color: aColor [

	self shape color: aColor
]

{ #category : 'rendering' }
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

{ #category : 'rendering' }
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

{ #category : 'accessing' }
RSAbstractChartDecoration >> createdShapes [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
RSAbstractChartDecoration >> defaultShape [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
RSAbstractChartDecoration >> defaultStyler [

	^ RSChartStyler new
]

{ #category : 'initialization' }
RSAbstractChartDecoration >> initialize [

	super initialize.
	masterShape := self defaultShape.
	styler := self defaultStyler
]

{ #category : 'testing' }
RSAbstractChartDecoration >> isHorizontalTick [

	^ false
]

{ #category : 'testing' }
RSAbstractChartDecoration >> isPlot [

	^ false
]

{ #category : 'testing' }
RSAbstractChartDecoration >> isSpineDecoration [

	^ false
]

{ #category : 'testing' }
RSAbstractChartDecoration >> isTitle [

	^ false
]

{ #category : 'testing' }
RSAbstractChartDecoration >> isVerticalTick [

	^ false
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> masterShape [

	^ masterShape
]

{ #category : 'rendering' }
RSAbstractChartDecoration >> renderIn: aCanvas [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> shape [

	^ masterShape
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> shape: aRSShape [

	masterShape := aRSShape
]

{ #category : 'rendering' }
RSAbstractChartDecoration >> spine [
	"Return the roassal shape that describes the spine"
	^ chart spine
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> styler [

 ^ styler
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> styler: aStyler [

 styler := aStyler
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> xScale [

	^ xScale
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> xScale: aScale [

	xScale := aScale
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> yScale [

	^ yScale
]

{ #category : 'accessing' }
RSAbstractChartDecoration >> yScale: aScale [

	yScale := aScale
]
