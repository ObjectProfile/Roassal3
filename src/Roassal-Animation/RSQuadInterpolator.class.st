"
RSEasingInterpolator quadIn
Quadratic easing. Equivalent to: RSEasingInterpolator polyIn exponent: 2

RSEasingInterpolator quadOut
Reverse quadratic easing. Equivalent to 1 - (1 - t) quadIn. Also equivalent to: RSEasingInterpolator polyOut exponent: 2.

RSEasingInterpolator quad 
RSEasingInterpolator quadInOut 
Symmetric quadratic easing; scales quadIn for t in [0, 0.5] and quadOut for t in [0.5, 1].
Also equivalent to RSEasingInterpolator poly exponent: 2.
"
Class {
	#name : 'RSQuadInterpolator',
	#superclass : 'RSEasingInterpolator',
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'interpolation' }
RSQuadInterpolator >> interpolateIn: t [
	 ^ t*t
]

{ #category : 'interpolation' }
RSQuadInterpolator >> interpolateInOut: i [
	| t |
	t := i *2.
	^ (t <= 1
		ifTrue: [ t*t ]
		ifFalse: [
			t := t-1.
			t * (2- t)+1 ]) /2
]

{ #category : 'interpolation' }
RSQuadInterpolator >> interpolateOut: t [
	^ t * (2 - t)
]
