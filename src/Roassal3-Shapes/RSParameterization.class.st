Class {
	#name : #RSParameterization,
	#superclass : #RSObject,
	#instVars : [
		'domain',
		'cumulativeArcLengths'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #accessing }
RSParameterization >> arcLength [

	^ cumulativeArcLengths last
]

{ #category : #enumerating }
RSParameterization >> collect: aBlock [

	"I enumerate the domain, just avoid to expose it through an accessor."

	^ domain collect: aBlock
]

{ #category : #dispatching }
RSParameterization >> controlPointsChanged: points overlappingDistancesSum: controlPolygonLength [

	self subclassResponsibility
]

{ #category : #'instance creation' }
RSParameterization >> from [

	^ domain first
]

{ #category : #dispatching }
RSParameterization >> parameterize_RSParametricLine: aLine [

	self subclassResponsibility
]

{ #category : #copying }
RSParameterization >> postCopy [

	domain := domain copy.

	cumulativeArcLengths := cumulativeArcLengths copy
]

{ #category : #accessing }
RSParameterization >> size [

	^ domain size
]

{ #category : #'instance creation' }
RSParameterization >> to [

	^ domain last
]

{ #category : #accessing }
RSParameterization >> unitAt: aNumber [

	^ domain unitAt: aNumber
]

{ #category : #enumerating }
RSParameterization >> withIndexDo: aBlock [

	| lastPoint arcLength |
	arcLength := 0.0.
	cumulativeArcLengths at: 1 put: 0.0.

	lastPoint := aBlock value: domain first value: 1.

	2 to: self size do: [ :index | 
		| aPoint t |
		t := domain at: index.
		aPoint := aBlock value: t value: index.

		"`arcLength` receives the #+ in order to have a floating addition."
		arcLength := arcLength + (lastPoint distanceTo: aPoint).

		cumulativeArcLengths at: index put: arcLength.

		lastPoint := aPoint ].

	^ cumulativeArcLengths
]
