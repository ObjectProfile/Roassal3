"
I am an ellipse shape
"
Class {
	#name : #TSEllipse,
	#superclass : #TSBoundingShape,
	#category : #'Roassal3-Trachel-Shape'
}

{ #category : #visiting }
TSEllipse >> buildPathOn: visitor [
	visitor buildEllipsePath: self
]

{ #category : #testing }
TSEllipse >> includesPoint: aPoint [
	"Implementation is taken over from EllipseMorph>>containsPoint:"
	| invertedPoint radius other delta xOverY t1 t2 rect |
	invertedPoint := matrix inverseTransform: aPoint.
	rect := self baseRectangle.
	(rect containsPoint: invertedPoint) ifFalse: [ ^ false ]. "quick elimination"
	radius := rect height asFloat / 2.
	other := rect width asFloat / 2.
	delta := invertedPoint - rect topLeft - (other@radius).
	xOverY := rect width asFloat / rect height asFloat.
	t1 := (delta x asFloat / xOverY) squared + delta y squared.
	t2 := radius squared.
	^ (t1 < t2)  or: [ t1 closeTo: t2 ].
]

{ #category : #accessing }
TSEllipse >> radius [
	^ self extent x / 2
]

{ #category : #accessing }
TSEllipse >> radius: integer [
	self extent: integer * 2 asPoint
]
