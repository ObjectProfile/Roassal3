"
TODO
"
Class {
	#name : #RSVerticalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Chart-Ticks'
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
	| scaledNumber |
	scaledNumber := yScale scale: aNumber.
	self assert: [ scaledNumber isInfinite not ].
	self assert: [ scaledNumber isNaN not ].
	^ self shape copy
		startPoint: 0 @ scaledNumber;
		endPoint: self configuration tickSize negated @ scaledNumber;
		yourself
]

{ #category : #'accessing - defaults' }
RSVerticalTick >> defaultLabelLocation [
	^ RSLocation new outer; left
]

{ #category : #accessing }
RSVerticalTick >> max [
	^ chart maxValueY
]

{ #category : #accessing }
RSVerticalTick >> min [
	^ chart minValueY
]
