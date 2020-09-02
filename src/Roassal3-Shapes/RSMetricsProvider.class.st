Class {
	#name : #RSMetricsProvider,
	#superclass : #RSObject,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSMetricsProvider >> extentsOf: aString with: aFont [
	^ self subclassResponsibility
]
