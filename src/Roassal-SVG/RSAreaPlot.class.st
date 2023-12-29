"
TODO
"
Class {
	#name : 'RSAreaPlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'y2Values',
		'area'
	],
	#category : 'Roassal-SVG-Chart',
	#package : 'Roassal-SVG',
	#tag : 'Chart'
}

{ #category : 'rendering' }
RSAreaPlot >> addPointAt: index in: s [
	| xval y1val y2val |
	index > xValues size ifTrue: [ ^ self ].
	s << (index = 1
		ifTrue: [ 'M' ]
		ifFalse: [ 'L' ]).
	xval := xValues at: index.
	y1val := yValues at: index.
	s << (self pointFor: xval@y1val).
	self addPointAt: index + 1 in: s.
	y2Values isNumber ifTrue: [
		index = 1 ifTrue: [
			s << 'L'.
			y2val := y2Values.
			s << (self pointFor: xValues last @ y2val).
			s << 'L'.
			s << (self pointFor: xValues first @ y2val).
			s << 'Z'. ]
	] ifFalse: [
		s << 'L'.
		y2val := y2Values at: index.
		s << (self pointFor: xval@y2val).
		index = 1 ifTrue: [ s << 'Z' ].
	 ]
]

{ #category : 'accessing' }
RSAreaPlot >> area [
	^ area
]

{ #category : 'rendering' }
RSAreaPlot >> computePath [
	^ String streamContents: [ :s |
		self addPointAt: 1 in: s ]
]

{ #category : 'accessing' }
RSAreaPlot >> createdShapes [
	^ {area}
]

{ #category : 'accessing - defaults' }
RSAreaPlot >> defaultShape [
	^ RSSVGPath new noPaint
]

{ #category : 'rendering' }
RSAreaPlot >> definedValuesY [
	| temp|
	temp := y2Values.
	temp isNumber ifTrue: [ temp := { temp } ].
	^ yValues , temp select: [ :v | v isNaN not and: [ v isInfinite not ] ]
]

{ #category : 'rendering' }
RSAreaPlot >> pointFor: aPoint [
	| spoint |
	spoint := (xScale scale: aPoint x) @ (yScale scale: aPoint y).
	self
		assert: (self isPointWellDefined: spoint)
		description: 'can not use invalid point to plot the graph'.
	^ spoint x asFloat printString,' ',spoint y asFloat printString
]

{ #category : 'rendering' }
RSAreaPlot >> renderIn: canvas [
	super renderIn: canvas.
	canvas add: (area := self shape copy
		color: self computeColor;
		svgPath: self computePath;
		yourself)
]

{ #category : 'public' }
RSAreaPlot >> x: aCollection1 y1: aCollection2 y2: aCollection3OrNumber [
	"collections should have the same size"
	xValues := aCollection1.
	yValues := aCollection2.
	y2Values := aCollection3OrNumber
]

{ #category : 'public' }
RSAreaPlot >> x: aCollection y: aCollection2 [
	self shouldNotImplement
]

{ #category : 'public' }
RSAreaPlot >> y: aCollection [
	self shouldNotImplement
]
