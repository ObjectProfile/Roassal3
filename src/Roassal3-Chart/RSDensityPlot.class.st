Class {
	#name : #RSDensityPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'data',
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
RSDensityPlot class >> data: aCollection [
	| densityPlot |
	densityPlot := self new.
	densityPlot data: aCollection.
	^ densityPlot
]

{ #category : #examples }
RSDensityPlot class >> exampleBasicDensityPlot [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSDensityPlot class >> exampleBasicDensityPlot2 [
	| densityPlot data |
	data := #(5 5 5 45 45 45).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSDensityPlot class >> exampleBasicDensityPlot3 [
	| densityPlot data |
	data := #(10 10 10 10).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #examples }
RSDensityPlot class >> exampleBasicDensityPlot4 [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	^ densityPlot open.
]

{ #category : #examples }
RSDensityPlot class >> exampleDensityPlotCreateWithKernelDesity [
	| densityPlot data kernelDensity |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 10.
	densityPlot := self kernelDensity: kernelDensity.
	densityPlot shape
		color: Color blue translucent;
		border: (RSBorder new 
			color: Color blue; 
			width: 2;
			dashArray: #(2 4)).
	^ densityPlot open.
]

{ #category : #examples }
RSDensityPlot class >> exampleDensityPlotWithLabels [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	densityPlot xlabel: 'X label'; ylabel: 'Y label'; title: 'Density plot (bandwidth:10)'.
	^ densityPlot open.
]

{ #category : #accessing }
RSDensityPlot class >> kernelDensity: anRSKernelDensity [
	| densityPlot |
	densityPlot := self new.
	densityPlot kernelDensity: anRSKernelDensity.
	^ densityPlot
]

{ #category : #accessing }
RSDensityPlot >> area [
	^ area
]

{ #category : #accessing }
RSDensityPlot >> areaColor [
	^ area color.
]

{ #category : #accessing }
RSDensityPlot >> bandwidth [
	^ kernelDensity bandwidth.
	
]

{ #category : #accessing }
RSDensityPlot >> bandwidth: aNumber [
	kernelDensity bandwidth: aNumber.
	self computeCurvePoints.
	
]

{ #category : #'public - shape' }
RSDensityPlot >> color: aColor [
	area color: aColor.
	"Improvement TO DO: Use color palletes to calculate line and areaColor"
]

{ #category : #private }
RSDensityPlot >> computeCurvePoints [
	| ys yMax |
	curvePoints := kernelDensity densityCurve.
	xValues := { curvePoints first x. curvePoints last x. }.
	ys := curvePoints collect: [ :point | point y ].
	yMax := ys max.
	yValues := {0. yMax. }.
]

{ #category : #accessing }
RSDensityPlot >> createdShapes [
	^ { area }
]

{ #category : #accessing }
RSDensityPlot >> data [
	^ kernelDensity data.
]

{ #category : #accessing }
RSDensityPlot >> data: aCollection [
	kernelDensity data: aCollection.
	self computeCurvePoints.
]

{ #category : #defaults }
RSDensityPlot >> defaultAreaColor [
	^ Color r:188 g:189 b:220 range: 255.
	
]

{ #category : #defaults }
RSDensityPlot >> defaultKernelDensity [
	^ RSKernelDensity new.
]

{ #category : #defaults }
RSDensityPlot >> defaultLineColor [
	^ Color r:117 g:107 b:177 range: 255.
]

{ #category : #initialization }
RSDensityPlot >> defaultShape [
	^ RSPolygon new
		color: self defaultAreaColor;
		border: (RSBorder new 
			color: self defaultLineColor; 
			width: 2).
]

{ #category : #initialization }
RSDensityPlot >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity.
	area := self shape copy.
]

{ #category : #accessing }
RSDensityPlot >> kde: aNumber [
	^ kernelDensity kde: aNumber.
]

{ #category : #accessing }
RSDensityPlot >> kernel [
	^ kernelDensity kernel.
]

{ #category : #accessing }
RSDensityPlot >> kernel: anRSKernelFunction [
	kernelDensity kernel: anRSKernelFunction.
	self computeCurvePoints.
]

{ #category : #accessing }
RSDensityPlot >> kernelDensity [
	^ kernelDensity.
]

{ #category : #accessing }
RSDensityPlot >> kernelDensity: anRSKernelDensity [
	kernelDensity := anRSKernelDensity.
	self computeCurvePoints.
]

{ #category : #opening }
RSDensityPlot >> open [
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
RSDensityPlot >> renderIn: canvas [
	| curve firstPoint lastPoint closingPointStart closingPointEnd |
	area := self shape copy.
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
RSDensityPlot >> title [
	^ title.
]

{ #category : #accessing }
RSDensityPlot >> title: aString [
	title := aString.
]

{ #category : #accessing }
RSDensityPlot >> xlabel [
	^ xlabel
]

{ #category : #accessing }
RSDensityPlot >> xlabel: aString [
	xlabel := aString
]

{ #category : #accessing }
RSDensityPlot >> ylabel [
	^ ylabel
]

{ #category : #accessing }
RSDensityPlot >> ylabel: aString [
	ylabel := aString
]
