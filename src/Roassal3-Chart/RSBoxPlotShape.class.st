Class {
	#name : #RSBoxPlotShape,
	#superclass : #RSObject,
	#instVars : [
		'bandWidth',
		'statisticalMeasures',
		'centerLine',
		'box',
		'medianLine',
		'outliers',
		'color',
		'xScale',
		'yScale',
		'graphCenter',
		'bandOffset',
		'outlier'
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
RSBoxPlotShape >> bandOffset: aNumber [
	bandOffset := aNumber.
]

{ #category : #accessing }
RSBoxPlotShape >> bandWidth: aNumber [
	bandWidth := aNumber
]

{ #category : #accessing }
RSBoxPlotShape >> box [
	^ box
]

{ #category : #accessing }
RSBoxPlotShape >> boxWidth [
	^ bandWidth.
]

{ #category : #accessing }
RSBoxPlotShape >> center [
	^ graphCenter
]

{ #category : #accessing }
RSBoxPlotShape >> centerLine [
	| upperLimit lowerLimit centerLinePoints |
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	graphCenter := bandOffset.
	centerLinePoints := { graphCenter@ (yScale scale: upperLimit). graphCenter@(yScale scale: lowerLimit). }.
	centerLine :=  RSPolyline new.
	centerLine controlPoints: centerLinePoints.
	centerLine width: 1.
	centerLine color: Color black.
	^ centerLine.
]

{ #category : #accessing }
RSBoxPlotShape >> color [
	^ color
]

{ #category : #accessing }
RSBoxPlotShape >> color: aColor [
	color := aColor.
]

{ #category : #accessing }
RSBoxPlotShape >> computeBox [
	| boxPoints q025 q075 quartiles |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q075 := quartiles at: 3.
	graphCenter := bandOffset.
	"bandWidth is already scaled (in pixels"
	boxPoints := { 
		(graphCenter-(bandWidth/2)) @ (yScale scale: q025). 
		(graphCenter+(bandWidth/2)) @ (yScale scale: q025).
		(graphCenter+(bandWidth/2)) @ (yScale scale: q075). 
		(graphCenter-(bandWidth/2)) @ (yScale scale: q075)
	}.
	box points: boxPoints.
	^ box
]

{ #category : #accessing }
RSBoxPlotShape >> computeMedianLine [
	| q050 medianLinePoints |
	q050 := statisticalMeasures quartiles second.
	graphCenter := bandOffset.
	medianLinePoints := { 
		(graphCenter-(bandWidth/2))@ (yScale scale: q050). 
		(graphCenter+(bandWidth/2))@ (yScale scale: q050). }.
	medianLine := medianLine controlPoints: medianLinePoints.
	^ medianLine.
]

{ #category : #accessing }
RSBoxPlotShape >> computeOutliers [
	| outliersPoints |
	graphCenter := bandOffset.
	outliersPoints := statisticalMeasures outliers collect: [ :y | graphCenter@ (yScale scale: y) ].
	outliers := outliersPoints.
	outliers := outliers collect: [ :out |
			| e |
			e := outlier.
			e translateTo: out.
	] as: RSGroup.
	^ outliers.
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
RSBoxPlotShape >> defaultBox [
	^ RSPolygon new
		color: color;
		borderColor: Color black.
]

{ #category : #defaults }
RSBoxPlotShape >> defaultBoxWidth [
	^ 0.7
]

{ #category : #defaults }
RSBoxPlotShape >> defaultGraphCenter [
	^ 1
]

{ #category : #defaults }
RSBoxPlotShape >> defaultMedianLine [
	^ RSPolyline new
		width: 2;
		color: Color black.
]

{ #category : #defaults }
RSBoxPlotShape >> defaultOutlier [
	^ RSEllipse new
		radius: 2.5;
		color: Color black.
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
	graphCenter := self defaultGraphCenter.
	medianLine := self defaultMedianLine.
	box := self defaultBox.
	outlier := self defaultOutlier.
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
	^ medianLine.
]

{ #category : #accessing }
RSBoxPlotShape >> minYValue [
	self hasOutliers 
		ifTrue: [ ^ (self outlierValues min) min: self lowerLimit ]
		ifFalse: [ ^ self lowerLimit ].
]

{ #category : #accessing }
RSBoxPlotShape >> outlier: markerShape [
	outlier := markerShape
]

{ #category : #accessing }
RSBoxPlotShape >> outlierValues [
	^ statisticalMeasures outliers.
]

{ #category : #accessing }
RSBoxPlotShape >> outliers [
	^ outlier.
]

{ #category : #accessing }
RSBoxPlotShape >> outliers: aRSGroupOfRSElipses [
	outliers := aRSGroupOfRSElipses
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
	medianLine := self computeMedianLine.
	box := self computeBox.
	box color: color.
	outliers := self computeOutliers.
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
