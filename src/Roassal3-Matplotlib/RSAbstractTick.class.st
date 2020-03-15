Class {
	#name : #RSAbstractTick,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'numberOfTicks',
		'shouldHaveLabels',
		'labelConversion',
		'labelLocation',
		'shouldUseNiceLabel',
		'niceLabel',
		'labelRotation',
		'fontSize'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSAbstractTick >> beforeRenderingIn: aChart [
	niceLabel := shouldUseNiceLabel 
		ifTrue: [ self createNiceLabelIn: aChart ]
		ifFalse: [ self defaultNiceLabel ].
	super beforeRenderingIn: aChart.
]

{ #category : #rendering }
RSAbstractTick >> createLabelFor: aValue [
	"Create a label and returns it."

	^ RSLabel new 
		fontSize: fontSize; 
		text: (labelConversion value: aValue); 
		rotateByDegrees: self labelRotation
]

{ #category : #rendering }
RSAbstractTick >> createNiceLabelIn: aChart [
	| nice |
	nice := aChart niceGenerator 
		searchMin: self minValue
		max: self maxValue
		desired: numberOfTicks.
	^ nice
]

{ #category : #rendering }
RSAbstractTick >> createTickLineFor: aNumber [
	^ self subclassResponsibility
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultLabelLocation [
	^ self subclassResponsibility
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultLabelRotation [
	^ 0
]

{ #category : #'accessing - defaults' }
RSAbstractTick >> defaultNiceLabel [
	| nice |
	nice := RSNiceLabel new.
	nice
		min: self minValue;
		max: self maxValue;
		step: nice ticks / numberOfTicks.
	^ nice
]

{ #category : #rendering }
RSAbstractTick >> doNotUseNiceLabel [
	"Ticks use RSNiceLabelGenerator"
	shouldUseNiceLabel := false
]

{ #category : #accessing }
RSAbstractTick >> fontSize: fontSizeToSet [
	"Set the font size used by the labels associated to ticks"
	fontSize := fontSizeToSet
]

{ #category : #rendering }
RSAbstractTick >> initialize [
	super initialize.
	numberOfTicks := 5.
	self withLabels; useNiceLabel; noConvertion.
	fontSize := 5.
]

{ #category : #public }
RSAbstractTick >> integer [
	"Do not convert the value when determining labels"
	labelConversion := [ :value | value asInteger ]
]

{ #category : #public }
RSAbstractTick >> integerWithCommas [
	"Do not convert the value when determining labels"
	labelConversion := [ :value | value asStringWithCommas ]
]

{ #category : #accessing }
RSAbstractTick >> labelLocation [
	^ labelLocation ifNil: [ labelLocation := self defaultLabelLocation ].
]

{ #category : #accessing }
RSAbstractTick >> labelRotation [
	^ labelRotation ifNil: [ labelRotation := self defaultLabelRotation ].
]

{ #category : #accessing }
RSAbstractTick >> maxValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractTick >> minValue [
	^ self subclassResponsibility
]

{ #category : #public }
RSAbstractTick >> noConvertion [
	"Do not convert the value when determining labels"
	labelConversion := [ :value | value ]
]

{ #category : #accessing }
RSAbstractTick >> numberOfTicks: aNumber [
	numberOfTicks := aNumber
]

{ #category : #rendering }
RSAbstractTick >> renderIn: canvas [
	| aTick lbl |
	(niceLabel min to: niceLabel max by: niceLabel step) do: [ :i |
		aTick := self createTickLineFor: i.
		canvas addShape: aTick.
		shouldHaveLabels ifTrue: [ 
			lbl := self createLabelFor: i.
			self labelLocation move: lbl on: aTick.
			canvas addShape: lbl.
		]
	]
	
]

{ #category : #rendering }
RSAbstractTick >> tickSize [
	"Size of the tick. A constant for now, but can be easily turned into a parameter"
	^ 3
]

{ #category : #rendering }
RSAbstractTick >> useNiceLabel [
	"Ticks use RSNiceLabelGenerator"
	shouldUseNiceLabel := true
]

{ #category : #rendering }
RSAbstractTick >> withLabels [
	"Make the tick have label"
	shouldHaveLabels := true
]

{ #category : #rendering }
RSAbstractTick >> withNoLabels [
	"Ticks have no label"
	shouldHaveLabels := false
]
