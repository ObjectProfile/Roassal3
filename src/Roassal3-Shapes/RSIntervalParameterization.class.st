Class {
	#name : #RSIntervalParameterization,
	#superclass : #RSParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'instance creation' }
RSIntervalParameterization >> from: from to: to samples: samples [

	cumulativeArcLengths := Array new: samples
]

{ #category : #dispatching }
RSIntervalParameterization >> parameterize_RSParametricLine: aLine [

	aLine parameterized_RSIntervalParameterization: self
]
