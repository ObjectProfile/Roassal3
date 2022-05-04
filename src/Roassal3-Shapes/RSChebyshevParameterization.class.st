Class {
	#name : #RSChebyshevParameterization,
	#superclass : #RSIntervalParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'instance creation' }
RSChebyshevParameterization >> from: from to: to samples: samples [

	| sum diff denominator |
	sum := (from + to) halved.
	diff := (to - from) halved.
	denominator := samples << 1.

	domain := Array new: samples.

	1 to: samples do: [ :k | 
		| knot |
		knot := diff * (Float π * (k << 1 - 1) / denominator) cos.
		domain atLast: k put: sum + knot ].

	super from: from to: to samples: samples
]
