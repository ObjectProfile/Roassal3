"
I am the basic interpolator for numbers
"
Class {
	#name : #TSNumberInterpolator,
	#superclass : #TSAbstractInterpolator,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSNumberInterpolator >> interpolate: t [
	^ (start * (1 - t)) + (stop * t).
]
