"
I uninterpolate a value of x acording to 2 limits, a and b
"
Class {
	#name : #TSUninterpolateNumber,
	#superclass : #TSUninterpolate,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolating }
TSUninterpolateNumber >> uninterpolate: x [
	^ (x - a )/b
]
