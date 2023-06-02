Class {
	#name : #RSViolinPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'data'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSViolinPlot class >> data: aCollection [
	| violinPlot |
	violinPlot := self new.
	violinPlot data: aCollection.
	^ violinPlot
]

{ #category : #accessing }
RSViolinPlot class >> exampleBasicViolinPlot [
	| violinPlot data |
	data := #(14 15 28 27 32 35).
	violinPlot := self data: data.
	^ violinPlot open.
]

{ #category : #initialization }
RSViolinPlot >> createdShapes [
	^ { data }
]

{ #category : #accessing }
RSViolinPlot >> data [
	^ data
]

{ #category : #accessing }
RSViolinPlot >> data: aCollection [
	data := aCollection.
	xValues := #(0 50).
	yValues := #(0 0.05).
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #rendering }
RSViolinPlot >> densityCurve [
	| xs yi |
	"xs := #(0 15 20 30 50)."
	xs := 0 to: 50 by: 0.5.
	^ xs collect: [ :d |
		yi := self kde: d.
		d@yi.
		 ].
]

{ #category : #accessing }
RSViolinPlot >> densityCurveSample: aCollection [
	^ aCollection collect: [ :value | (self kde: value) ]
]

{ #category : #accessing }
RSViolinPlot >> kde: aNumber [
	^ (RSKernelDensity kernel: 'gaussian' data: (self data)) kde: aNumber.
]

{ #category : #initialization }
RSViolinPlot >> open [
	chart := RSChart new.
	chart add: self.

	chart
		extent: 250 @ 200.
	^ chart open
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	| polygon line line2|
	polygon := RSPolygon new.
	line := RSPolyline new.
	line2 := RSPolyline new.
	line startPoint: (self scalePoint: 0@0); endPoint: (self scalePoint: 2@2.6); width: 3.
	line2 startPoint: (self scalePoint: 2@2.6); endPoint: (self scalePoint: 8@2.6); width: 3.
	"polygon points: ({ 0@0. 2@2.6. 2@2.5 } collect: [ :aPoint | self scalePoint: aPoint ])."
	polygon points: (self densityCurve collect: [ :aPoint | self scalePoint: aPoint ]).
	"canvas add: line.
	canvas add: line2."
	canvas add: polygon.
]
