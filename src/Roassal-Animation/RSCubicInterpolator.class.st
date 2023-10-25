"
RSEasingInterpolator cubicIn
Cubic easing; equivalent to: RSEasingInterpolator poly exponent: 3.

RSEasingInterpolator cubicOut
Reverse cubic easing; equivalent to 1 - RSEasingInterpolator cubicIn interpolate: (1 - t). Also equivalent to RSEasingInterpolator polyOut exponent: 3.

RSEasingInterpolator cubic 
RSEasingInterpolator cubicInOut 
Symmetric cubic easing; scales cubicIn for t in {0. 0.5} and cubicOut for t in {0.5. 1}. 
Also equivalent to RSEasingInterpolator poly exponent: 3.

"
Class {
	#name : 'RSCubicInterpolator',
	#superclass : 'RSEasingInterpolator',
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'interpolation' }
RSCubicInterpolator >> interpolateIn: t [
	^ t * t * t
]

{ #category : 'interpolation' }
RSCubicInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.
	^ (t <= 1
		ifTrue: [ t * t * t  ]
		ifFalse: [
			t := t - 2.
			t * t * t + 2 ])/2
]

{ #category : 'interpolation' }
RSCubicInterpolator >> interpolateOut: i [
	| t |
	t := i -1.
	^ t * t * t + 1
]
