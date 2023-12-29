"
Used to draw line axis
"
Class {
	#name : 'RSLineSpineDecoration',
	#superclass : 'RSChartSpineDecoration',
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'axisX',
		'axisY'
	],
	#category : 'Roassal-Chart-Decoration',
	#package : 'Roassal-Chart',
	#tag : 'Decoration'
}

{ #category : 'initialization' }
RSLineSpineDecoration >> defaultShape [
	^ RSLine new
]

{ #category : 'rendering' }
RSLineSpineDecoration >> renderIn: canvas [
	| x y zeroPoint |
	axisX := self shape copy.
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

{ #category : 'accessing' }
RSLineSpineDecoration >> zeroPoint [
	| x y |
	y := (0 between: chart minChartValueY and: chart maxChartValueY)
		ifTrue: [ (chart yScale scale: 0) + chart extent y ]
		ifFalse: [ chart extent y ].
	x := (0 between: chart minChartValueX and: chart maxChartValueX)
		ifTrue: [ (chart xScale scale: 0) ]
		ifFalse: [ 0 ].
	^ x @ y
]
