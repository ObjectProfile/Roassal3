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

{ #category : #accessing }
RSHorizontalTick >> max [
	^ chart maxValueX
]

{ #category : #accessing }
RSHorizontalTick >> min [
	^ chart minValueX
]

{ #category : #public }
RSHorizontalTick >> useDiagonalLabel [
	self labelRotation: -45.
	self labelLocation outer; bottom; left; offset: (self configuration fontSize * 0.5 @ 0).
]

{ #category : #public }
RSHorizontalTick >> useVerticalLabel [
	self labelRotation: -90.
]
