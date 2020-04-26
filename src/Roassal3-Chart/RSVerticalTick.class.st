Class {
	#name : #RSVerticalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Chart-Core'
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
	scaledNumber isNaN ifTrue: [ 
		yScale domain: { Float epsilon.  yScale domain second }.
		scaledNumber := yScale scale: Float epsilon ].
	self assert: [ scaledNumber isNaN not ].
	^ RSLine new
		startPoint: 0 @ scaledNumber;
		endPoint: self tickSize negated @ scaledNumber;
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
