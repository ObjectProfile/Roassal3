Class {
	#name : #RSSegmentedCPAPController,
	#superclass : #RSAbstractCPAPController,
	#instVars : [
		'maxDistanceForLinearize',
		'controlPointsController'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #accessing }
RSSegmentedCPAPController >> controlPointsController: anObject [

	controlPointsController := anObject
]

{ #category : #hooks }
RSSegmentedCPAPController >> controlPointsFrom: from to: to [

	| random anArray |
	random := RandomBoxMullerBivariateGaussian new.

	anArray := (from distanceTo: to) < maxDistanceForLinearize
		           ifTrue: [ Array with: from with: to ]
		           ifFalse: [ 
		           controlPointsController controlPointsFrom: from to: to ].

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
RSSegmentedCPAPController >> initialize [

	super initialize.

	self maxDistanceForLinearize: 25
]

{ #category : #accessing }
RSSegmentedCPAPController >> maxDistanceForLinearize: aNumber [

	maxDistanceForLinearize := aNumber
]
