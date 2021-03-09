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
	offsetRatio :=0.
]

{ #category : #accessing }
RSMarker >> offset [
	^ offset
]

{ #category : #accessing }
RSMarker >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
RSMarker >> offsetRatio [
	^ offsetRatio
]

{ #category : #accessing }
RSMarker >> offsetRatio: aFloat [
	"[0 1] value"
	offsetRatio := aFloat
]

{ #category : #public }
RSMarker >> setPositionTo: from vector: vector do: aBlock [
	| angle pos |
	angle := vector angle.
	"0.00001 in order to avoid inverseTransform bad result with sx = 0"
	angle := angle + Float halfPi.
	pos := from.
	
	shape matrix
		loadIdentity;
		rotateByRadians: angle.
	(self offset isZero and: [ self offsetRatio isZero ]) ifFalse: [ 
		| unit |
		unit := vector / (vector r max: 1).
		pos := pos -(vector * self offsetRatio) - (unit * self offset)
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
	self setPositionTo: to vector: to-from do: aBlock.
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
	self setPositionTo: from vector: from - to do: aBlock.
]
