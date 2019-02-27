"
Symmetric cubic easing; scales cubicIn for t in [0, 0.5] and cubicOut for t in [0.5, 1]. 

Also equivalent to TSEasing poly exponent: 3.

"
Class {
	#name : #TSCubicInOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSCubicInOutInterpolator >> interpolate: i [
	| t |
	t := i * 2.
	^ (t <= 1 
		ifTrue: [ t * t * t  ]
		ifFalse: [ 
			t := t - 2.
			t * t * t + 2 ])/2
]
