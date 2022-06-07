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
RSSegmentedCPAPController >> controlPointsFor: aLine [

	| random anArray from to |
	random := RandomBoxMullerBivariateGaussian new.

	anArray := controlPointsController controlPointsFor: aLine.

	from := anArray first.
	to := anArray last.

	(linearizationPredicate value: from value: to) ifTrue: [ 
		anArray := Array with: from with: to ].

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
RSSegmentedCPAPController >> controlPointsFor_: aLine [

	| random anArray from to |
	random := RandomBoxMullerBivariateGaussian new.

	anArray := controlPointsController controlPointsFor: aLine.

	from := anArray first.
	to := anArray last.

	(linearizationPredicate value: from value: to) ifTrue: [ 
		anArray := Array with: from with: to ].

	anArray := anArray overlappingPairsCollect: [ :aPoint :anotherPoint | 
		           | samples distance |
		           distance := aPoint distanceTo: anotherPoint.

		           samples := ((distance closeTo: 0)
			                       ifTrue: [ 0 ]
			                       ifFalse: [ distance ln ceiling ]) max: 4.

		           (((0 to: 1) linspace: "samples + 1" 5) collect: [ :t | 
			            | tPoint |
			            tPoint := aPoint unitAffine: anotherPoint at: 1 - t.
			            random next + tPoint ]) allButLast ].

	anArray atLast: 1 put: anArray last allButLast , { (random next + to) }.

	^ anArray
]

{ #category : #hooks }
RSSegmentedCPAPController >> controlPointsFrom: from to: to [

	self shouldNotImplement
]

{ #category : #hooks }
RSSegmentedCPAPController >> initialize [

	super initialize.

	self linearizationPredicate: [ :from :to | 
		(from distanceTo: to) < 50 ]
]

{ #category : #accessing }
RSSegmentedCPAPController >> linearizationPredicate [

	^ linearizationPredicate
]

{ #category : #accessing }
RSSegmentedCPAPController >> linearizationPredicate: aBlock [

	linearizationPredicate := aBlock
]
