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
	xValues := #(0 50).
	yValues := #(0 0.05).
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
	| xs yi |
	xs := 0 to: 50 by: 0.5.
	^ xs collect: [ :d | 
		yi := self kde: d. 
		d@yi.].
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
