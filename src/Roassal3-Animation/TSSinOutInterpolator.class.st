"
Reverse sinusoidal easing; equivalent to 1 - sinIn(1 - t).
"
Class {
	#name : #TSSinOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSSinOutInterpolator >> interpolate: t [
	^ (t * Float halfPi) sin
]
