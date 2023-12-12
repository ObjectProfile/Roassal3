"
<keyClass>
`RSBarPlot` is a plot that represents a bar chart.

*Responsibility*: display a bar chart, with adequate color & bar width value per default.

*Collaborators*: a bar plot is added to `RSCompositeChart`.

*Variables*:
- `barWidth`: width of a bar. A default computed value is assigned.

*Example*:
```Smalltalk
data := #(4 10 5 9).

d := RSBarPlot new.
d color: Color green darker darker darker.
d y: data.

d verticalTick integer.

d addDecoration: (RSYLabelDecoration new title: 'Difference'; rotationAngle: -90; offset: -25 @ 0).
d addDecoration: (RSXLabelDecoration new title: 'Evolution').
d
```
"
Class {
	#name : 'RSBarPlot',
	#superclass : 'RSAbstractBarPlot',
	#instVars : [
		'bottom',
		'errors',
		'errorLines',
		'errorLine'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSBarPlot >> barScale [
	^ xScale
]

{ #category : 'rendering' }
RSBarPlot >> beforeRenderingIn: aChart [

	| barScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	barScale := NSOrdinalScale new
		domain: xValues;
		rangeBands: xScale range padding: gapRatio.
	aChart xScale: barScale
]

{ #category : 'accessing' }
RSBarPlot >> bottom [
	^ bottom
]

{ #category : 'accessing' }
RSBarPlot >> bottom: aCollection [
	self
		assert: xValues size = aCollection size
		description: 'Invalid size'.
	bottom := aCollection
]

{ #category : 'testing' }
RSBarPlot >> canHandleCluster [
	^ true
]

{ #category : 'hooks' }
RSBarPlot >> computeRectagleFor: aPoint index: index [
	| origin corner sizeOffset offset zero |
	zero := 0.
	bottom ifNotNil: [ zero := bottom at: index ].
	origin := self scalePoint: aPoint + (0@ zero).
	corner := origin x @ (yScale scale: zero ).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	^ Rectangle
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : 'defaults' }
RSBarPlot >> defaultErrorLine [
	^ RSLine new
		color: Color black;
		yourself
]

{ #category : 'rendering' }
RSBarPlot >> definedValuesY [
	"Return the list Y values that are defined"
	| res |
	res := yValues.
	bottom ifNotNil: [ res := res + bottom ].
	errors ifNotNil: [ res := res + errors ].
	^ res, {0}
]

{ #category : 'accessing' }
RSBarPlot >> errorLine [
	^ errorLine
]

{ #category : 'accessing' }
RSBarPlot >> errorLines [
	^ errorLines
]

{ #category : 'accessing' }
RSBarPlot >> errors: anArray [
	self assert: anArray isCollection description: 'you should provide a collection'.
	self assert: (anArray allSatisfy: [ :each | each isNumber ]) description: 'you should provide a number'.
	self assert: yValues size = anArray size description: 'both collections should have the same size'.
	errors := anArray
]

{ #category : 'initialization' }
RSBarPlot >> initialize [
	super initialize.
	errorLine := self defaultErrorLine
]

{ #category : 'testing' }
RSBarPlot >> isVerticalBarPlot [
	^ true
]

{ #category : 'hooks' }
RSBarPlot >> modelFor: aPoint [
	^ aPoint y
]

{ #category : 'rendering' }
RSBarPlot >> newErrorLineFor: index [
	| top bar error p1 p2 errorPoint marker size |
	bar := bars at: index.
	error := errors at: index.
	top := bar encompassingRectangle topCenter.
	errorPoint := 0@(self scalePoint: 0@ error) y.
	size := self barSize / 4.
	p1 := size @ 0.
	p2 := 0 - (size @0).
	marker := { RSLine new
		color: errorLine color;
		controlPoints: { p1. p2 };
		yourself } asShape.
	p1 := top + errorPoint.
	p2 := top - errorPoint.
	^ errorLine copy
		marker: marker;
		controlPoints: { p1. p2 };
		yourself.
]

{ #category : 'rendering' }
RSBarPlot >> renderErrorLinesIfNecessary: canvas [
	errors ifNil: [ ^ self ].
	errorLines := (1 to: errors size) collect: [ :index  |  
		self newErrorLineFor: index ].	
	canvas addAll: errorLines
]

{ #category : 'rendering' }
RSBarPlot >> renderIn: canvas [
	super renderIn: canvas.
	self renderErrorLinesIfNecessary: canvas.
]
