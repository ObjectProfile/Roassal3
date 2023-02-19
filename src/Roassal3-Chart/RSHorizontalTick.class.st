"
<keyClass>
`RSHorizontalTick` defines ticks for the horizontal axis. It is a decoration that can be added to a `RSChart`.

*Responsibility*: define, customize, and render ticks

*Collaborators*: `RSHorizontalTick` is added to `RSChart`

*Example*:
```Smalltalk
	x := -3.14 to: 3.14 by: 0.01.
	c := RSChart new.
	p := RSLinePlot new.
	p x: x y: x sin * 0.22 + 0.5.
	c addPlot: p.
	c addDecoration: RSHorizontalTick new.
	c addDecoration: RSVerticalTick new asFloat.
	c
```
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
	| value zeroY |
	value := xScale scale: aNumber.
	zeroY := chart spineDecoration zeroPoint y.
	zeroY := zeroY - chart extent y.
	^ self shape copy
		startPoint: value @ zeroY;
		endPoint: value @ (zeroY + self configuration tickSize);
		yourself
]

{ #category : #'accessing - defaults' }
RSHorizontalTick >> defaultLabelLocation [
	^ RSLocation new below offset: 0@3
]

{ #category : #testing }
RSHorizontalTick >> isHorizontalTick [
	^ true
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
	self labelLocation outer; bottom; left; offset: (self configuration fontSize * 0.5 @ 0)
]

{ #category : #public }
RSHorizontalTick >> useVerticalLabel [
	self labelRotation: -90
]
