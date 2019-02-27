"
Polynomial easing; raises t to the specified exponent. If the exponent is not specified, it defaults to 3, equivalent to cubicIn.
"
Class {
	#name : #TSPolyInInterpolator,
	#superclass : #TSPolyInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSPolyInInterpolator >> interpolate: i [
	^ i raisedTo: exponent.
]
