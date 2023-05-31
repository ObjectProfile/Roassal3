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
	xValues :=  #(0 1 2).
	yValues := aCollection.
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #accessing }
RSViolinPlot >> densityCurveSample: aCollection [
	^ aCollection collect: [ :value | (self kde: value) ]
]

{ #category : #accessing }
RSViolinPlot >> kde: aNumber [
	| sum h |
	sum := 0.
	h := 4. "TO DO: make it a parameter"
	data 
		do: [ :xi |
			sum := sum + (self kernelFunction: ((aNumber - xi)/h))
		 ].
	^ sum / ((data size) * h)
]

{ #category : #accessing }
RSViolinPlot >> kernelFunction: aNumber [
	"by now it is harcoded the normal (gaussian) kernel"
	^ ((0-((aNumber squared)/2))) exp / ((2 * (Float pi)) sqrt).
]

{ #category : #initialization }
RSViolinPlot >> open [
	chart := RSChart new.
	chart add: self.

	chart
		extent: 250 @ 200;
		padding: 15 @ 10.
	^ chart open
]

{ #category : #rendering }
RSViolinPlot >> renderIn: canvas [
	| polygon |
	polygon := RSPolygon new.
	polygon points: ({ 0@0. 2@2.6. 2@2.5 } collect: [ :aPoint | self scalePoint: aPoint ]).
	canvas add: polygon.
]
