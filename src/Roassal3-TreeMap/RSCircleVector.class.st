"
Vector used with some custom methods to calculate the node position
"
Class {
	#name : #RSCircleVector,
	#superclass : #RSObject,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #'Roassal3-TreeMap-Circular'
}

{ #category : #'instance creation' }
RSCircleVector class >> circle: c1 minus: c0 [
	^ self
		x: c1 x - c0 x
		y: c1 y - c0 y
]

{ #category : #'instance creation' }
RSCircleVector class >> x: x y: y [
	^ self new
		x: x;
		y: y;
		yourself
]

{ #category : #'instance creation' }
RSCircleVector class >> x: x y: y z: z [
	^ self new
		x: x;
		y: y;
		z: z;
		yourself
]

{ #category : #arithmetic }
RSCircleVector >> - w [
	^ self class
		x: x - w x
		y: y - w y
		z: z - w z
]

{ #category : #computing }
RSCircleVector >> add: rhs [
	x := x + rhs x.
	y := y + rhs y.
	z := z + rhs z
]

{ #category : #computing }
RSCircleVector >> cross: w [
	^ self class
		x: (y * w z) - (z * w y)
		y: (z * w x) - (x * w z)
		z: (x * w y) - (y * w x)
]

{ #category : #computing }
RSCircleVector >> dot: w [
	^ (x * w x) + (y * w y) + (z * w z)
]

{ #category : #initialization }
RSCircleVector >> initialize [
	super initialize.
	x := 0.
	y := 0.
	z := 0
]

{ #category : #testing }
RSCircleVector >> isZero [
	^ x isZero and: [ y isZero and: [ z isZero ] ]
]

{ #category : #computing }
RSCircleVector >> lengthenBy: val [
	| mag |
	mag := self magnitude.
	self scaleBy: ((mag + val)/ mag)
]

{ #category : #computing }
RSCircleVector >> magnitude [
	^ ( (x * x) + (y * y) + (z * z) ) sqrt
]

{ #category : #computing }
RSCircleVector >> normalize [
	| mag |
	mag := self magnitude.
	mag = 0 ifTrue: [ ^ mag ].
	x := x / mag.
	y := y / mag.
	z := z / mag.
	^ mag
]

{ #category : #computing }
RSCircleVector >> normalize: length [
	self normalize.
	self scaleBy: length
]

{ #category : #computing }
RSCircleVector >> rotate: axis angle: angle [
	| n |
	n := self class x: axis x y: axis y z: axis z.
	n normalize.
	n scaleBy: (n dot: self).
	n add: ((self - n) scaleBy: angle cos ).
	n add: ((n cross: self) scaleBy: angle sin).
	^ n
]

{ #category : #computing }
RSCircleVector >> scaleBy: factor [
	x := x * factor.
	y := y * factor.
	z := z * factor
]

{ #category : #computing }
RSCircleVector >> shortenBy: val [
	self lengthenBy: val negated
]

{ #category : #accessing }
RSCircleVector >> x [
	^ x
]

{ #category : #accessing }
RSCircleVector >> x: anInteger [
	x := anInteger
]

{ #category : #accessing }
RSCircleVector >> y [
	^ y
]

{ #category : #accessing }
RSCircleVector >> y: anInteger [
	y := anInteger
]

{ #category : #accessing }
RSCircleVector >> z [
	^ z
]

{ #category : #accessing }
RSCircleVector >> z: aNumber [
	z := aNumber
]
