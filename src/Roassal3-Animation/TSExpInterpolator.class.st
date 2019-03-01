"
TSEasing expIn
Exponential easing; raises 2 to the exponent 10 * (t - 1).

TSEasing expOut 
Reverse exponential easing; equivalent to 1 - expIn(1 - t).

TSEasing exp 
TSEasing expInOut 
Symmetric exponential easing; scales expIn for t in [0, 0.5] and expOut for t in [0.5, 1].
"
Class {
	#name : #TSExpInterpolator,
	#superclass : #TSEasing,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSExpInterpolator >> interpolateIn: t [
	^ 2 raisedTo: (10 * t - 10).
]

{ #category : #interpolation }
TSExpInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.
 
	^ (t <= 1
		ifTrue: [ 2 raisedTo: 10 * t - 10 ]
		ifFalse: [ 2 - (2 raisedTo: 10 - (10 * t)) ])/2
]

{ #category : #interpolation }
TSExpInterpolator >> interpolateOut: t [
	^ 1 - (2 raisedTo: -10 * t).
]
