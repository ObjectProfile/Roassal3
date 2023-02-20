"
I represent a marker for RSLine, RSPolygon and RSBezier
"
Class {
	#name : #RSMarker,
	#superclass : #RSObject,
	#instVars : [
		'shape',
		'offset',
		'offsetRatio'
	],
	#category : #'Roassal3-Shapes-Border'
}

{ #category : #converting }
RSMarker >> asMarker [
	^ self
]

{ #category : #initialization }
RSMarker >> initialize [
	super initialize.
	offset := 0.
	offsetRatio := 0
]

{ #category : #accessing }
RSMarker >> offset [
	^ offset
]

{ #category : #accessing }
RSMarker >> offset: aNumber [
	"Set the offset in pixel. Consider:
```
c := RSCanvas new.

box := RSBox new.
circle := RSCircle new.

c add: box; add: circle.
box @ RSDraggable.
circle @ RSDraggable.

circle translateTo: 50 @ 40.

line := RSLine new.
line withBorderAttachPoint.
marker := (RSCircle new size: 5; color: #red) asMarker.
marker offset: 10.
line marker: marker.
line from: box.
line to: circle.
c add: line.
c zoomToFit.
c open
```"
	offset := aNumber
]

{ #category : #accessing }
RSMarker >> offsetRatio [
	^ offsetRatio
]

{ #category : #accessing }
RSMarker >> offsetRatio: aFloat [
	"Set the offset ratio of the marker. The argument is a float and has to range from 0 to 1.

```
c := RSCanvas new.

box := RSBox new.
circle := RSCircle new.

c add: box; add: circle.
box @ RSDraggable.
circle @ RSDraggable.

circle translateTo: 50 @ 40.

line := RSLine new.
line withBorderAttachPoint.
marker := (RSCircle new size: 5; color: #red) asMarker.
marker offsetRatio: 0.7.
line marker: marker.
line from: box.
line to: circle.
c add: line.
c zoomToFit.
c open
```
"
	offsetRatio := aFloat
]

{ #category : #copying }
RSMarker >> postCopy [
	shape := shape copy
]

{ #category : #public }
RSMarker >> setPositionTo: from vector: vector do: aBlock [
	| angle pos |
	angle := vector angle.
	angle := angle + Float halfPi.
	pos := from.

	shape matrix
		loadIdentity;
		rotateByRadians: angle.
	(self offset isZero and: [ self offsetRatio isZero ]) ifFalse: [
		| unit |
		unit := vector / (vector r max: 1).
		pos := pos - (vector * self offsetRatio) - (unit * self offset).
		 ].
	shape position: pos.
	aBlock value: shape
]

{ #category : #accessing }
RSMarker >> shape [
	^ shape
]

{ #category : #accessing }
RSMarker >> shape: anObject [
	shape := anObject
]

{ #category : #public }
RSMarker >> withEnd: controlPoints do: aBlock [
	| from to |
	controlPoints size < 2 ifTrue: [ ^ self ].
	from := controlPoints at: controlPoints size - 1.
	to := controlPoints last.
	self setPositionTo: to vector: to-from do: aBlock
]

{ #category : #public }
RSMarker >> withMid: controlPoints do: aBlock [
	controlPoints size < 3 ifTrue: [ ^ self ].
	1 to: controlPoints size - 2 do: [ :i | | a b |
		a := controlPoints at: i.
		b := controlPoints at: i + 1.
		self setPositionTo: b vector: b - a do: aBlock ]
]

{ #category : #public }
RSMarker >> withStart: controlPoints do: aBlock [
	| from to |
	controlPoints size < 2 ifTrue: [ ^ self ].
	from := controlPoints first.
	to := controlPoints second.
	self setPositionTo: from vector: from - to do: aBlock
]
