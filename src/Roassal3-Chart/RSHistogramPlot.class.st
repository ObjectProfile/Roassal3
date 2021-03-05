"
TODO
"
Class {
	#name : #RSHistogramPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'x',
		'bins'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSHistogramPlot >> bins: aCollection [
	bins := aCollection.
	self computeXYValues.
]

{ #category : #private }
RSHistogramPlot >> computeXYValues [
	| values |
	values := x sorted.
]

{ #category : #initialization }
RSHistogramPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #rendering }
RSHistogramPlot >> renderIn: canvas [
	
]

{ #category : #accessing }
RSHistogramPlot >> x: aCollection [
	x := aCollection.
	self computeXYValues.
]
