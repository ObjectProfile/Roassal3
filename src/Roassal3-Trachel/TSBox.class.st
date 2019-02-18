"
I represent a visual component box in a canvas
"
Class {
	#name : #TSBox,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSBox >> accept: visitor [
	visitor visitBox: self
]

{ #category : #testing }
TSBox >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ self encompassingRectangle containsPoint: invertedPoint.
]
