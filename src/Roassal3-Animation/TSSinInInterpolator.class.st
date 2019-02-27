"
Sinusoidal easing; returns sin(t).
"
Class {
	#name : #TSSinInInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSSinInInterpolator >> interpolate: t [
	"1 - Math.cos(t * halfPi);"
	^ 1 - (t * Float halfPi) cos
]
