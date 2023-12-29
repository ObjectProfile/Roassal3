"
I apply the attach point, then I return an array with the control points for the current edge.

- controlPointsFrom:to: is an abstract method, recives 2 points and it should return a collection of points
"
Class {
	#name : 'RSAbstractCPAPController',
	#superclass : 'RSAbstractCPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'testing' }
RSAbstractCPAPController class >> isAbstract [

	^ self == RSAbstractCPAPController
]

{ #category : 'hooks' }
RSAbstractCPAPController >> controlPointsFor: aLine [
	| ap |
	ap := aLine attachPoint.
	^ self
		controlPointsFrom: (ap startingPointOf: aLine)
		to: (ap endingPointOf: aLine)
]

{ #category : 'hooks' }
RSAbstractCPAPController >> controlPointsFrom: fromPoint to: toPoint [
	^ self subclassResponsibility
]
