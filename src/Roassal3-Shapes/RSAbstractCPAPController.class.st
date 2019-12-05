"
I apply the attachpoint and then return an array with the control points for the current edge
"
Class {
	#name : #RSAbstractCPAPController,
	#superclass : #RSAbstractCPController,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #hooks }
RSAbstractCPAPController >> controlPointsFor: anEdge [
	| ap |
	ap := anEdge attachPoint.
	^ self
		controlPointsFrom: (ap startingPointOf: anEdge)
		to: (ap endingPointOf: anEdge).
]

{ #category : #hooks }
RSAbstractCPAPController >> controlPointsFrom: fromPoint to: toPoint [
	^ self subclassResponsibility
]
