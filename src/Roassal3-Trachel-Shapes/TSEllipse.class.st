"
I am an ellipse shape
"
Class {
	#name : #TSEllipse,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #testing }
TSEllipse >> includesPoint: aPoint [
	"Implementation is taken over from EllipseMorph>>containsPoint:"
	| invertedPoint radius other delta xOverY t1 t2 |
	invertedPoint := matrix inverseTransform: aPoint.
	(baseRectangle containsPoint: invertedPoint) ifFalse: [ ^ false ]. "quick elimination"
	radius := baseRectangle height asFloat / 2.
	other := baseRectangle width asFloat / 2.
	delta := invertedPoint - baseRectangle topLeft - (other@radius).
	xOverY := baseRectangle width asFloat / baseRectangle height asFloat.
	t1 := (delta x asFloat / xOverY) squared + delta y squared.
	t2 := radius squared.
	^ (t1 < t2)  or: [ t1 closeTo: t2 ].
]

{ #category : #visiting }
TSEllipse >> pathFor: visitor [
	^ visitor pathOfEllipse: self
]

{ #category : #accessing }
TSEllipse >> radius: integer [
	self extent: integer * 2 asPoint
]
