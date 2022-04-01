Class {
	#name : #RSSegmentedCPAPController,
	#superclass : #RSAbstractCPAPController,
	#instVars : [
		'controlPointsController',
		'linearizationPredicate'
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

	anArray := (linearizationPredicate value: from value: to)
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
			            random next + tPoint ]) allButLast ].

	anArray atLast: 1 put: anArray last , { (random next + to) }.

	^ anArray
]

{ #category : #hooks }
RSSegmentedCPAPController >> initialize [

	super initialize.

	self linearizationPredicate: [ :from :to | 
		(from distanceTo: to) < 50 ]
]

{ #category : #accessing }
RSSegmentedCPAPController >> linearizationPredicate: aBlock [

	linearizationPredicate := aBlock
]
