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
	xValues :=  #(1).
	yValues := aCollection.
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolyline new color: nil
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

{ #category : #initialization }
RSViolinPlot >> renderIn: canvas [
	| polygon |
	polygon := RSPolygon new.
	polygon points: { 200@10. 250@190. 160@210 }.
	canvas add: polygon.
]
