"
TSEasing quadIn
Quadratic easing. Equivalent to: TSEasing polyIn exponent: 2

TSEasing quadOut
Reverse quadratic easing. Equivalent to 1 - (1 - t) quadIn. Also equivalent to: TSEasing polyOut exponent: 2.

TSEasing quad 
TSEasing quadInOut 
Symmetric quadratic easing; scales quadIn for t in [0, 0.5] and quadOut for t in [0.5, 1].
Also equivalent to TSEasing poly exponent: 2.
"
Class {
	#name : #RSQuadInterpolator,
	#superclass : #RSEasingInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
RSQuadInterpolator >> interpolateIn: t [
	 ^ t*t
]

{ #category : #interpolation }
RSQuadInterpolator >> interpolateInOut: i [
	| t |
	t := i *2.
	^ (t <= 1
		ifTrue: [ t*t ]
		ifFalse: [
			t := t-1.
			t * (2- t)+1 ]) /2
]

{ #category : #interpolation }
RSQuadInterpolator >> interpolateOut: t [
	^ t * (2 - t)
]
