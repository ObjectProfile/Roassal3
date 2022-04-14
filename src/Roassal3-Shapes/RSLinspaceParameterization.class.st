Class {
	#name : #RSLinspaceParameterization,
	#superclass : #RSParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #accessing }
RSLinspaceParameterization >> from: from to: to samples: samples [

	domain := (from to: to) linspace: samples.

	cumulativeArcLengths := Array new: samples
]

{ #category : #'as yet unclassified' }
RSLinspaceParameterization >> parameterize_RSParametricLine: aLine [

	aLine parameterized_RSLinspaceParameterization: self
]
