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
	#name : #RSAbstractBandPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'bandScale',
		'dataScale',
		'bandWidth',
		'offset',
		'horizontal',
		'bandPlotShapes'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractBandPlot >> assignXAndYScales: aChart [
	bandScale := NSScale ordinal.
	horizontal ifFalse: [
		bandScale domain: xValues. 
		bandScale rangeBands: { 0. aChart extent x. }.
		xScale := bandScale.
		dataScale := self yScale. ]
	ifTrue: [ 
		bandScale domain: yValues.
		"important to use the corresponding range of the spine"
		bandScale rangeBands: yScale range. 
		yScale := bandScale.
		dataScale := self xScale. ].
	aChart yScale: yScale.
	aChart xScale: xScale.
]

{ #category : #'accessing - defaults' }
RSAbstractBandPlot >> bandValues [
	^ self subclassResponsibility
]

{ #category : #rendering }
RSAbstractBandPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : #rendering }
RSAbstractBandPlot >> bandsWidth [
	^ bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
]

{ #category : #rendering }
RSAbstractBandPlot >> bandsWidth: aNumber [
	bandWidth := aNumber.
]

{ #category : #rendering }
RSAbstractBandPlot >> beforeRenderingIn: aChart [
	| horizontalTicks verticalTicks |
	self computeXAndYValues.
	super beforeRenderingIn: aChart.
	horizontal ifFalse: [
		horizontalTicks := (decorations select: [ :dec | dec isHorizontalTick ]).
		horizontalTicks isNotEmpty ifTrue: [ horizontalTicks first configuration numberOfTicks: xValues size].]
	ifTrue: [ 
		verticalTicks := (decorations select: [ :dec | dec isVerticalTick ]).
		verticalTicks isNotEmpty ifTrue: [ verticalTicks first configuration numberOfTicks: yValues size].
		 ].
	self assignXAndYScales: aChart.
]

{ #category : #rendering }
RSAbstractBandPlot >> computeBandsOffset [
	| bandValues |
	bandValues := horizontal ifFalse: [ xValues ] ifTrue: [ yValues ].
	bandPlotShapes doWithIndex: [ :graphic :idx |
		graphic bandOffset: (bandScale scale: (bandValues at: idx)) + offset
	].
]

{ #category : #rendering }
RSAbstractBandPlot >> computeBandsWidth [
	bandPlotShapes do: [ :graphic | graphic bandWidth: self bandsWidth ].
]

{ #category : #private }
RSAbstractBandPlot >> computeXAndYValues [
	| dataValues bandValues maxDataRelatedValue minDataRelatedValue |
	maxDataRelatedValue := (bandPlotShapes collect: [ :bandPlotShape | bandPlotShape maxYValue ]) max.
	minDataRelatedValue := (bandPlotShapes collect: [ :bandPlotShape | bandPlotShape minYValue ]) min.
	dataValues := {minDataRelatedValue. maxDataRelatedValue.}.
	bandValues := self bandValues.
	horizontal 
		ifTrue: [ 
			xValues := dataValues.
			yValues := bandValues ]
		ifFalse: [ 
			xValues := bandValues.
			yValues := dataValues  ]
]

{ #category : #accessing }
RSAbstractBandPlot >> createdShapes [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlot >> defaultBandsWidth [
	^ bandScale scale: 1
]

{ #category : #'accessing - defaults' }
RSAbstractBandPlot >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlot >> horizontal [
	bandPlotShapes do: [ :bs | bs horizontal ].
	horizontal := true.
]

{ #category : #rendering }
RSAbstractBandPlot >> showBands [
	bandPlotShapes do: [ :box | box showBand ]
]

{ #category : #accessing }
RSAbstractBandPlot >> vertical [
	bandPlotShapes do: [ :bs | bs vertical ].
	horizontal := false.
]
