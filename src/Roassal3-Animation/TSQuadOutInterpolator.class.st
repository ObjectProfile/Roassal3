"
Reverse quadratic easing
Equivalent to 1 - (1 - t) quadIn. Also equivalent to: TSEasing polyOut exponent: 2.
"
Class {
	#name : #TSQuadOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSQuadOutInterpolator >> interpolate: t [
	^ t * (2 - t)
]
