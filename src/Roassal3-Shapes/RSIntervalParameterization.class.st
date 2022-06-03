Class {
	#name : #RSIntervalParameterization,
	#superclass : #RSParameterization,
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #dispatching }
RSIntervalParameterization >> controlPointsChanged: points overlappingDistancesSum: controlPolygonLength [

	| samples |
	samples := (controlPolygonLength / (points size - 1)
	            * Float goldenRatio) floor max: domain size.

	self from: domain first to: domain last samples: samples
]

{ #category : #'instance creation' }
RSIntervalParameterization >> from: from to: to samples: samples [

	cumulativeArcLengths := Array new: samples
]

{ #category : #dispatching }
RSIntervalParameterization >> parameterize_RSParametricLine: aLine [

	aLine parameterized_RSIntervalParameterization: self
]
