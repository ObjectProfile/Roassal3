"
Reverse polynomial easing; equivalent to 1 - polyIn(1 - t). If the exponent is not specified, it defaults to 3, equivalent to cubicOut.
"
Class {
	#name : #TSPolyOutInterpolator,
	#superclass : #TSPolyInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSPolyOutInterpolator >> interpolate: t [
	^ 1 - ((1 -t) raisedTo: exponent).
]
