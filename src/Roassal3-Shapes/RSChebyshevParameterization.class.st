Class {
	#name : #RSChebyshevParameterization,
	#superclass : #RSIntervalParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'instance creation' }
RSChebyshevParameterization >> from: from to: to samples: samples [

	domain := (from to: to) chebyshevInclusive: samples.

	super from: from to: to samples: samples
]
