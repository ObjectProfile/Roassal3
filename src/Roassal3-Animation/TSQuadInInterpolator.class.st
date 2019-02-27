"
Quadratic easing.
Equivalent to: TSEasing polyIn exponent: 2
"
Class {
	#name : #TSQuadInInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSQuadInInterpolator >> interpolate: t [
	 ^ t*t
]
