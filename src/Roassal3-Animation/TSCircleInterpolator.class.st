"
TSEasing circleIn
Circular easing.

TSEasing circleOut
Is Reverse circular easing; equivalent to 1 - interpolateIn: 1 - t.

TSEasing circleInOut
TSEasing circle
Symmetric circular easing; scales circleIn for t in {0. 0.5} and circleOut for t in {0.5, 1}.


"
Class {
	#name : #TSCircleInterpolator,
	#superclass : #TSEasing,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSCircleInterpolator >> interpolateIn:  t [
	^ 1 - (1 - (t * t) ) sqrt
]

{ #category : #interpolation }
TSCircleInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.
	^ (t<=1
		ifTrue: [ 1 - (1 - (t*t)) sqrt ]
		ifFalse: [ 
			t := t - 2.
			(1 - (t*t)) sqrt + 1 ])/2
]

{ #category : #interpolation }
TSCircleInterpolator >> interpolateOut: i [
	| t |
	t := i -1.
	^ (1 - (t* t)) sqrt.

]
