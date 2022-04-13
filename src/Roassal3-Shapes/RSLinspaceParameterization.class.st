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
