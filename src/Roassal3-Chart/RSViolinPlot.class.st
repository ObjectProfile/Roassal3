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
]

{ #category : #initialization }
RSViolinPlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #initialization }
RSViolinPlot >> renderIn: canvas [
	| controlPoints |
	self checkAssertion.
	controlPoints := OrderedCollection new.
	(1 to: xValues size) do: [ :i |
			| xt yt |
			xt := xValues at: i.
			yt := yValues at: i.
			(self isPointWellDefined: xt @ yt)
				ifTrue: [ controlPoints add: (self scalePoint: xt @ yt) ] ].
	"canvas add: (line := self shape copy
		color: self computeColor;
		controlPoints: controlPoints;
		yourself)"
]
