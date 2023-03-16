"
TODO
"
Class {
	#name : #RSAbstractChartDecoration,
	#superclass : #RSAbstractChartPlot,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #'private - adding' }
RSAbstractChartDecoration >> addedIn: aRSChart [
	aRSChart addDecoration: self
]

{ #category : #testing }
RSAbstractChartDecoration >> isDecoration [
	^ true
]

{ #category : #testing }
RSAbstractChartDecoration >> isSpineDecoration [
	^ false
]
