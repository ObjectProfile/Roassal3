"
My subclasses can determine the control points for an object usefull for the update process
"
Class {
	#name : #RSAbstractCPController,
	#superclass : #RSObject,
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #hooks }
RSAbstractCPController >> controlPointsFor: anEdge [
	"return an array of points generated from the edge"
	^ self subclassResponsibility 
]
