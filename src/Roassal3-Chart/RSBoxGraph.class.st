Class {
	#name : #RSBoxGraph,
	#superclass : #RSObject,
	#instVars : [
		'boxWidth',
		'statisticalMeasures',
		'centerLinePoints',
		'outliersPoints',
		'centerLine',
		'box',
		'medianLine',
		'outliers',
		'color',
		'xScale',
		'yScale'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxGraph class >> data: collectionOfData1D [
	| boxGraph |
	boxGraph := self new.
	boxGraph data: collectionOfData1D.
	^ boxGraph
]

{ #category : #accessing }
RSBoxGraph class >> data: collectionOfData1D scales: collectionOfNSScales [
	| boxGraph |
	boxGraph := self data: collectionOfData1D.
	boxGraph scales: collectionOfNSScales.
	^ boxGraph.
]

{ #category : #accessing }
RSBoxGraph >> box [
	^ box
]

{ #category : #accessing }
RSBoxGraph >> box: aRSPolygon [
	box := aRSPolygon
]

{ #category : #accessing }
RSBoxGraph >> boxPointsWithCenterAt: aNumber [
	| q025 q075 quartiles boxPoints |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	boxPoints := { 
		(aNumber-(boxWidth/2))@q025. (aNumber+(boxWidth/2))@q025.
		(aNumber+(boxWidth/2))@q075. (aNumber-(boxWidth/2))@q075
	}.
	^ boxPoints.
]

{ #category : #accessing }
RSBoxGraph >> boxWidth [
	^ boxWidth.
]

{ #category : #accessing }
RSBoxGraph >> centerLine [
	^ centerLine
]

{ #category : #accessing }
RSBoxGraph >> centerLine: aRSPolyline [
	centerLine := aRSPolyline
]

{ #category : #accessing }
RSBoxGraph >> centerLinePoints [
	^ centerLinePoints
]

{ #category : #accessing }
RSBoxGraph >> centerLinePoints: aCollectionOfPoints [
	centerLinePoints := aCollectionOfPoints
]

{ #category : #accessing }
RSBoxGraph >> color [
	^ color
]

{ #category : #accessing }
RSBoxGraph >> color: aNumber [
	color := aNumber
]

{ #category : #accessing }
RSBoxGraph >> data: collectionOfData1D [
	self statisticalMeasures: (RSStatisticalMeasures data: collectionOfData1D).
]

{ #category : #defaults }
RSBoxGraph >> defaultBoxWidth [
	^ 0.7
]

{ #category : #accessing }
RSBoxGraph >> initialize [
	super initialize.
	boxWidth := self defaultBoxWidth.
]

{ #category : #accessing }
RSBoxGraph >> median [
	^ statisticalMeasures median.
]

{ #category : #accessing }
RSBoxGraph >> medianLine [
	^ medianLine
]

{ #category : #accessing }
RSBoxGraph >> medianLine: aRSPolyline [
	medianLine := aRSPolyline
]

{ #category : #accessing }
RSBoxGraph >> medianLinePointsWithCenterAt: aNumber [
	| q050 medianLinePoints |
	q050 := statisticalMeasures quartiles second.
	medianLinePoints := { (aNumber-(boxWidth/2))@q050. (aNumber+(boxWidth/2))@q050. }.
	^ medianLinePoints.
]

{ #category : #accessing }
RSBoxGraph >> outliers [
	^ outliers
]

{ #category : #accessing }
RSBoxGraph >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
]

{ #category : #accessing }
RSBoxGraph >> outliersPoints [
	^ outliersPoints
]

{ #category : #accessing }
RSBoxGraph >> outliersPoints: aCollectionOfPoints [
	outliersPoints := aCollectionOfPoints
]

{ #category : #accessing }
RSBoxGraph >> scalePoint: aPoint [
	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #accessing }
RSBoxGraph >> scales: collectionOfNSScales [
	self xScale: collectionOfNSScales first.
	self yScale: collectionOfNSScales second.
]

{ #category : #accessing }
RSBoxGraph >> statisticalMeasures [
	^ statisticalMeasures.
]

{ #category : #accessing }
RSBoxGraph >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #accessing }
RSBoxGraph >> xScale [
	^ xScale.
]

{ #category : #accessing }
RSBoxGraph >> xScale: aNSScale [
	xScale := aNSScale
]

{ #category : #accessing }
RSBoxGraph >> yScale [
	^ yScale.
]

{ #category : #accessing }
RSBoxGraph >> yScale: aNSScale [
	yScale := aNSScale
]
