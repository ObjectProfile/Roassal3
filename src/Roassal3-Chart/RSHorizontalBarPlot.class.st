"
The class for horizontal bar plots
"
Class {
	#name : #RSHorizontalBarPlot,
	#superclass : #RSAbstractBarPlot,
	#instVars : [
		'left'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSHorizontalBarPlot >> barScale [
	^ yScale
]

{ #category : #rendering }
RSHorizontalBarPlot >> beforeRenderingIn: aChart [
	| barScale |
	super beforeRenderingIn: aChart.
	yScale class = NSOrdinalScale ifTrue: [ ^ self ].
	barScale := NSOrdinalScale new 
		domain: yValues;
		rangeBands: yScale range padding: gapRatio.
	aChart yScale: barScale
]

{ #category : #hooks }
RSHorizontalBarPlot >> computeRectagleFor: aPoint index: index [
	| origin corner sizeOffset offset zero |
	zero := 0.
	left ifNotNil: [ zero := left at: index ].
	origin := self scalePoint: aPoint.
	corner := (xScale scale: zero) @ origin y.
	sizeOffset := 0@(self barSize/ 2.0).
	offset := 0@self barOffset.
	^ Rectangle 
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : #rendering }
RSHorizontalBarPlot >> definedValuesX [
	"Return the list Y values that are defined"
	| res |
	res := xValues.
	left ifNotNil: [ res := xValues + left ].
	^ res, {0}
]

{ #category : #testing }
RSHorizontalBarPlot >> isHorizontalBarPlot [
	^ true
]

{ #category : #accessing }
RSHorizontalBarPlot >> left [
	^ left
]

{ #category : #accessing }
RSHorizontalBarPlot >> left: aCollection [
	self 
		assert: yValues size = aCollection size
		description: 'Invalid size'.
	left := aCollection
]

{ #category : #hooks }
RSHorizontalBarPlot >> modelFor: aPoint [
	^ aPoint x
]
