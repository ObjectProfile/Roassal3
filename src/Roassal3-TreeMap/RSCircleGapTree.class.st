"
used to calculate the gaps between circles
"
Class {
	#name : #RSCircleGapTree,
	#superclass : #RSObject,
	#instVars : [
		'circles'
	],
	#category : #'Roassal3-TreeMap-Circular'
}

{ #category : #'instance creation' }
RSCircleGapTree class >> circle1: aRSCircleTree circle2: aRSCircleTree2 [
	^ self new
		circles: { aRSCircleTree. aRSCircleTree2. nil };
		yourself
]

{ #category : #computing }
RSCircleGapTree >> addGapsTo: gaps closest: closest [
	| innerGap clazz |
	clazz := self class.
	gaps add: (clazz circle1: circles first circle2: closest).
	gaps add: (clazz circle1: closest circle2: circles second).

	innerGap := clazz circle1: circles second circle2: closest.
	innerGap circles at: 3 put: circles first.
	gaps add: innerGap
]

{ #category : #accessing }
RSCircleGapTree >> circles [
	^ circles
]

{ #category : #accessing }
RSCircleGapTree >> circles: aCollection [
	circles := aCollection
]

{ #category : #computing }
RSCircleGapTree >> makeGapCircle: r [
	| in1 in2 r1 r2 d a h p2 x0 y0 x1 y1 x2 y2 |
	in1 := circles first.
	in2 := circles second.
	r1 := in1 radius + r.
	r2 := in2 radius + r.
	d := in1 distanceTo: in2.
	(((d > (r1 + r2) ) ifTrue: [ 1 ] ifFalse: [ 0 ] ) |
	( (d < (r1 - r2) abs) ifTrue: [ 1 ] ifFalse: [ 0 ])) ~= 0 ifTrue: [ ^ nil ].

	a := ((r1 * r1) - (r2 * r2) + (d * d))/ (2* d).
	h := ((r1 * r1)-(a *a )) sqrt.

	p2 := in1 center.
	p2 add: (((RSCircleVector circle: in2 minus: in1) scaleBy: a) scaleBy: 1/d).
	x0 := in1 x. x1 := in2 x. x2 := p2 x.
	y0 := in1 y. y1 := in2 y. y2 := p2 y.

	^ RSCircleTree
		vector: (x2 + (h * (y1-y0)/ d)) @ (y2 - (h * (x1-x0)/ d))
		radius: r
]
