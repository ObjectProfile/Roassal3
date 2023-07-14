Class {
	#name : #RSViolinPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'xlabel',
		'ylabel',
		'title',
		'violinShapes',
		'offset',
		'bandWidth'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| boxPlot |
	boxPlot := self new.
	boxPlot data: aCollection.
	^ boxPlot
]

{ #category : #rendering }
RSViolinPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : #rendering }
RSViolinPlot >> bandsWidth: aNumber [
	bandWidth := aNumber.
]

{ #category : #rendering }
RSViolinPlot >> beforeRenderingIn: aChart [
	| bandScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	bandScale := NSScale ordinal
		domain: xValues;
		rangeBands: { 0. aChart extent x. }.
	aChart xScale: bandScale.
]

{ #category : #rendering }
RSViolinPlot >> buildChart [
	chart add: self.
	chart
		extent: 360 @ 300;
		padding: 15;
		build.
	^ chart
]

{ #category : #initialization }
RSViolinPlot >> canHandleCluster [
	^ true
]

{ #category : #rendering }
RSViolinPlot >> computeBandsOffset [
	violinShapes doWithIndex: [ :boxShape :idx |
		boxShape bandOffset: (xScale scale: (xValues at: idx)) + offset
	].
]

{ #category : #rendering }
RSViolinPlot >> computeBandsWidth [
	violinShapes do: [ :boxShape | boxShape bandWidth: bandWidth ].
]

{ #category : #initialization }
RSViolinPlot >> computeState [
	self computeXValues.
	self computeYValues.
	"self computeDefualtXTicks."
]

{ #category : #rendering }
RSViolinPlot >> computeXValues [
	xValues := (1 to: self numberOfViolins).
]

{ #category : #initialization }
RSViolinPlot >> computeYValues [
	| yMax yMin |
	yMax := (violinShapes collect: [ :violinShape | violinShape maxYValue ]) max.
	yMin := (violinShapes collect: [ :violinShape | violinShape minYValue ]) min.
	yValues := {yMin. yMax.}.
]

{ #category : #accessing }
RSViolinPlot >> createdShapes [
	^ violinShapes
]

{ #category : #rendering }
RSViolinPlot >> data: aCollection [
	| collectionOfDatasets |
	
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	self violinShapes: (collectionOfDatasets collect: [ :dataSet | RSViolinPlotShape data: dataSet]).
	"self computeBoxGraphicsCenters."
	self computeState.
]

{ #category : #rendering }
RSViolinPlot >> defaultBandsWidth [
	^ xScale scale: 1
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolygon new
		noPaint.
]

{ #category : #rendering }
RSViolinPlot >> initialize [
	super initialize.
	chart := RSChart new.
]

{ #category : #rendering }
RSViolinPlot >> numberOfViolins [
	^ violinShapes size
]

{ #category : #rendering }
RSViolinPlot >> open [
	^ self buildChart open.
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	offset ifNil: [ offset := 1 ].
	self computeBandsOffset.
	
	bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
	self computeBandsWidth.
	
	violinShapes doWithIndex: [ :aRSBoxPlotShape :idx |
		aRSBoxPlotShape color: self computeColor.
		aRSBoxPlotShape scales: {
				self xScale.
				self yScale }.
		aRSBoxPlotShape renderIn: canvas ]
]

{ #category : #rendering }
RSViolinPlot >> violinShapes: collectionOfRSViolinPlotShapes [
	violinShapes := collectionOfRSViolinPlotShapes
	
]
