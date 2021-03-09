"
A horizontal tick but in top of the chart, takes values from RSChart 
"
Class {
	#name : #RSTopHorizontalTick,
	#superclass : #RSAbstractTick,
	#instVars : [
		'values'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #rendering }
RSTopHorizontalTick >> createTickLineFor: aNumber [
	| value y |
	value := xScale scale: aNumber.
	y := chart extent y negated.
	^ self shape copy
		startPoint: value @ y;
		endPoint: value @ (y - self configuration tickSize);
		yourself
]

{ #category : #rendering }
RSTopHorizontalTick >> createXScale [
	| padding |
	xScale ifNil: [ xScale := NSScale linear ].
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := chart padding x.
	xScale
		domain:
			{self min.
			self max};
		range:
			{0 + padding.
			chart extent x - padding}
]

{ #category : #'accessing - defaults' }
RSTopHorizontalTick >> defaultLabelLocation [
	^ RSLocation new above offset: 0@ -3
]

{ #category : #accessing }
RSTopHorizontalTick >> max [
	^ values max
]

{ #category : #accessing }
RSTopHorizontalTick >> min [
	^ values min
]

{ #category : #accessing }
RSTopHorizontalTick >> values [
	^ values
]

{ #category : #accessing }
RSTopHorizontalTick >> values: aCollection [
	values := aCollection
]
