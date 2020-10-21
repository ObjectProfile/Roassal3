"
I am an ellipse shape

Here an example:

c := RSCanvas new.
(30 to: 150 by: 10) do: [ :nb |
	b := RSBox new size: nb.
	c add: b ].
RSFlowLayout on: c nodes.
c @ RSControlsCanvas
"
Class {
	#name : #RSEllipse,
	#superclass : #RSBoundingShape,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSEllipse >> buildPathOn: visitor [
	visitor buildEllipsePath: self
]

{ #category : #geometry }
RSEllipse >> geometry [ 
	| rect e p |
	rect := self encompassingRectangle.
	e := rect extent / 2.
	p := self position.
	e = (0@0) ifTrue: [ ^ p asGPoint ].
	^ GEllipse 
		center: p
		vertex: p + (0@ e y)
		coVertex:p + (e x@ 0) 
]

{ #category : #testing }
RSEllipse >> includesPoint: aPoint [
	"Implementation is taken over from EllipseMorph>>containsPoint:"
	| invertedPoint radius other delta xOverY t1 t2 rect |
	invertedPoint := matrix rsInverseTransform: aPoint.
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
RSEllipse >> radius [
	^ self extent x / 2
]

{ #category : #accessing }
RSEllipse >> radius: integer [
	self extent: integer * 2 asPoint
]
