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
	"xs := #(0 15 20 30 50)."
	xs := 0 to: 50 by: 0.5.
	^ xs collect: [ :d |
		yi := self kde: d.
		d@yi.
		 ].
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
	| polygon |
	polygon := RSPolygon new.
	polygon points: (self densityCurve collect: [ :aPoint | self scalePoint: aPoint ]).
	canvas add: polygon.
]
