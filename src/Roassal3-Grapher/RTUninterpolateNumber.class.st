"
I uninterpolate a value of x acording to 2 limits, a and b
"
Class {
	#name : #RTUninterpolateNumber,
	#superclass : #RTUninterpolate,
	#category : #'Roassal3-Grapher-Builder-Grapher-Scaling'
}

{ #category : #interpolating }
RTUninterpolateNumber >> uninterpolate: x [
	^ (x - a )/b
]
