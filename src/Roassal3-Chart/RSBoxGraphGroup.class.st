Class {
	#name : #RSBoxGraphGroup,
	#superclass : #RSObject,
	#instVars : [
		'boxGraphics',
		'xScale',
		'yScale',
		'groupOffset'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxGraphGroup class >> boxGraphics: aCollectionOfRSBoxGraphics [
	| boxGraphGroup |
	boxGraphGroup := self new.
	boxGraphGroup boxGraphics: aCollectionOfRSBoxGraphics.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxGraphGroup class >> data: aCollection [
	| boxGraphGroup |
	boxGraphGroup := self new.
	boxGraphGroup data: aCollection.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxGraphGroup class >> data: aCollection scales: collectionOfNSScales [
	| boxGraphGroup |
	boxGraphGroup := self data: aCollection.
	boxGraphGroup scales: collectionOfNSScales.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxGraphGroup >> addOffsetToGroup: aNumber [
	groupOffset := groupOffset + aNumber.
	self computeBoxGraphicsCenters.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxGraphics [
	^ boxGraphics.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxGraphics: aCollectionOfRSBoxGraphs [
	boxGraphics := aCollectionOfRSBoxGraphs.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxesWidth: aNumber [
	boxGraphics do: [ :boxGraph | boxGraph boxWidth: aNumber ]
	
]

{ #category : #accessing }
RSBoxGraphGroup >> color: aColor [
	boxGraphics do: [ :boxGraph | boxGraph color: aColor].
]

{ #category : #accessing }
RSBoxGraphGroup >> colors [
	^ boxGraphics collect: [ :boxGraph | boxGraph color].
]

{ #category : #accessing }
RSBoxGraphGroup >> colors: collectionOfColors [
	boxGraphics doWithIndex: [ :boxGraph :idx | boxGraph color: (collectionOfColors at: idx)].
]

{ #category : #accessing }
RSBoxGraphGroup >> computeBoxGraphicsCenters [
	| lastBoxCenter |
	lastBoxCenter := 1.
	self boxGraphics: (boxGraphics collect: [ :boxGraph | 
		boxGraph graphCenter: lastBoxCenter + groupOffset.
		lastBoxCenter := lastBoxCenter + self defaultOffset.
		boxGraph.
	]).
]

{ #category : #accessing }
RSBoxGraphGroup >> data: aCollection [
	| collectionOfDatasets |
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	self boxGraphics: (collectionOfDatasets collect: [ :dataSet | RSBoxGraph data: dataSet]).
	self computeBoxGraphicsCenters.
]

{ #category : #accessing }
RSBoxGraphGroup >> defaultGroupOffset [
	^ 0
]

{ #category : #accessing }
RSBoxGraphGroup >> defaultOffset [
	^ 1
]

{ #category : #accessing }
RSBoxGraphGroup >> groupOffset [
	^ groupOffset
]

{ #category : #accessing }
RSBoxGraphGroup >> groupOffset: aNumber [
	groupOffset := aNumber.
	self computeBoxGraphicsCenters.
]

{ #category : #initialization }
RSBoxGraphGroup >> initialize [
	super initialize.
	groupOffset := self defaultGroupOffset.
]

{ #category : #accessing }
RSBoxGraphGroup >> maxCenter [
	| boxesCenters |
	boxesCenters := boxGraphics collect: [ :boxGraph | boxGraph center ].
	^ boxesCenters max.
]

{ #category : #accessing }
RSBoxGraphGroup >> maxXValue [
	| boxesMaxXValues |
	boxesMaxXValues := boxGraphics collect: [ :boxGraph | boxGraph boxPoints second x ].
	^ boxesMaxXValues max.
]

{ #category : #accessing }
RSBoxGraphGroup >> maxYValue [
	^ (boxGraphics collect: [ :boxGraph | boxGraph maxYValue ]) max.
]

{ #category : #accessing }
RSBoxGraphGroup >> minYValue [
	^ (boxGraphics collect: [ :boxGraph | boxGraph minYValue ]) min.
]

{ #category : #accessing }
RSBoxGraphGroup >> numberOfBoxes [
	^ boxGraphics size
]

{ #category : #accessing }
RSBoxGraphGroup >> renderIn: canvas [
	boxGraphics := boxGraphics collect: [ :boxGraph | 
		boxGraph scales: { xScale. yScale. }.
	].
	boxGraphics do: [ :boxGraph |  boxGraph renderIn: canvas].
]

{ #category : #accessing }
RSBoxGraphGroup >> scales: collectionOfNSScales [
	self xScale: collectionOfNSScales first.
	self yScale: collectionOfNSScales second.
]

{ #category : #accessing }
RSBoxGraphGroup >> xScale: aNSScale [
	xScale := aNSScale
]

{ #category : #accessing }
RSBoxGraphGroup >> yScale: aNSScale [
	yScale := aNSScale
]
