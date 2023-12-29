"
I define basic configuration for ticks, my subclasses creates lines and labels for each defined axis
"
Class {
	#name : 'RSAbstractTick',
	#superclass : 'RSAbstractChartDecoration',
	#instVars : [
		'ticks',
		'labels',
		'labelLocation',
		'configuration',
		'tickLocator',
		'ticksData'
	],
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'public' }
RSAbstractTick >> asFloat [
	self asFloat: 3
]

{ #category : 'public' }
RSAbstractTick >> asFloat: numberOfDecimals [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asFloat round: numberOfDecimals ]
]

{ #category : 'rendering' }
RSAbstractTick >> beforeRenderingIn: aChart [

	self createXScale.
	self createYScale.

	self updateChartMaxAndMinValues: aChart.

	"We need to recalculate the scales because in the above method,
	updateChartMaxAndMinValues:, we change the dimensions of the chart. And now we need to
	recalculate the scales to be consistent with the dimensions."
	self createXScale.
	chart createXScale.
	self createYScale.
	chart createYScale
]

{ #category : 'public' }
RSAbstractTick >> computeTicksData [

	| scaleToUse data |
	scaleToUse := self scaleToUse.
	data := tickLocator
		        generateTicks: scaleToUse
		        with: self configuration numberOfTicks.
	data ifEmpty: [ Error signal: 'Empty ticks data' ].
	configuration numberOfTicks: data size.

	^ data
]

{ #category : 'accessing' }
RSAbstractTick >> configuration [
	^ configuration ifNil: [ configuration := self defaultConfiguration ]
]

{ #category : 'accessing' }
RSAbstractTick >> configuration: aRSTickConfiguration [
	configuration := aRSTickConfiguration
]

{ #category : 'rendering' }
RSAbstractTick >> createLabelFor: aValue index: index [
	"Create a label and returns it."
	| tick lbl |
	tick := self ticks at: index.
	lbl := self configuration createLabelFor: aValue.
	lbl color: self styler textColor.
	self labelLocation move: lbl on: tick.
	^ lbl
]

{ #category : 'rendering' }
RSAbstractTick >> createTickLineFor: aNumber [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractTick >> createdShapes [
	^ labels, ticks
]

{ #category : 'accessing - defaults' }
RSAbstractTick >> defaultConfiguration [
	^ RSTickConfiguration new
]

{ #category : 'accessing - defaults' }
RSAbstractTick >> defaultLabelLocation [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
RSAbstractTick >> defaultLocator [

	^ RSAutoLocator new
]

{ #category : 'initialization' }
RSAbstractTick >> defaultShape [
	^ RSLine new
]

{ #category : 'public' }
RSAbstractTick >> doNotUseNiceLabel [

	self locator: RSLinearLocator new
]

{ #category : 'accessing' }
RSAbstractTick >> fontSize: fontSizeToSet [
	"Set the font size used by the labels associated to ticks"

"
For example:
-=-=-=-=-=-=-=-=-=
x := (-10 to: 10).
y := x * x.

c := RSChart new.
d := RSLinePlot new x: x y: y.
c addPlot: d.

c extent: 400 @ 400.
c addDecoration: (RSVerticalTick new fontSize: 20).
c addDecoration: (RSHorizontalTick new fontSize: 20).
c
-=-=-=-=-=-=-=-=-=
"
	self configuration fontSize: fontSizeToSet
]

{ #category : 'public' }
RSAbstractTick >> fromNames: aCollectionOfStrings [
	| size |
	size := aCollectionOfStrings size.
	self ticks: (1 to: size) labels: aCollectionOfStrings
]

{ #category : 'initialization' }
RSAbstractTick >> initialize [

	super initialize.
	tickLocator := self defaultLocator
]

{ #category : 'public' }
RSAbstractTick >> integer [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asInteger ]
]

{ #category : 'public' }
RSAbstractTick >> integerWithCommas [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asInteger asStringWithCommas ]
]

{ #category : 'testing' }
RSAbstractTick >> isTicksDataNil [
	^ ticksData isNil
]

{ #category : 'public' }
RSAbstractTick >> labelConversion: oneArgBlock [
	"This method is used to convert numerical values into a label. This is useful to particularlize labels on the X or Y axes. The parameter block accepts one argument, which is a numerical value. The block should return a string or any other object. When displayed, the message asString will be sent to it.

	For example:
-=-=-=-=-=-=-=-=-=
x := #(-2 -1 0 1 2).
y := #(5 10 12 14 20).

c := RSChart new.
d := RSLinePlot new x: x y: y.
c addPlot: d.

c addDecoration: (RSVerticalTick new).
c addDecoration: (RSHorizontalTick new
							numberOfTicks: x size;
							labelConversion: [ :val | Date today addDays: val ] ).
c mustInclude0inY.
c
-=-=-=-=-=-=-=-=-=
	"
	self configuration labelConversion: oneArgBlock
]

{ #category : 'accessing' }
RSAbstractTick >> labelLocation [
	^ labelLocation ifNil: [ labelLocation := self defaultLabelLocation ]
]

{ #category : 'accessing' }
RSAbstractTick >> labelRotation [
	^ self configuration labelRotation
]

{ #category : 'accessing' }
RSAbstractTick >> labelRotation: aNumber [
	self configuration labelRotation: aNumber
]

{ #category : 'accessing' }
RSAbstractTick >> labels [
	^ labels
]

{ #category : 'accessing' }
RSAbstractTick >> locator [

	^ tickLocator
]

{ #category : 'accessing' }
RSAbstractTick >> locator: aLocator [

	tickLocator := aLocator
]

{ #category : 'accessing' }
RSAbstractTick >> max [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractTick >> min [
	^ self subclassResponsibility
]

{ #category : 'instance creation' }
RSAbstractTick >> newLineTick [
	^ self shape copy
		color: self styler tickColor;
		yourself
]

{ #category : 'public' }
RSAbstractTick >> noConvertion [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value ]
]

{ #category : 'accessing' }
RSAbstractTick >> numberOfTicks: aNumber [
	"Set the number of ticks to be used. Can be used with doNotUseNiceLabels or not.

For example:
```Smalltalk
x := (-3.14 to: 3.14 count: 20).
y := x sin.

c := RSChart new.
d := RSLinePlot new x: x y: y.
c addPlot: d.
c addDecoration: (RSVerticalTick new).
c addDecoration: (RSHorizontalTick new numberOfTicks: 10; asFloat: 2).
c
```Smalltalk
	"
	self configuration numberOfTicks: aNumber
]

{ #category : 'rendering' }
RSAbstractTick >> renderIn: canvas [
	ticksData := self ticksData.
	ticks := ticksData collect: [ :value | self createTickLineFor: value ].
	canvas addAll: ticks.
	self configuration shouldHaveLabels ifFalse: [
		labels := #().
		 ^ self ].
	labels := ticksData collectWithIndex: [ :value :index |
		self createLabelFor: value index: index ].
	canvas addAll: labels
]

{ #category : 'public' }
RSAbstractTick >> scaleToUse [

	^ self isHorizontalTick
		ifTrue: [ xScale ]
		ifFalse: [ yScale ]
]

{ #category : 'accessing' }
RSAbstractTick >> ticks [
	^ ticks
]

{ #category : 'public' }
RSAbstractTick >> ticks: collectionOfNumbers labels: collectionOfStrings [
	self
		assert: collectionOfNumbers size = collectionOfStrings size
		description: 'Both collections should have same size'.
	self
		assert: collectionOfStrings isNotEmpty
		description: 'collectionOfStrings should not be empty'.
	self ticksData: collectionOfNumbers.
	self labelConversion: [ :number |
		| index |
		index := collectionOfNumbers indexOf: number.
		(index between: 1 and: collectionOfStrings size)
			ifTrue: [ collectionOfStrings at: index ]
			ifFalse: [ '' ]
	]
]

{ #category : 'public' }
RSAbstractTick >> ticksData [
	^ ticksData ifNil: [ ticksData := self computeTicksData ]
]

{ #category : 'public' }
RSAbstractTick >> ticksData: collectionOfNumbers [
	ticksData := collectionOfNumbers
]

{ #category : 'rendering' }
RSAbstractTick >> updateChartMaxAndMinValues: aChart [

	self subclassResponsibility
]

{ #category : 'public' }
RSAbstractTick >> useNiceLabel [

	self locator: RSAutoLocator new
]

{ #category : 'public' }
RSAbstractTick >> withLabels [
	"Make the tick have label"
	self configuration shouldHaveLabels: true
]

{ #category : 'public' }
RSAbstractTick >> withNoLabels [
	"Ticks have no label"
	self configuration shouldHaveLabels: false
]
