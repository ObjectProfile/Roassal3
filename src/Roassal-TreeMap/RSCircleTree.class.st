"
used to calculate each circle position and radius
"
Class {
	#name : #RSCircleTree,
	#superclass : #RSObject,
	#instVars : [
		'radius',
		'x',
		'y'
	],
	#category : #'Roassal3-TreeMap-Circular'
}

{ #category : #'instance creation' }
RSCircleTree class >> radius: aNumber [
	^ self new
		radius: aNumber;
		yourself
]

{ #category : #'instance creation' }
RSCircleTree class >> vector: vector radius: aNumber [
	^ self new
		radius: aNumber;
		x: vector x;
		y: vector y;
		yourself
]

{ #category : #accessing }
RSCircleTree >> center [
	^ RSCircleVector x: x y: y
]

{ #category : #public }
RSCircleTree >> combine: circle [
	| vector deltaRadius radius1 radius2 |
	radius1 := self radius.
	radius2 := circle radius.
	vector := RSCircleVector circle: circle minus: self.
	vector lengthenBy: radius1 + radius2.
	vector scaleBy: 0.5.
	deltaRadius := vector magnitude.
	deltaRadius >= radius1 ifTrue: [
		vector shortenBy: radius1.
		vector add: self center.
		^ self class vector: vector radius: deltaRadius ].

	^ radius1 >= radius2
		ifTrue: [ self ]
		ifFalse: [ circle ]
]

{ #category : #computing }
RSCircleTree >> distanceTo: circle [
	| a b |
	a := x - circle x.
	b := y - circle y.
	^ ((a * a) + (b * b)) sqrt
]

{ #category : #testing }
RSCircleTree >> intersects: circle [
	^ (circle center - self center) magnitude < (self radius + circle radius - Number epsilon)
]

{ #category : #accessing }
RSCircleTree >> radius [
	^ radius
]

{ #category : #accessing }
RSCircleTree >> radius: aNumber [
	radius := aNumber.
	x := y := 0
]

{ #category : #public }
RSCircleTree >> scaleFull: factor [
	x := x * factor.
	y := y * factor.
	radius := radius * factor
]

{ #category : #public }
RSCircleTree >> translateBy: vector [
	x := x + vector x.
	y := y + vector y
]

{ #category : #accessing }
RSCircleTree >> x [
	^ x
]

{ #category : #accessing }
RSCircleTree >> x: aNumber [
	x := aNumber
]

{ #category : #accessing }
RSCircleTree >> y [
	^ y
]

{ #category : #accessing }
RSCircleTree >> y: aNumber [
	y := aNumber
]
