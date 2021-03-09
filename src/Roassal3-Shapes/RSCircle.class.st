"
I am a circle shape

Here an example:

```Smalltalk
c := RSCanvas new.
(30 to: 150 by: 10) do: [ :nb |
b := RSCircle new size: nb.
c add: b ].
RSFlowLayout on: c nodes.
c @ RSCanvasController.
c open
```
"
Class {
	#name : #RSCircle,
	#superclass : #RSCircularShape,
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSCircle >> buildPathOn: visitor [
	visitor buildEllipsePath: self
]

{ #category : #accessing }
RSCircle >> extent: aPoint [
	self assert: [ aPoint x = aPoint y ] description: 'Width and height should have the same value'.
	super extent: aPoint
]

{ #category : #geometry }
RSCircle >> geometry [ 
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

{ #category : #matrix }
RSCircle >> height: anInteger [
	self error: 'Should not be performed'
]

{ #category : #testing }
RSCircle >> includesPoint: aPoint [
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
RSCircle >> radius [
	^ self extent x / 2
]

{ #category : #accessing }
RSCircle >> radius: integer [
	self extent: integer * 2 asPoint
]

{ #category : #matrix }
RSCircle >> width: anInteger [
	self error: 'Should not be performed'
]

{ #category : #matrix }
RSCircle >> x: anInteger [
	self error: 'Should not be performed'
]

{ #category : #matrix }
RSCircle >> y: anInteger [
	self error: 'Should not be performed'
]
