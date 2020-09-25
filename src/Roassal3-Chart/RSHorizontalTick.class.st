"
TODO
"
Class {
	#name : #RSHorizontalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #rendering }
RSHorizontalTick >> createNiceLabelIn: aChart [
	| nice |
	nice := super createNiceLabelIn: aChart.
	aChart 
		minValueX: nice min;
		maxValueX: nice max.
	^ nice
]

{ #category : #rendering }
RSHorizontalTick >> createTickLineFor: aNumber [
	| value |
	value := xScale scale: aNumber.
	^ self shape copy
		startPoint: value @ 0;
		endPoint: value @ self configuration tickSize;
		yourself
]

{ #category : #'accessing - defaults' }
RSHorizontalTick >> defaultLabelLocation [
	^ RSLocation new below offset: 0@3
]

{ #category : #public }
RSHorizontalTick >> fromNames: aCollectionOfStrings [
	self
		doNotUseNiceLabel;
		numberOfTicks: aCollectionOfStrings size-1.
	self labelRotation: -45.
	self labelConversion: [ :x | 
		x isZero 
			ifTrue: [ '' ]
			ifFalse: [aCollectionOfStrings at: x asInteger ] ].
		
]

{ #category : #accessing }
RSHorizontalTick >> max [
	^ chart maxValueX
]

{ #category : #accessing }
RSHorizontalTick >> min [
	^ chart minValueX
]
