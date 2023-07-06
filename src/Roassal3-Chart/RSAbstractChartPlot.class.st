"
Abstract class for all plot classes
"
Class {
	#name : #RSAbstractChartPlot,
	#superclass : #RSChart,
	#instVars : [
		'chart',
		'shape'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractChartPlot >> addShape: aShape [
	"Add a shape to the canvas"
	self container add: aShape
]

{ #category : #rendering }
RSAbstractChartPlot >> beforeRenderingIn: aChart [
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> color [

	^ self shape color
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> color: aColor [

	self shape color: aColor
]

{ #category : #accessing }
RSAbstractChartPlot >> createdShapes [

	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartPlot >> defaultShape [

	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractChartPlot >> initialize [

	super initialize.
	shape := self defaultShape
]

{ #category : #testing }
RSAbstractChartPlot >> isPlot [

	^ false
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> shape [

	^ shape
]

{ #category : #'public - shape' }
RSAbstractChartPlot >> shape: aRSShape [

	shape := aRSShape
]
