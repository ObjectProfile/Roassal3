Class {
	#name : #RSHorizontalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Matplotlib-Core'
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
	^ RSLine new
		startPoint: (xScale scale: aNumber) @ 0;
		endPoint: (xScale scale: aNumber) @ self tickSize;
		yourself
]

{ #category : #'accessing - defaults' }
RSHorizontalTick >> defaultLabelLocation [
	^ RSLocation new below
]

{ #category : #accessing }
RSHorizontalTick >> maxValue [
	^ chart maxValueX
]

{ #category : #accessing }
RSHorizontalTick >> minValue [
	^ chart minValueX
]
