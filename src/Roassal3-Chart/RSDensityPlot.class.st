Class {
	#name : #RSDensityPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'data',
		'bandwith',
		'kernel',
		'bandwidth'
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

{ #category : #accessing }
RSDensityPlot class >> exampleBasicDensityPlot [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #accessing }
RSDensityPlot class >> exampleBasicDensityPlot2 [
	| densityPlot data |
	data := #(5 5 5 45 45 45).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #accessing }
RSDensityPlot class >> exampleBasicDensityPlot3 [
	| densityPlot data |
	data := #(10 10 10 10).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #accessing }
RSDensityPlot class >> exampleBasicDensityPlot4 [
	| densityPlot data |
	data := #(25 25 25 25).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open.
]

{ #category : #rendering }
RSDensityPlot >> bandwidth [
	^ bandwidth
	
]

{ #category : #rendering }
RSDensityPlot >> bandwidth: aNumber [
	bandwidth := aNumber.
	
]

{ #category : #rendering }
RSDensityPlot >> beforeRenderingIn: aChart [
	self densityCurve.
	super beforeRenderingIn: aChart.
]

{ #category : #initialization }
RSDensityPlot >> createdShapes [
	^ { data }
]

{ #category : #accessing }
RSDensityPlot >> data [
	^ data
]

{ #category : #accessing }
RSDensityPlot >> data: aCollection [
	data := aCollection.
]

{ #category : #accessing }
RSDensityPlot >> defaultBandwidth [
	^ 1.00.
]

{ #category : #accessing }
RSDensityPlot >> defaultKernel [
	^ RSKernelGaussianFunction new.
]

{ #category : #initialization }
RSDensityPlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #rendering }
RSDensityPlot >> densityCurve [
	| curvePoints xi yi maxData minData epsilon step minXDomain maxXDomain |

	maxData := data max.
	minData := data min.
	curvePoints := OrderedCollection new.
	epsilon := 0.000001.
	step := 0.5.

	"Calculate left side"
	xi := minData.
	yi := self kde: xi.
	curvePoints add: xi@yi.
	[ yi > epsilon ] whileTrue: [
		xi := xi - step.
		yi := self kde: xi. 
		curvePoints addFirst: xi@yi.
	].
	minXDomain := xi.

	"Calculate middle"
	xi := minData + step.
	yi := self kde: xi.
	curvePoints add: xi@yi.
	[ xi < maxData ] whileTrue: [
		xi := xi + step.
		yi := self kde: xi. 
		curvePoints add: xi@yi.
	].
		
	"Calculate right side"
	[ yi > epsilon ] whileTrue: [
		xi := xi + step.
		yi := self kde: xi. 
		curvePoints add: xi@yi.
	].
	maxXDomain := xi.
	xValues := { minXDomain. maxXDomain }.
	yValues := #(0 0.05).
	
	^ curvePoints.
]

{ #category : #accessing }
RSDensityPlot >> densityCurveSample: aCollection [
	^ aCollection collect: [ :value | (self kde: value) ]
]

{ #category : #rendering }
RSDensityPlot >> initialize [
	super initialize.
	kernel := self defaultKernel.
	bandwidth := self defaultBandwidth.
]

{ #category : #accessing }
RSDensityPlot >> kde: aNumber [
	^ ((RSKernelDensity kernel: kernel data: data) bandwidth: bandwidth) kde: aNumber.
]

{ #category : #rendering }
RSDensityPlot >> kernel [
	^ kernel.
]

{ #category : #initialization }
RSDensityPlot >> open [
	chart := RSChart new.
	chart add: self.

	chart
		extent: 250 @ 200.
	^ chart open
]

{ #category : #rendering }
RSDensityPlot >> renderIn: canvas [
	| polygon curve firstPoint lastPoint closingPointStart closingPointEnd |
	polygon := RSPolygon new.
	curve := self densityCurve.
	firstPoint := curve first.
	lastPoint := curve last.
	closingPointStart := firstPoint x @ 0.
	closingPointEnd := lastPoint x @ 0.
	curve := curve asOrderedCollection.
	curve addFirst: closingPointStart.
	curve add: closingPointEnd.
	lastPoint := curve last.
	polygon points: (curve collect: [ :aPoint | self scalePoint: aPoint ]).
	canvas add: polygon.
]
