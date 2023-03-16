"
TSEasing sinIn
Sinusoidal easing; returns sin(t).

TSEasing sinOut
Reverse sinusoidal easing; equivalent to 1 - sinIn(1 - t).

TSEasing sin 
TSEasing sinInOut
Symmetric sinusoidal easing; scales sinIn for t in [0, 0.5] and sinOut for t in [0.5, 1].
"
Class {
	#name : #RSSinInterpolator,
	#superclass : #RSEasingInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
RSSinInterpolator >> interpolateIn: t [
	^ 1 - (t * Float halfPi) cos
]

{ #category : #interpolation }
RSSinInterpolator >> interpolateInOut: t [
	^ (1 - (Float pi * t) cos ) / 2
]

{ #category : #interpolation }
RSSinInterpolator >> interpolateOut: t [
	^ (t * Float halfPi) sin
]
