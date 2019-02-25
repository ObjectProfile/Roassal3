"
I represent a visual component box in a canvas
"
Class {
	#name : #TSBox,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #testing }
TSBox >> includesPoint: aPoint [
	| invertedPoint |
	invertedPoint := matrix inverseTransform: aPoint.
	^ baseRectangle containsPoint: invertedPoint.
]

{ #category : #visiting }
TSBox >> pathFor: visitor [
	^ visitor pathOfBox: self
]
