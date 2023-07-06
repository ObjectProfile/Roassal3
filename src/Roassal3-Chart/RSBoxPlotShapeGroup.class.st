Class {
	#name : #RSBoxPlotShapeGroup,
	#superclass : #RSObject,
	#instVars : [
		'boxGraphics',
		'groupOffset',
		'boxPlot'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxPlotShapeGroup class >> boxGraphics: aCollectionOfRSBoxGraphics [
	| boxGraphGroup |
	boxGraphGroup := self new.
	boxGraphGroup boxGraphics: aCollectionOfRSBoxGraphics.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxPlotShapeGroup class >> data: aCollection [
	| boxGraphGroup |
	boxGraphGroup := self new.
	boxGraphGroup data: aCollection.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxPlotShapeGroup class >> data: aCollection boxPlot: aRSBoxPlot [
	| boxGraphGroup |
	boxGraphGroup := self data: aCollection.
	boxGraphGroup boxPlot: aRSBoxPlot.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxPlotShapeGroup class >> data: aCollection scales: collectionOfNSScales [
	| boxGraphGroup |
	boxGraphGroup := self data: aCollection.
	boxGraphGroup scales: collectionOfNSScales.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> boxGraphics [
	^ boxGraphics.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> boxGraphics: aCollectionOfRSBoxGraphs [
	boxGraphics := aCollectionOfRSBoxGraphs.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> boxPlot [
	^ boxPlot
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> boxPlot: aRSBoxPlot [
	boxPlot := aRSBoxPlot.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> boxesWidth: aNumber [
	boxGraphics do: [ :boxGraph | boxGraph boxWidth: aNumber ]
	
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> color: aColor [
	boxGraphics do: [ :boxGraph | boxGraph color: aColor].
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> colors [
	^ boxGraphics collect: [ :boxGraph | boxGraph color].
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> colors: collectionOfColors [
	boxGraphics doWithIndex: [ :boxGraph :idx | boxGraph color: (collectionOfColors at: idx)].
]

{ #category : #private }
RSBoxPlotShapeGroup >> computeBoxGraphicsCenters [
	| lastBoxCenter |
	lastBoxCenter := 1.
	self boxGraphics: (boxGraphics collect: [ :boxGraph | 
		boxGraph graphCenter: lastBoxCenter + groupOffset.
		lastBoxCenter := lastBoxCenter + self defaultOffset.
		boxGraph.
	]).
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> data: aCollection [
	| collectionOfDatasets |
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	self boxGraphics: (collectionOfDatasets collect: [ :dataSet | RSBoxPlotShape data: dataSet]).
	self computeBoxGraphicsCenters.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> defaultGroupOffset [
	^ 0
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> defaultOffset [
	^ 1
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> groupOffset [
	^ groupOffset
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> groupOffset: aNumber [
	groupOffset := aNumber.
	self computeBoxGraphicsCenters.
]

{ #category : #initialization }
RSBoxPlotShapeGroup >> initialize [
	super initialize.
	groupOffset := self defaultGroupOffset.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> maxCenter [
	| boxesCenters |
	boxesCenters := boxGraphics collect: [ :boxGraph | boxGraph center ].
	^ boxesCenters max.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> maxXValue [
	| boxesMaxXValues |
	boxesMaxXValues := boxGraphics collect: [ :boxGraph | boxGraph boxPoints second x ].
	^ boxesMaxXValues max.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> maxYValue [
	^ (boxGraphics collect: [ :boxGraph | boxGraph maxYValue ]) max.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> minYValue [
	^ (boxGraphics collect: [ :boxGraph | boxGraph minYValue ]) min.
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> numberOfBoxes [
	^ boxGraphics size
]

{ #category : #accessing }
RSBoxPlotShapeGroup >> renderIn: canvas [
	boxGraphics do: [ :boxGraph |  
		boxGraph scales: { boxPlot xScale. boxPlot yScale. }.
		boxGraph renderIn: canvas
	].
]
