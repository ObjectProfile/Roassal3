"
Abstract class to descripbe how to create a popup for a given position
"
Class {
	#name : #RSAbstractChartPopupBuilder,
	#superclass : #RSObject,
	#instVars : [
		'position'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSAbstractChartPopupBuilder >> position [
	^ position
]

{ #category : #accessing }
RSAbstractChartPopupBuilder >> position: aPoint [
	position := aPoint
]

{ #category : #hooks }
RSAbstractChartPopupBuilder >> shapeFor: aRSChart [
	^ self subclassResponsibility
]
