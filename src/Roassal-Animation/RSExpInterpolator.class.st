"
RSEasingInterpolator expIn
Exponential easing; raises 2 to the exponent 10 * (t - 1).

RSEasingInterpolator expOut 
Reverse exponential easing; equivalent to 1 - expIn(1 - t).

RSEasingInterpolator exp 
RSEasingInterpolator expInOut 
Symmetric exponential easing; scales expIn for t in [0, 0.5] and expOut for t in [0.5, 1].
"
Class {
	#name : 'RSExpInterpolator',
	#superclass : 'RSEasingInterpolator',
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'interpolation' }
RSExpInterpolator >> interpolateIn: t [
	^ 2 raisedTo: (10 * t - 10)
]

{ #category : 'interpolation' }
RSExpInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.

	^ (t <= 1
		ifTrue: [ 2 raisedTo: 10 * t - 10 ]
		ifFalse: [ 2 - (2 raisedTo: 10 - (10 * t)) ])/2
]

{ #category : 'interpolation' }
RSExpInterpolator >> interpolateOut: t [
	^ 1 - (2 raisedTo: -10 * t)
]
