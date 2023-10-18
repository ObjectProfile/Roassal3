"
<keyClass>
`RSVerticalTick` defines ticks for the vertical axis. It is a decoration that can be added to a `RSChart`.

*Responsibility*: define, customize, and render ticks

*Collaborators*: `RSVerticalTick` is added to `RSChart`

*Example*:
```Smalltalk
	x := -3.14 to: 3.14 by: 0.01.
	p := RSLinePlot new.
	p x: x y: x sin * 0.22 + 0.5.
	p verticalTick asFloat.
	p
```
"
Class {
	#name : 'RSVerticalTick',
	#superclass : 'RSAbstractTick',
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'rendering' }
RSVerticalTick >> createTickLineFor: aNumber [
	| scaledNumber zeroX |
	scaledNumber := yScale scale: aNumber.
	zeroX := self chart spineDecoration zeroPoint x.

	^ self newLineTick
		startPoint: zeroX @ scaledNumber;
		endPoint: zeroX - self configuration tickSize @ scaledNumber;
		yourself
]

{ #category : 'accessing - defaults' }
RSVerticalTick >> defaultLabelLocation [
	^ RSLocation new outer; left; offset: -2@0
]

{ #category : 'testing' }
RSVerticalTick >> isVerticalTick [
	^ true
]

{ #category : 'accessing' }
RSVerticalTick >> max [
	^ chart maxValueY
]

{ #category : 'accessing' }
RSVerticalTick >> min [
	^ chart minValueY
]

{ #category : 'rendering' }
RSVerticalTick >> updateChartMaxAndMinValues: aChart [

	aChart
		minChartValueY: self ticksData first;
		maxChartValueY: self ticksData last
]
