"
<keyClass>
`RSHorizontalTick` defines ticks for the horizontal axis. It is a decoration that can be added to a `RSChart`.

*Responsibility*: define, customize, and render ticks

*Collaborators*: `RSHorizontalTick` is added to `RSChart`

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
	#name : 'RSHorizontalTick',
	#superclass : 'RSAbstractTick',
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'rendering' }
RSHorizontalTick >> createTickLineFor: aNumber [
	| value zeroY |
	value := xScale scale: aNumber.
	zeroY := self chart spineDecoration zeroPoint y.
	zeroY := zeroY - self chart extent y.
	^ self newLineTick
		startPoint: value @ zeroY;
		endPoint: value @ (zeroY + self configuration tickSize);
		yourself
]

{ #category : 'accessing - defaults' }
RSHorizontalTick >> defaultLabelLocation [
	^ RSLocation new below offset: 0@3
]

{ #category : 'testing' }
RSHorizontalTick >> isHorizontalTick [
	^ true
]

{ #category : 'accessing' }
RSHorizontalTick >> max [
	^ chart maxValueX
]

{ #category : 'accessing' }
RSHorizontalTick >> min [
	^ chart minChartValueX
]

{ #category : 'rendering' }
RSHorizontalTick >> updateChartMaxAndMinValues: aChart [

	aChart
		minChartValueX: self ticksData first;
		maxChartValueX: self ticksData last
]

{ #category : 'public' }
RSHorizontalTick >> useDiagonalLabel [
	self labelRotation: -45.
	self labelLocation outer; bottom; left; offset: (self configuration fontSize * 0.5 @ 0)
]

{ #category : 'public' }
RSHorizontalTick >> useVerticalLabel [
	self labelRotation: -90
]
