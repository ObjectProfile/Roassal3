Class {
	#name : #RSViolinPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'kernelDensity',
		'densityAreaPoints',
		'densityArea',
		'statisticalMeasures',
		'boxPoints',
		'box',
		'medianLinePoints',
		'xlabel',
		'ylabel',
		'title',
		'centerLinePoints',
		'boxWidth'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| densityPlot |
	densityPlot := self new.
	densityPlot data: aCollection.
	^ densityPlot
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicViolinPlot [
	| violinPlot data |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	violinPlot bandwidth.
	violinPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicViolinPlot2 [
	| violinPlot data |
	data := { 100. 200. 300. 400. 500. 600. }.
	violinPlot := RSViolinPlot data: data.
	violinPlot bandwidth: 150.
	violinPlot open.
]

{ #category : #accessing }
RSViolinPlot class >> kernelDensity: anRSKernelDensity [
	| densityPlot |
	densityPlot := self new.
	densityPlot kernelDensity: anRSKernelDensity.
	^ densityPlot
]

{ #category : #accessing }
RSViolinPlot >> area [
	^ densityArea
]

{ #category : #accessing }
RSViolinPlot >> areaColor [
	^ self computeColor.
]

{ #category : #accessing }
RSViolinPlot >> bandwidth [
	^ kernelDensity bandwidth.
	
]

{ #category : #accessing }
RSViolinPlot >> bandwidth: aNumber [
	kernelDensity bandwidth: aNumber.
	self computeCurvePoints.
	
]

{ #category : #accessing }
RSViolinPlot >> boxWidth [
	^ boxWidth.
]

{ #category : #private }
RSViolinPlot >> computeBoxPoints [
	| q025 q050 q075 quartiles upperLimit lowerLimit |
	quartiles := statisticalMeasures quartiles.
	q025 := quartiles at: 1.
	q050 := quartiles at: 2.
	q075 := quartiles at: 3.
	upperLimit := statisticalMeasures upperLimit.
	lowerLimit := statisticalMeasures lowerLimit.
	boxWidth := (xValues max - xValues min) * 0.10.
	boxPoints := {(0-(boxWidth/2))@q025. (boxWidth/2)@q025. (boxWidth/2)@q075. (0-(boxWidth/2))@q075}.
	medianLinePoints := { (0-(boxWidth/2))@q050. (boxWidth/2)@q050. }.
	centerLinePoints := { 0@upperLimit. 0@lowerLimit. }
	
]

{ #category : #private }
RSViolinPlot >> computeCurvePoints [
	| xs xMax xMin densityCurve |
	densityCurve := (kernelDensity densityCurve) collect: [:point | (point y @ point x)].
	yValues := { densityCurve first y. densityCurve last y. }.
	densityAreaPoints := densityCurve copy.
	(densityCurve reversed) do: [ :point | densityAreaPoints add: ((point x * -1) @ point y) ].
	xs := densityAreaPoints collect: [ :point | point x ].
	xMax := xs max.
	xMin := xs min.
	xValues := {xMin*self defaultAreaMarginRatio. xMax*self defaultAreaMarginRatio. }.
]

{ #category : #accessing }
RSViolinPlot >> createdShapes [
	^ { densityArea. box. }
]

{ #category : #accessing }
RSViolinPlot >> data [
	^ kernelDensity data.
]

{ #category : #accessing }
RSViolinPlot >> data: aCollection [
	kernelDensity data: aCollection.
	self computeCurvePoints.
	"It should be here?"
	"Statistical measures should be replaced as extension methods. 
	Or a class that don't store the data"
	self statisticalMeasures: self defaultStatisticalMeasures.
	self computeBoxPoints.
]

{ #category : #defaults }
RSViolinPlot >> defaultAreaColor [
	^ densityArea color.
	
]

{ #category : #defaults }
RSViolinPlot >> defaultAreaMarginRatio [
	^ 1.5.
]

{ #category : #defaults }
RSViolinPlot >> defaultKernelDensity [
	^ RSKernelDensity new.
]

{ #category : #defaults }
RSViolinPlot >> defaultLineColor [
	^ Color r:117 g:107 b:177 range: 255.
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [ 
	^ RSPolygon new
		noPaint.
]

{ #category : #defaults }
RSViolinPlot >> defaultStatisticalMeasures [
	^ RSStatisticalMeasures data: self data.
]

{ #category : #defaults }
RSViolinPlot >> densityAreaPoints [
	^ densityAreaPoints.
	
]

{ #category : #initialization }
RSViolinPlot >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity.
]

{ #category : #accessing }
RSViolinPlot >> kde: aNumber [
	^ kernelDensity kde: aNumber.
]

{ #category : #accessing }
RSViolinPlot >> kernel [
	^ kernelDensity kernel.
]

{ #category : #accessing }
RSViolinPlot >> kernel: anRSKernelFunction [
	kernelDensity kernel: anRSKernelFunction.
	self computeCurvePoints.
]

{ #category : #accessing }
RSViolinPlot >> kernelDensity [
	^ kernelDensity.
]

{ #category : #accessing }
RSViolinPlot >> kernelDensity: anRSKernelDensity [
	kernelDensity := anRSKernelDensity.
	self computeCurvePoints.
]

{ #category : #accessing }
RSViolinPlot >> median [
	^ statisticalMeasures median.
]

{ #category : #opening }
RSViolinPlot >> open [
	chart := RSChart new.
	chart add: self.
	chart
		extent: 250 @ 200;
		ylabel: self ylabel;
		xlabel: self xlabel;
		title: self title.
	^ chart open
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	| medianLine centerLine |
	densityArea := self shape copy.
	densityArea color: self computeColor.
	densityArea points: (densityAreaPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	densityArea borderColor: Color black.
	canvas add: densityArea.
	
	centerLine := RSPolyline new.
	centerLine := centerLine controlPoints: (centerLinePoints collect: [ :aPoint | self scalePoint: aPoint ]).
	centerLine width: 1.25.
	centerLine color: Color black.
	canvas add: centerLine.
	
	box :=  RSPolygon new.
	box points: (boxPoints collect: [ :aPoint | self scalePoint: aPoint ]).
	box color: Color white.
	box borderColor: Color black.
	canvas add: box.
	
	medianLine := RSPolyline new.
	medianLine := medianLine controlPoints: (medianLinePoints collect: [ :aPoint | self scalePoint: aPoint ]).
	medianLine width: 2.
	medianLine color: Color black.
	canvas add: medianLine.
]

{ #category : #accessing }
RSViolinPlot >> statisticalMeasures: aRSStatisticalMeasures [
	statisticalMeasures := aRSStatisticalMeasures.
]

{ #category : #accessing }
RSViolinPlot >> title [
	^ title.
]

{ #category : #accessing }
RSViolinPlot >> title: aString [
	title := aString.
]

{ #category : #accessing }
RSViolinPlot >> xlabel [
	^ xlabel
]

{ #category : #accessing }
RSViolinPlot >> xlabel: aString [
	xlabel := aString
]

{ #category : #accessing }
RSViolinPlot >> ylabel [
	^ ylabel
]

{ #category : #accessing }
RSViolinPlot >> ylabel: aString [
	ylabel := aString
]
