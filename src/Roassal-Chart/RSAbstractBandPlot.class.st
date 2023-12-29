"
`RSAbstractBandPlot` is an abstract kind of plot that will show some graphics inside of bands. In this way a band plot have two main properties: the bands width and the bands offset.

**Responsibility:**
- This class abstracts the common behavior and the concept of the bands.

**Collaborators:** 
- **`NSOrdinalScale`:** This class allows rendering each graphic in one band by assigning the `bandWidth` and the `bandOffset`. In this way, each graphic (`RSBoxShape`, `RSViolinPlotShape`)  knows which part of the canvas it needs to fill.

**Public API and Key Messages**

**Instance Variables:**

**Example:**

"
Class {
	#name : 'RSAbstractBandPlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'bandScale',
		'dataScale',
		'bandWidth',
		'offset',
		'horizontal',
		'bandPlotShapes',
		'positions'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'rendering' }
RSAbstractBandPlot >> assignXAndYScales: aChart [
	bandScale class = NSOrdinalScale ifFalse: [
		self computeScales: aChart. ].
	horizontal ifFalse: [
		xScale := bandScale.
		dataScale := self yScale. ]
	ifTrue: [
		yScale := bandScale.
		dataScale := self xScale. ].
	aChart yScale: yScale.
	aChart xScale: xScale
]

{ #category : 'rendering' }
RSAbstractBandPlot >> bandScale: aNSScale [
	bandScale := aNSScale
]

{ #category : 'rendering' }
RSAbstractBandPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : 'rendering' }
RSAbstractBandPlot >> bandsWidth [
	^ bandWidth ifNil: [ bandWidth := self defaultBandsWidth ]
]

{ #category : 'rendering' }
RSAbstractBandPlot >> bandsWidth: aNumber [
	bandWidth := aNumber
]

{ #category : 'rendering' }
RSAbstractBandPlot >> beforeRenderingIn: aChart [
	self computeXAndYValues.
	super beforeRenderingIn: aChart.
	self computeTicks.
	self assignXAndYScales: aChart
]

{ #category : 'rendering' }
RSAbstractBandPlot >> computeBandsOffset [
	| bandValues |
	bandValues := horizontal ifFalse: [ xValues ] ifTrue: [ yValues ].
	bandPlotShapes doWithIndex: [ :graphic :idx |
		graphic bandOffset: (bandScale scale: (bandValues at: idx)) + offset
	]
]

{ #category : 'rendering' }
RSAbstractBandPlot >> computeBandsWidth [
	bandPlotShapes do: [ :graphic | graphic bandWidth: self bandsWidth ]
]

{ #category : 'rendering' }
RSAbstractBandPlot >> computeScales: aChart [
	bandScale := NSScale ordinal.
	horizontal ifFalse: [
		bandScale domain: xValues copy asOrderedCollection sort.
		bandScale rangeBands: { 0. aChart extent x. }. ]
	ifTrue: [
		bandScale domain: yValues copy asOrderedCollection sort.
		"important to use the corresponding range of the spine"
		bandScale rangeBands: yScale range.  ]
]

{ #category : 'rendering' }
RSAbstractBandPlot >> computeTicks [
	| horizontalTick verticalTick |
	horizontal
		ifFalse: [
			horizontalTick := self horizontalTick.
			horizontalTick ifNotNil: [
				horizontalTick isTicksDataNil ifTrue: [ self xTicks: xValues labels: xValues ] ].
		 ]
		ifTrue: [
			verticalTick := self verticalTick.
			verticalTick ifNotNil: [
				verticalTick isTicksDataNil ifTrue: [ self yTicks: yValues labels: yValues ] ].
		 ]
]

{ #category : 'private' }
RSAbstractBandPlot >> computeXAndYValues [
	| dataValues bandPositions maxDataRelatedValue minDataRelatedValue |
	maxDataRelatedValue := (bandPlotShapes collect: [ :bandPlotShape | bandPlotShape maxDataValue ]) max.
	minDataRelatedValue := (bandPlotShapes collect: [ :bandPlotShape | bandPlotShape minDataValue ]) min.
	dataValues := {minDataRelatedValue. maxDataRelatedValue.}.
	bandPositions := self positions.
	horizontal
		ifTrue: [
			xValues := dataValues.
			yValues := bandPositions ]
		ifFalse: [
			xValues := bandPositions.
			yValues := dataValues  ]
]

{ #category : 'accessing' }
RSAbstractBandPlot >> createdShapes [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RSAbstractBandPlot >> defaultBandsWidth [
	^ bandScale rangeBand * 0.5
]

{ #category : 'accessing' }
RSAbstractBandPlot >> defaultOffset [
	^ bandScale scale: 0
]

{ #category : 'public' }
RSAbstractBandPlot >> horizontal [
	bandPlotShapes do: [ :bs | bs horizontal ].
	horizontal := true
]

{ #category : 'accessing' }
RSAbstractBandPlot >> isHorizontal [
	^ horizontal
]

{ #category : 'accessing - defaults' }
RSAbstractBandPlot >> numberOfBands [
	^ bandPlotShapes size
]

{ #category : 'accessing - defaults' }
RSAbstractBandPlot >> positions [
	positions := positions ifNil: [(1 to: self numberOfBands)].
	^ positions
]

{ #category : 'accessing - defaults' }
RSAbstractBandPlot >> positions: aCollection [
	self
		assert: [ aCollection size = bandPlotShapes size ]
		description: 'The positions collection must have the same size of bandPlotShapes'.
	positions := aCollection
]

{ #category : 'rendering' }
RSAbstractBandPlot >> showBands [
	bandPlotShapes do: [ :box | box showBand ]
]

{ #category : 'public' }
RSAbstractBandPlot >> vertical [
	bandPlotShapes do: [ :bs | bs vertical ].
	horizontal := false
]
