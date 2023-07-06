"
Used to draw line axis
"
Class {
	#name : #RSLineSpineDecoration,
	#superclass : #RSChartSpineDecoration,
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'axisX',
		'axisY'
	],
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #initialization }
RSLineSpineDecoration >> defaultShape [
	^ RSLine new
]

{ #category : #rendering }
RSLineSpineDecoration >> renderIn: canvas [
	| x y zeroPoint |
	axisX := self shape copy.
	zeroPoint := self zeroPoint.
	x := zeroPoint x.
	y := zeroPoint y.
	axisX startPoint: 0@ y; endPoint: plot extent x @ y.

	axisY := self shape copy.
	axisY startPoint: x @ plot extent y; endPoint: x @ 0.

	box := { axisX. axisY } asShape.
	box translateTo: (plot extent x / 2) @ (plot extent y negated / 2).
	canvas add: box
]

{ #category : #accessing }
RSLineSpineDecoration >> zeroPoint [
	| x y |
	y := (0 between: plot minValueY and: plot maxValueY)
		ifTrue: [ (plot yScale scale: 0) + plot extent y ]
		ifFalse: [ plot extent y ].
	x := (0 between: plot minValueX and: plot maxValueX)
		ifTrue: [ (plot xScale scale: 0) ]
		ifFalse: [ 0 ].
	^ x @ y
]
