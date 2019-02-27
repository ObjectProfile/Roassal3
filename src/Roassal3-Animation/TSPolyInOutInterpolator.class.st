"
Symmetric polynomial easing; scales polyIn for t in [0, 0.5] and polyOut for t in [0.5, 1]. If the exponent is not specified, it defaults to 3, equivalent to cubic.
"
Class {
	#name : #TSPolyInOutInterpolator,
	#superclass : #TSPolyInterpolator,
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #interpolation }
TSPolyInOutInterpolator >> interpolate: i [
	| t |
	t := i * 2.
	^ (t <= 1
		ifTrue: [ t raisedTo: exponent ]
		ifFalse: [ 2 - ( ( 2 - t) raisedTo: exponent ) ]) / 2
	
]
