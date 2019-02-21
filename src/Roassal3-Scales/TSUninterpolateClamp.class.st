"
I do not allow a value get off the scale of 
0 to 1
"
Class {
	#name : #TSUninterpolateClamp,
	#superclass : #TSUninterpolate,
	#category : #'Roassal3-Scales'
}

{ #category : #interpolating }
TSUninterpolateClamp >> uninterpolate: x [
	^ 0 max: (1 min: ((x - a ) / b))
]
