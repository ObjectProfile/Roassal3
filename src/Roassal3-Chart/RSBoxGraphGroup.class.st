Class {
	#name : #RSBoxGraphGroup,
	#superclass : #RSObject,
	#instVars : [
		'boxGraphics',
		'xScale',
		'yScale'
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
RSBoxGraphGroup >> boxGraphics [
	^ boxGraphics.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxGraphics: aCollectionOfRSBoxGraphs [
	boxGraphics := aCollectionOfRSBoxGraphs.
]

{ #category : #accessing }
RSBoxGraphGroup >> data: aCollection [
	| collectionOfDatasets lastBoxCenter |
	"if is not a collection of collections. transform in a collection of collections"
	collectionOfDatasets := aCollection first isCollection
		                        ifFalse: [ { aCollection } ]
		                        ifTrue: [ aCollection ].
	lastBoxCenter := 1.
	self boxGraphics: (collectionOfDatasets collectWithIndex: [ :dataSet :idx | 
		| boxGraph |
		boxGraph := (RSBoxGraph data: dataSet) graphCenter: lastBoxCenter.
		lastBoxCenter := lastBoxCenter + self defaultOffset.
		boxGraph.
	]).
]

{ #category : #accessing }
RSBoxGraphGroup >> defaultOffset [
	^ 2
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
	boxGraphics := boxGraphics collect: [ :boxGraph | boxGraph scales: { xScale. yScale. } ].
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
