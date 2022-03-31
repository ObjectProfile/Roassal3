Class {
	#name : #RSHorizontalSegmentedCPAPController,
	#superclass : #RSHorizontalCPAPController,
	#instVars : [
		'maxDistanceForLinearize'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #hooks }
RSHorizontalSegmentedCPAPController >> controlPointsFrom: from to: to [

	| random anArray |
	random := RandomBoxMullerBivariateGaussian new.

	anArray := anArray := (from distanceTo: to) < maxDistanceForLinearize
		                      ifTrue: [ Array with: from with: to ]
		                      ifFalse: [ 
		                      super controlPointsFrom: from to: to ].

	anArray := anArray overlappingPairsCollect: [ :aPoint :anotherPoint | 
		           | samples distance |
		           distance := aPoint distanceTo: anotherPoint.
		           samples := ((distance closeTo: 0)
			                       ifTrue: [ 0 ]
			                       ifFalse: [ distance ln ceiling ]) max: 4.

		           (((0 to: 1) linspace: samples + 1) collect: [ :t | 
			            | tPoint |
			            tPoint := aPoint unitAffine: anotherPoint at: 1 - t.
			            random next * Float goldenRatio + tPoint ]) allButLast ].

	anArray
		atLast: 1
		put: anArray last , { (random next * Float goldenRatio + to) }.

	^ anArray
]

{ #category : #accessing }
RSHorizontalSegmentedCPAPController >> initialize [

	super initialize.

	self maxDistanceForLinearize: 100
]

{ #category : #accessing }
RSHorizontalSegmentedCPAPController >> maxDistanceForLinearize: aNumber [

	maxDistanceForLinearize := aNumber
]
