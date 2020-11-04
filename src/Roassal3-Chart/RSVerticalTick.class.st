"
<keyClass>
`RSVerticalTick` defines ticks for the vertical axis. It is a decoration that can be added to a `RSChart`.

*Responsibility*: define, customize, and render ticks

*Collaborators*: `RSVerticalTick` is added to `RSChart`

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
	^ self shape copy
		startPoint: 0 @ scaledNumber;
		endPoint: self configuration tickSize negated @ scaledNumber;
		yourself
]

{ #category : #'accessing - defaults' }
RSVerticalTick >> defaultLabelLocation [
	^ RSLocation new outer; left; offset: -2@0
]

{ #category : #accessing }
RSVerticalTick >> max [
	^ chart maxValueY
]

{ #category : #accessing }
RSVerticalTick >> min [
	^ chart minValueY
]
