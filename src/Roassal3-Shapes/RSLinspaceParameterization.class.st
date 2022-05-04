Class {
	#name : #RSLinspaceParameterization,
	#superclass : #RSIntervalParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #accessing }
RSLinspaceParameterization >> from: from to: to samples: samples [

	domain := (from to: to) linspace: samples.

	super from: from to: to samples: samples
]
