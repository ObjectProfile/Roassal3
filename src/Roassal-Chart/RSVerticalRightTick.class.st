"
Similar to vertical tick and hortizonal top tick
"
Class {
	#name : 'RSVerticalRightTick',
	#superclass : 'RSAbstractTick',
	#instVars : [
		'values'
	],
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'rendering' }
RSVerticalRightTick >> beforeRenderingIn: aChart [

	self createXScale.
	self createYScale
]

{ #category : 'rendering' }
RSVerticalRightTick >> createTickLineFor: aNumber [
	| scaledNumber x |
	scaledNumber := yScale scale: aNumber.
	x := chart extent x.
	^ self newLineTick
		startPoint: x @ scaledNumber;
		endPoint: (x + self configuration tickSize) @ scaledNumber;
		yourself
]

{ #category : 'rendering' }
RSVerticalRightTick >> createYScale [

	| padding |
	yScale ifNil: [ yScale := NSScale linear ].
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding y.
	yScale
		domain: {
				self min.
				self max };
		range: {
				(0 - padding).
				(chart extent y negated + padding) }
]

{ #category : 'accessing - defaults' }
RSVerticalRightTick >> defaultLabelLocation [
	^ RSLocation new outer; right; offset: 2@0
]

{ #category : 'testing' }
RSVerticalRightTick >> isVerticalTick [

	^ true
]

{ #category : 'accessing' }
RSVerticalRightTick >> max [
	^ values max
]

{ #category : 'accessing' }
RSVerticalRightTick >> min [
	^ values min
]

{ #category : 'rendering' }
RSVerticalRightTick >> updateChartMaxAndMinValues: aChart [
]

{ #category : 'accessing' }
RSVerticalRightTick >> values [

	^ values
]

{ #category : 'accessing' }
RSVerticalRightTick >> values: anObject [

	values := anObject
]
