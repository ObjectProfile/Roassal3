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
	^ self shape copy
		startPoint: (xScale scale: aNumber) @ 0;
		endPoint: (xScale scale: aNumber) @ self configuration tickSize;
		yourself
]

{ #category : #'accessing - defaults' }
RSHorizontalTick >> defaultLabelLocation [
	^ RSLocation new below
]

{ #category : #public }
RSHorizontalTick >> fromNames: aCollectionOfStrings [
	self
		doNotUseNiceLabel;
		numberOfTicks: aCollectionOfStrings size.
	self labelRotation: -45.
	self labelConversion: [ :x | 
		x isZero 
			ifTrue: [ '' ]
			ifFalse: [aCollectionOfStrings at: x  ] ].
		
]

{ #category : #accessing }
RSHorizontalTick >> max [
	^ chart maxValueX
]

{ #category : #accessing }
RSHorizontalTick >> min [
	^ chart minValueX
]
