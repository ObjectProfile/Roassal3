"
The class for horizontal bar plots
"
Class {
	#name : #RSHorizontalBarPlot,
	#superclass : #RSAbstractBarPlot,
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
	barScale := NSOrdinalScale new 
		domain: yValues;
		rangeBands: yScale range padding: gapRatio.
	aChart yScale: barScale
]

{ #category : #hooks }
RSHorizontalBarPlot >> computeRectagleFor: aPoint [
	| origin corner sizeOffset offset |
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y).
	corner := (xScale scale: 0) @ origin y.
	sizeOffset := 0@(self barSize/ 2.0).
	offset :=0 @ self barOffset.
	^ Rectangle 
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : #rendering }
RSHorizontalBarPlot >> definedValuesX [
	"Return the list Y values that are defined"
	^ xValues, {0} select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : #testing }
RSHorizontalBarPlot >> isHorizontalBarPlot [
	^ true
]

{ #category : #hooks }
RSHorizontalBarPlot >> modelFor: aPoint [
	^ aPoint x
]
