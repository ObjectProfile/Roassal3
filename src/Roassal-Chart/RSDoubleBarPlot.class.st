"
RSDoubleBarPlot renders 2 different bars
"
Class {
	#name : 'RSDoubleBarPlot',
	#superclass : 'RSHorizontalBarPlot',
	#instVars : [
		'x2Values',
		'secondColor',
		'x2Scale',
		'bars2',
		'horizontalTopTick'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSDoubleBarPlot >> bars2 [
	^ bars2
]

{ #category : 'accessing - computed' }
RSDoubleBarPlot >> computeSecondColor [
	^ secondColor ifNil: [ self chart colorFor: x2Values ]
]

{ #category : 'hooks' }
RSDoubleBarPlot >> computeSecondRectagleFor: aPoint index: index [
	| origin corner sizeOffset offset zero |
	zero := 0.
	left ifNotNil: [ zero := left at: index ].
	origin := (x2Scale scale: aPoint x) @ (yScale scale: aPoint y).
	corner := (x2Scale scale: zero) @ origin y.
	sizeOffset := 0@(self barSize * 0.3).
	offset := 0@ self barOffset.
	^ Rectangle
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : 'rendering' }
RSDoubleBarPlot >> createBar2For: aPoint index: index [
	^ self shape copy
		model: (self modelFor: aPoint);
		color: self computeSecondColor;
		fromRectangle: (self computeSecondRectagleFor: aPoint index: index);
		yourself
]

{ #category : 'rendering' }
RSDoubleBarPlot >> createXScale [
	| padding |
	super createXScale.
	x2Scale ifNil: [ x2Scale := NSScale linear ].
	x2Scale class = NSOrdinalScale ifTrue: [ ^ self ].
	padding := self padding x.
	x2Scale
		domain:
			{x2Values min min: 0.
			x2Values max max: 0};
		range:
			{0 + padding.
			self extent x - padding}
]

{ #category : 'accessing' }
RSDoubleBarPlot >> createdShapes [
	^ bars, bars2
]

{ #category : 'accessing' }
RSDoubleBarPlot >> horizontalTopTick [

	^ horizontalTopTick
]

{ #category : 'initialization' }
RSDoubleBarPlot >> initializeDecorations [

	super initializeDecorations.
	horizontalTopTick := RSHorizontalTopTick new.
	self addDecoration: horizontalTopTick
]

{ #category : 'public' }
RSDoubleBarPlot >> rawData: aCollection x1: bloc1 x2: bloc2 y: bloc3 [

	rawData := aCollection.
	self
		x1: (rawData collect: bloc1)
		x2: (rawData collect: bloc2)
		y: (rawData collect: bloc3)
]

{ #category : 'rendering' }
RSDoubleBarPlot >> renderIn: canvas [

	| index |
	super renderIn: canvas.
	index := 1.
	bars2 := x2Values
		         collect: [ :xt |
			         | yt bar |
			         yt := yValues at: index.
			         bar := self createBar2For: xt @ yt index: index.
			         index := index + 1.
			         bar ]
		         as: RSGroup.
	canvas addAll: bars2
]

{ #category : 'accessing' }
RSDoubleBarPlot >> secondColor [
	^ secondColor
]

{ #category : 'public' }
RSDoubleBarPlot >> x1: x1 x2: x2 y: y [
	self assert: x1 size = x2 size description: 'The two collections must have the same size'.
	self x: x1 y: y.
	x2Values := x2.
	horizontalTopTick values: x2Values
]

{ #category : 'accessing' }
RSDoubleBarPlot >> x2Scale [

	^ x2Scale
]

{ #category : 'accessing' }
RSDoubleBarPlot >> x2Values [
	^ x2Values
]
