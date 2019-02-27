"
Symmetric sinusoidal easing; scales sinIn for t in [0, 0.5] and sinOut for t in [0.5, 1].
"
Class {
	#name : #TSSinInOutInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSSinInOutInterpolator >> interpolate: t [
	^ (1 - (Float pi * t) cos ) / 2.
]
