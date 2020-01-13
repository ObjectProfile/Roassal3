Class {
	#name : #RSVerticalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSVerticalTick >> createNiceLabelIn: aChart [
	| nice |
	nice := super createNiceLabelIn: aChart.
	aChart 
		minValueY: nice min;
		maxValueY: nice max.
	^ nice
]

{ #category : #rendering }
RSVerticalTick >> createTickLineFor: aNumber [
	^ RSLine new
		startPoint: 0 @ (yScale scale: aNumber);
		endPoint: self tickSize negated @ (yScale scale: aNumber);
		yourself
]

{ #category : #'accessing - defaults' }
RSVerticalTick >> defaultLabelLocation [
	^ RSLocation new outer; left
]

{ #category : #accessing }
RSVerticalTick >> maxValue [
	^ chart maxValueY
]

{ #category : #accessing }
RSVerticalTick >> minValue [
	^ chart minValueY
]
