Class {
	#name : #RSBoxGraph,
	#superclass : #RSObject,
	#instVars : [
		'boxWidth',
		'statisticalMeasures',
		'centerLine',
		'box',
		'medianLine',
		'outliers',
		'color',
		'xScale',
		'yScale',
		'graphCenter'
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
	| boxPoints |
	boxPoints := self boxPoints.
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box borderColor: Color black.
	^ box
]

{ #category : #accessing }
RSBoxGraph >> boxPoints [
	| q025 q075 quartiles boxPoints |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	boxPoints := { 
		(graphCenter)@q025. (graphCenter+(boxWidth/2))@q025.
		(graphCenter+(boxWidth/2))@q075. (graphCenter-(boxWidth/2))@q075
	}.
	^ boxPoints.
]

{ #category : #accessing }
RSBoxGraph >> boxWidth [
	^ boxWidth.
]

{ #category : #accessing }
RSBoxGraph >> centerLine [
	| centerLinePoints |
	centerLinePoints := self centerLinePoints.
	centerLine :=  RSPolyline new.
	centerLine controlPoints: (centerLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	centerLine width: 1.
	centerLine color: Color black.
	^ centerLine.
]

{ #category : #accessing }
RSBoxGraph >> centerLinePoints [
	| upperLimit lowerLimit centerLinePoints |
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	centerLinePoints := { graphCenter@upperLimit. graphCenter@lowerLimit. }.
	^ centerLinePoints.
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

{ #category : #defaults }
RSBoxGraph >> defaultGraphCenter [
	^ 1
]

{ #category : #accessing }
RSBoxGraph >> graphCenter [
	^ graphCenter.
]

{ #category : #accessing }
RSBoxGraph >> graphCenter: aNumber [
	graphCenter := aNumber.
]

{ #category : #initialization }
RSBoxGraph >> initialize [
	super initialize.
	boxWidth := self defaultBoxWidth.
	graphCenter := self defaultGraphCenter.
]

{ #category : #accessing }
RSBoxGraph >> median [
	^ statisticalMeasures median.
]

{ #category : #accessing }
RSBoxGraph >> medianLine [
	| medianLinePoints |
	medianLinePoints := self medianLinePoints.
	medianLine := RSPolyline new.
	medianLine := medianLine controlPoints: (medianLinePoints collect: [ :aPoint | 
		self scalePoint: aPoint 
	]).
	medianLine width: 2.
	medianLine color: Color black.
	^ medianLine.
]

{ #category : #accessing }
RSBoxGraph >> medianLinePoints [
	| q050 medianLinePoints |
	q050 := statisticalMeasures quartiles second.
	medianLinePoints := { (graphCenter-(boxWidth/2))@q050. (graphCenter+(boxWidth/2))@q050. }.
	^ medianLinePoints.
]

{ #category : #accessing }
RSBoxGraph >> outliers [
	| outliersPoints |
	outliersPoints := self outliersPoints.
	outliers := outliersPoints collect: [ :point | self scalePoint: point ].
	outliers := outliersPoints collect: [ :out |
			| e |
			e := RSEllipse new
			radius: 2;
			color: Color black;
			yourself.
			e translateTo: out.
	] as: RSGroup.
	^ outliers.
	
	
]

{ #category : #accessing }
RSBoxGraph >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
]

{ #category : #accessing }
RSBoxGraph >> outliersPoints [
	| outliersPoints |
	outliersPoints := statisticalMeasures outliers collect: [ :y | graphCenter@y ].
	^ outliersPoints.
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
RSBoxGraph >> shapesWithCenterAt: aNumber [
	self graphCenter: aNumber.
	centerLine := self centerLine.
	medianLine := self medianLine.
	box := self box.
	outliers := self outliers.
	^ { centerLine. box. medianLine. outliers.}.
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
