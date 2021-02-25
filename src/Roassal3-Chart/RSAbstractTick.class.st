"
I define basic configuration for ticks, my subclasses creates lines and labels for each defined axis
"
Class {
	#name : #RSAbstractTick,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'configuration',
		'niceLabel',
		'ticks',
		'labels',
		'labelLocation'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #public }
RSAbstractTick >> asFloat [
	self asFloat: 3
]

{ #category : #public }
RSAbstractTick >> asFloat: numberOfDecimals [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asFloat round: numberOfDecimals ]
]

{ #category : #rendering }
RSAbstractTick >> beforeRenderingIn: aChart [
	niceLabel := self configuration shouldUseNiceLabel 
		ifTrue: [ self createNiceLabelIn: aChart ]
		ifFalse: [ self defaultNiceLabel ].
	super beforeRenderingIn: aChart.
]

{ #category : #accessing }
RSAbstractTick >> configuration [
	^ configuration ifNil: [ configuration := self defaultConfiguration ]
]

{ #category : #accessing }
RSAbstractTick >> configuration: aRSTickConfiguration [
	configuration := aRSTickConfiguration
]

{ #category : #rendering }
RSAbstractTick >> createLabelFor: aValue [
	"Create a label and returns it."
	^ self configuration createLabelFor: aValue
]

{ #category : #rendering }
RSAbstractTick >> createLabelFor: aValue index: index [
	"Create a label and returns it."
	| tick lbl |
	tick := self ticks at: index.
	lbl := self configuration createLabelFor: aValue.
	self labelLocation move: lbl on: tick.
	^ lbl
	
]

{ #category : #accessing }
RSAbstractTick >> createNiceLabelIn: aChart [
	| nice |
	nice := aChart niceGenerator 
		searchMin: self min
		max: self max
		desired: self configuration numberOfTicks.
	^ nice
]

{ #category : #rendering }
RSAbstractTick >> createTickLineFor: aNumber [
	^ self subclassResponsibility
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultConfiguration [
	^ RSTickConfiguration new
		numberOfTicks: 5;
		fontSize: 5;
		labelRotation: 0;
		shouldHaveLabels: true;
		shouldUseNiceLabel: true;
		labelConversion: [ :value | value ] ;
		tickSize: 3;
		yourself
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultLabelLocation [
	^ self subclassResponsibility
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultNiceLabel [
	| nice |
	nice := RSNiceLabel new.
	nice
		min: self min;
		max: self max;
		step: nice ticks / self configuration numberOfTicks.
	^ nice
]

{ #category : #initialization }
RSAbstractTick >> defaultShape [
	^ RSLine new
]

{ #category : #public }
RSAbstractTick >> doNotUseNiceLabel [
	"Ticks use RSNiceLabelGenerator"
	self configuration shouldUseNiceLabel: false
]

{ #category : #accessing }
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

{ #category : #public }
RSAbstractTick >> fromNames: aCollectionOfStrings [
	self
		doNotUseNiceLabel;
		numberOfTicks: aCollectionOfStrings size-1.
	
	self labelConversion: [ :x | 
		x isZero 
			ifTrue: [ '' ]
			ifFalse: [aCollectionOfStrings at: x asInteger ] ].
		
]

{ #category : #public }
RSAbstractTick >> integer [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asInteger ]
]

{ #category : #public }
RSAbstractTick >> integerWithCommas [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value asInteger asStringWithCommas ]
]

{ #category : #public }
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

{ #category : #accessing }
RSAbstractTick >> labelLocation [
	^ labelLocation ifNil: [ labelLocation := self defaultLabelLocation ].
]

{ #category : #accessing }
RSAbstractTick >> labelRotation [
	^ self configuration labelRotation
]

{ #category : #accessing }
RSAbstractTick >> labelRotation: aNumber [
	self configuration labelRotation: aNumber
]

{ #category : #accessing }
RSAbstractTick >> labels [
	^ labels
]

{ #category : #accessing }
RSAbstractTick >> max [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractTick >> min [
	^ self subclassResponsibility
]

{ #category : #public }
RSAbstractTick >> noConvertion [
	"Do not convert the value when determining labels"
	self labelConversion: [ :value | value ]
]

{ #category : #accessing }
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

{ #category : #rendering }
RSAbstractTick >> renderIn: canvas [
	| ticksData |
	niceLabel step isZero ifTrue: [ niceLabel step: 1 ].
	ticksData := niceLabel min to: niceLabel max by: niceLabel step. 
	ticks := ticksData collect: [ :value | self createTickLineFor: value ].
	canvas addAll: ticks.
	self configuration shouldHaveLabels ifFalse: [ ^ self ].
	labels := ticksData collectWithIndex: [ :value :index | 
		self createLabelFor: value index: index ].
	canvas addAll: labels.
]

{ #category : #accessing }
RSAbstractTick >> ticks [
	^ ticks
]

{ #category : #public }
RSAbstractTick >> useNiceLabel [
	"Ticks use RSNiceLabelGenerator"
	self configuration shouldUseNiceLabel: true
]

{ #category : #public }
RSAbstractTick >> withLabels [
	"Make the tick have label"
	self configuration shouldHaveLabels: true
]

{ #category : #public }
RSAbstractTick >> withNoLabels [
	"Ticks have no label"
	self configuration shouldHaveLabels: false
]
