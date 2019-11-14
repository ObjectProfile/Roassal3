Class {
	#name : #RSAbstractTick,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'numberOfTicks',
		'shouldHaveLabels',
		'labelConversion'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSAbstractTick >> createLabelFor: aValue [
	"Create a label and returns it."

	^ RSLabel new fontSize: 5; text: (labelConversion value: aValue) asString
]

{ #category : #rendering }
RSAbstractTick >> initialize [
	super initialize.
	numberOfTicks := 5.
	self withLabels.
	self noConvertion
]

{ #category : #'as yet unclassified' }
RSAbstractTick >> integer [
	"Do not convert the value when determining labels"
	labelConversion := [ :value | value asInteger ]
]

{ #category : #'as yet unclassified' }
RSAbstractTick >> noConvertion [
	"Do not convert the value when determining labels"
	labelConversion := [ :value | value ]
]

{ #category : #rendering }
RSAbstractTick >> tickSize [
	"Size of the tick. A constant for now, but can be easily turned into a parameter"
	^ 3
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
