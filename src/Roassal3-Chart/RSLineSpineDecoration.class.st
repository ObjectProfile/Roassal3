"
Used to draw line axis
"
Class {
	#name : #RSLineSpineDecoration,
	#superclass : #RSChartSpineDecoration,
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
	| x y plot zeroPoint |
	axisX := self shape copy.
	plot := chart plots anyOne.
	zeroPoint := self zeroPoint.
	x := zeroPoint x.
	y := zeroPoint y.
	axisX startPoint: 0@ y; endPoint: chart extent x @ y.

	axisY := self shape copy.
	axisY startPoint: x @ chart extent y; endPoint: x @ 0.

	box := { axisX. axisY } asShape.
	box translateTo: (chart extent x / 2) @ (chart extent y negated / 2).
	canvas add: box
]

{ #category : #accessing }
RSLineSpineDecoration >> zeroPoint [
	| plot x y |
	plot := chart plots first.
	y := (0 between: chart minValueY and: chart maxValueY)
		ifTrue: [ (plot yScale scale: 0) + chart extent y ]
		ifFalse: [ chart extent y ].
	x := (0 between: chart minValueX and: chart maxValueX)
		ifTrue: [ (plot xScale scale: 0) ]
		ifFalse: [ 0 ].
	^ x @ y
]
