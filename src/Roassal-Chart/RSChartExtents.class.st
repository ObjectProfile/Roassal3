"
This class provides some extents for RSChart

- extent: the extent of one chart
- max min: for each axis of this 2d chart
- padding: an internal gap between plots and base rectangle
"
Class {
	#name : 'RSChartExtents',
	#superclass : 'RSObject',
	#instVars : [
		'extent',
		'maxValueX',
		'maxValueY',
		'minValueX',
		'minValueY',
		'padding'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSChartExtents >> extent [
	^ extent
]

{ #category : 'accessing' }
RSChartExtents >> extent: aPoint [
	extent := aPoint
]

{ #category : 'accessing' }
RSChartExtents >> maxValueX [
	^ maxValueX
]

{ #category : 'accessing' }
RSChartExtents >> maxValueX: aNumber [
	maxValueX := aNumber
]

{ #category : 'accessing' }
RSChartExtents >> maxValueY [
	^ maxValueY
]

{ #category : 'accessing' }
RSChartExtents >> maxValueY: aNumber [
	maxValueY := aNumber
]

{ #category : 'accessing' }
RSChartExtents >> minValueX [
	^ minValueX
]

{ #category : 'accessing' }
RSChartExtents >> minValueX: aNumber [
	minValueX := aNumber
]

{ #category : 'accessing' }
RSChartExtents >> minValueY [
	^ minValueY
]

{ #category : 'accessing' }
RSChartExtents >> minValueY: aNumber [
	minValueY := aNumber
]

{ #category : 'accessing' }
RSChartExtents >> padding [
	^ padding ifNil: [ padding := 0@0 ]
]

{ #category : 'accessing' }
RSChartExtents >> padding: aPoint [
	padding := aPoint
]
