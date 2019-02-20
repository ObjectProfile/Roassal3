"
I am the basic interpolator for numbers
"
Class {
	#name : #TSNumberInterpolator,
	#superclass : #TSInterpolator,
	#category : #'Roassal3-Scales'
}

{ #category : #interpolation }
TSNumberInterpolator >> interpolate: t [
	^ (start * (1 - t)) + (stop * t).
]
