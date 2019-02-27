"
Reverse cubic easing; equivalent to 1 - cubicIn(1 - t). 

Also equivalent to TSEasing polyOut exponent: 3.
"
Class {
	#name : #TSCubicOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSCubicOutInterpolator >> interpolate: i [
	| t |
	t := i -1.
	^ t * t * t + 1
]
