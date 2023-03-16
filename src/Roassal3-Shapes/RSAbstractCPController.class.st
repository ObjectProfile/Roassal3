"
My subclasses can determine the control points for an object usefull for the update process of lines/edges with control points

- controlPointsFor: is an abstract method, recibes an edge and it should return a collection of points
"
Class {
	#name : #RSAbstractCPController,
	#superclass : #RSObject,
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #testing }
RSAbstractCPController class >> isAbstract [

	^ self == RSAbstractCPController
]

{ #category : #hooks }
RSAbstractCPController >> controlPointsFor: aLine [
	"return an array of points generated from the line"
	^ self subclassResponsibility
]
