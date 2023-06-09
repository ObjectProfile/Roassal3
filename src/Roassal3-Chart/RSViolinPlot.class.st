Class {
	#name : #RSViolinPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'kernelDensity',
		'curvePoints',
		'area',
		'xlabel',
		'ylabel',
		'title'
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
RSViolinPlot class >> exampleBasicDensityPlot [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicDensityPlot2 [
	| densityPlot data |
	data := #(5 5 5 45 45 45).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicDensityPlot3 [
	| densityPlot data |
	data := #(10 10 10 10).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleBasicDensityPlot4 [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	^ densityPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleDensityPlotCreateWithKernelDesity [
	| densityPlot data kernelDensity |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 10.
	densityPlot := self kernelDensity: kernelDensity.
	densityPlot shape
		color: Color blue translucent;
		border: (RSBorder new 
			color: Color red; 
			width: 2;
			dashArray: #(2 4)).
	^ densityPlot open.
]

{ #category : #examples }
RSViolinPlot class >> exampleDensityPlotWithLabels [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	densityPlot xlabel: 'X label'; ylabel: 'Y label'; title: 'Density plot (bandwidth:10)'.
	^ densityPlot open.
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
	^ area
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

{ #category : #private }
RSViolinPlot >> computeCurvePoints [
	| ys yMax |
	curvePoints := kernelDensity densityCurve.
	xValues := { curvePoints first x. curvePoints last x. }.
	ys := curvePoints collect: [ :point | point y ].
	yMax := ys max.
	yValues := {0. yMax. }.
]

{ #category : #accessing }
RSViolinPlot >> createdShapes [
	^ { area }
]

{ #category : #accessing }
RSViolinPlot >> data [
	^ kernelDensity data.
]

{ #category : #accessing }
RSViolinPlot >> data: aCollection [
	kernelDensity data: aCollection.
	self computeCurvePoints.
]

{ #category : #defaults }
RSViolinPlot >> defaultAreaColor [
	^ area color.
	
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

{ #category : #opening }
RSViolinPlot >> open [
	chart := RSChart new.
	chart add: self.
	chart
		extent: 250 @ 200;
		add: RSHorizontalTick new;
		add: RSVerticalTick new;
		ylabel: self ylabel;
		xlabel: self xlabel;
		title: self title.
	^ chart open
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	| curve firstPoint lastPoint closingPointStart closingPointEnd |
	area := self shape copy.
	area color: self computeColor.
	firstPoint := curvePoints first.
	lastPoint := curvePoints last.
	closingPointStart := firstPoint x @ 0.
	closingPointEnd := lastPoint x @ 0.
	curve := curvePoints copy.
	curve addFirst: closingPointStart.
	curve add: closingPointEnd.
	lastPoint := curve last.
	area points: (curve collect: [ :aPoint | self scalePoint: aPoint ]).
	canvas add: area.
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
