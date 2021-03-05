"
Similar to vertical tick and hortizonal top tick
"
Class {
	#name : #RSVerticalRightTick,
	#superclass : #RSAbstractTick,
	#instVars : [
		'values'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #rendering }
RSVerticalRightTick >> createTickLineFor: aNumber [
	| scaledNumber x |
	scaledNumber := yScale scale: aNumber.
	x := chart extent x.
	^ self shape copy
		startPoint: x @ scaledNumber;
		endPoint: (x + self configuration tickSize) @ scaledNumber;
		yourself
]

{ #category : #'accessing - defaults' }
RSVerticalRightTick >> defaultLabelLocation [
	^ RSLocation new outer; right; offset: 2@0
]

{ #category : #accessing }
RSVerticalRightTick >> max [
	^ values max
]

{ #category : #accessing }
RSVerticalRightTick >> min [
	^ values min
]

{ #category : #accessing }
RSVerticalRightTick >> values [

	^ values
]

{ #category : #accessing }
RSVerticalRightTick >> values: anObject [

	values := anObject
]
