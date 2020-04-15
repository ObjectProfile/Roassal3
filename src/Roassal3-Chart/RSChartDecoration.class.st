Class {
	#name : #RSChartDecoration,
	#superclass : #RSAbstractChartElement,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSChartDecoration >> renderIn: canvas [
	"Need to be overridden in subclasses. Useful to enrich a visualization"
	self subclassResponsibility
]
