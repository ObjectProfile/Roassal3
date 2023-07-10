Class {
	#name : #RSBoxPlotShape,
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
		'graphCenter',
		'bandPadding'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxPlotShape class >> data: collectionOfData1D [
	| boxGraph |
	boxGraph := self new.
	boxGraph data: collectionOfData1D.
	^ boxGraph
]

{ #category : #accessing }
RSBoxPlotShape class >> data: collectionOfData1D scales: collectionOfNSScales [
	| boxGraph |
	boxGraph := self data: collectionOfData1D.
	boxGraph scales: collectionOfNSScales.
	^ boxGraph.
]

{ #category : #accessing }
RSBoxPlotShape >> bandPadding: aNumber [
	bandPadding := aNumber
]

{ #category : #accessing }
RSBoxPlotShape >> bandWidth: aNumber [
	self boxWidth: aNumber - (aNumber * 0.2).
]

{ #category : #accessing }
RSBoxPlotShape >> box [
	| boxPoints |
	boxPoints := self boxPoints.
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: color.
	box borderColor: Color black.
	^ box
]

{ #category : #accessing }
RSBoxPlotShape >> boxPoints [
	| q025 q075 quartiles boxPoints |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	boxPoints := { 
		(graphCenter-(boxWidth/2))@q025. (graphCenter+(boxWidth/2))@q025.
		(graphCenter+(boxWidth/2))@q075. (graphCenter-(boxWidth/2))@q075
	}.
	^ boxPoints.
]

{ #category : #accessing }
RSBoxPlotShape >> boxWidth [
	^ boxWidth.
]

{ #category : #accessing }
RSBoxPlotShape >> boxWidth: aNumber [
	boxWidth := aNumber.
]

{ #category : #accessing }
RSBoxPlotShape >> center [
	^ graphCenter
]

{ #category : #accessing }
RSBoxPlotShape >> centerLine [
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
RSBoxPlotShape >> centerLinePoints [
	| upperLimit lowerLimit centerLinePoints |
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	centerLinePoints := { graphCenter@upperLimit. graphCenter@lowerLimit. }.
	^ centerLinePoints.
]

{ #category : #accessing }
RSBoxPlotShape >> color [
	^ color
]

{ #category : #accessing }
RSBoxPlotShape >> color: aColor [
	color := aColor
]

{ #category : #accessing }
RSBoxPlotShape >> data [
	^ self statisticalMeasures data.
]

{ #category : #accessing }
RSBoxPlotShape >> data: collectionOfData1D [
	self statisticalMeasures: (RSStatisticalMeasures data: collectionOfData1D).
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBandPadding [
	^ 0.2
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBoxWidth [
	^ 0.7
]

{ #category : #defaults }
RSBoxPlotShape >> defaultGraphCenter [
	^ 1
]

{ #category : #accessing }
RSBoxPlotShape >> graphCenter [
	^ graphCenter.
]

{ #category : #accessing }
RSBoxPlotShape >> graphCenter: aNumber [
	graphCenter := aNumber.
]

{ #category : #defaults }
RSBoxPlotShape >> hasOutliers [
	^ self outlierValues isNotEmpty
]

{ #category : #initialization }
RSBoxPlotShape >> initialize [
	super initialize.
	boxWidth := self defaultBoxWidth.
	graphCenter := self defaultGraphCenter.
	bandPadding := self defaultBandPadding.
]

{ #category : #accessing }
RSBoxPlotShape >> lowerLimit [
	^ statisticalMeasures lowerLimit.
]

{ #category : #accessing }
RSBoxPlotShape >> maxYValue [
	self hasOutliers 
		ifTrue: [ ^ (self outlierValues max) max: self upperLimit ]
		ifFalse: [ ^ self upperLimit ].
]

{ #category : #accessing }
RSBoxPlotShape >> median [
	^ statisticalMeasures median.
]

{ #category : #accessing }
RSBoxPlotShape >> medianLine [
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
RSBoxPlotShape >> medianLinePoints [
	| q050 medianLinePoints |
	q050 := statisticalMeasures quartiles second.
	medianLinePoints := { (graphCenter-(boxWidth/2))@q050. (graphCenter+(boxWidth/2))@q050. }.
	^ medianLinePoints.
]

{ #category : #accessing }
RSBoxPlotShape >> minYValue [
	self hasOutliers 
		ifTrue: [ ^ (self outlierValues min) min: self lowerLimit ]
		ifFalse: [ ^ self lowerLimit ].
]

{ #category : #accessing }
RSBoxPlotShape >> outlierValues [
	^ statisticalMeasures outliers.
]

{ #category : #accessing }
RSBoxPlotShape >> outliers [
	| outliersPoints |
	outliersPoints := self outliersPoints.
	outliers := outliersPoints collect: [ :point | self scalePoint: point ].
	outliers := outliers collect: [ :out |
			| e |
			e := RSEllipse new
			radius: 2.5;
			color: Color black;
			yourself.
			e translateTo: out.
	] as: RSGroup.
	^ outliers.
	
	
]

{ #category : #accessing }
RSBoxPlotShape >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
]

{ #category : #accessing }
RSBoxPlotShape >> outliersPoints [
	| outliersPoints |
	outliersPoints := statisticalMeasures outliers collect: [ :y | graphCenter@y ].
	^ outliersPoints.
]

{ #category : #accessing }
RSBoxPlotShape >> renderIn: canvas [
	| shapes |
	shapes := self shapesWithCenterAt: graphCenter.
	shapes do: [ :aShape |
		aShape isCollection ifTrue: [ canvas addAll: aShape ]
		ifFalse: [ canvas add: aShape ].
	].
	^ canvas.
]

{ #category : #accessing }
RSBoxPlotShape >> scalePoint: aPoint [
	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #accessing }
RSBoxPlotShape >> scales: collectionOfNSScales [
	self xScale: collectionOfNSScales first.
	self yScale: collectionOfNSScales second.
]

{ #category : #accessing }
RSBoxPlotShape >> shapesWithCenterAt: aNumber [
	self graphCenter: aNumber.
	centerLine := self centerLine.
	medianLine := self medianLine.
	box := self box.
	outliers := self outliers.
	^ { centerLine. box. medianLine. outliers.}.
]

{ #category : #accessing }
RSBoxPlotShape >> statisticalMeasures [
	^ statisticalMeasures.
]

{ #category : #accessing }
RSBoxPlotShape >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #accessing }
RSBoxPlotShape >> upperLimit [
	^ statisticalMeasures upperLimit.
]

{ #category : #accessing }
RSBoxPlotShape >> xScale [
	^ xScale.
]

{ #category : #accessing }
RSBoxPlotShape >> xScale: aNSScale [
	xScale := aNSScale
]

{ #category : #accessing }
RSBoxPlotShape >> yScale [
	^ yScale.
]

{ #category : #accessing }
RSBoxPlotShape >> yScale: aNSScale [
	yScale := aNSScale
]
