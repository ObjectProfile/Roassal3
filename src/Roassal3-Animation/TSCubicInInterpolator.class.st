"
Cubic easing; equivalent to: TSEasing poly exponent: 3.
"
Class {
	#name : #TSCubicInInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSCubicInInterpolator >> interpolate: t [
	^ t * t * t
]
