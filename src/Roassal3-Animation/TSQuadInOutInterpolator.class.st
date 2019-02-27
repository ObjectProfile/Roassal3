"
Symmetric quadratic easing; scales quadIn for t in [0, 0.5] and quadOut for t in [0.5, 1].
Also equivalent to TSEasing poly exponent: 2.
"
Class {
	#name : #TSQuadInOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSQuadInOutInterpolator >> interpolate: i [
	| t |
	t := i *2.
	^ (t <= 1 
		ifTrue: [ t*t ]
		ifFalse: [ 
			t := t-1.
			t * (2- t)+1 ]) /2
	
]
