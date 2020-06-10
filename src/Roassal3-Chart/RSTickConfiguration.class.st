"
TODO
"
Class {
	#name : #RSTickConfiguration,
	#superclass : #Object,
	#instVars : [
		'numberOfTicks',
		'shouldHaveLabels',
		'labelConversion',
		'shouldUseNiceLabel',
		'labelRotation',
		'fontSize',
		'tickSize'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #public }
RSTickConfiguration >> createLabelFor: aValue [
	^ RSLabel new 
		fontSize: self fontSize; 
		text: (self labelConversion rsValue: aValue); 
		rotateByDegrees: self labelRotation;
		yourself
]

{ #category : #accessing }
RSTickConfiguration >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RSTickConfiguration >> fontSize: aNumber [
	fontSize := aNumber
]

{ #category : #accessing }
RSTickConfiguration >> labelConversion [
	^ labelConversion
]

{ #category : #accessing }
RSTickConfiguration >> labelConversion: aOneArgBlock [
	labelConversion := aOneArgBlock
]

{ #category : #accessing }
RSTickConfiguration >> labelRotation [
	^ labelRotation
]

{ #category : #accessing }
RSTickConfiguration >> labelRotation: anObject [
	labelRotation := anObject
]

{ #category : #accessing }
RSTickConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #accessing }
RSTickConfiguration >> numberOfTicks: anObject [
	numberOfTicks := anObject
]

{ #category : #accessing }
RSTickConfiguration >> shouldHaveLabels [
	^ shouldHaveLabels
]

{ #category : #accessing }
RSTickConfiguration >> shouldHaveLabels: anObject [
	shouldHaveLabels := anObject
]

{ #category : #accessing }
RSTickConfiguration >> shouldUseNiceLabel [
	^ shouldUseNiceLabel
]

{ #category : #accessing }
RSTickConfiguration >> shouldUseNiceLabel: aBool [
	shouldUseNiceLabel := aBool
]

{ #category : #accessing }
RSTickConfiguration >> tickSize [
	^ tickSize
]

{ #category : #accessing }
RSTickConfiguration >> tickSize: anObject [
	tickSize := anObject
]
