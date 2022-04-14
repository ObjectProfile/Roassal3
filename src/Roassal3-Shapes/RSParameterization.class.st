Class {
	#name : #RSParameterization,
	#superclass : #RSObject,
	#instVars : [
		'domain',
		'cumulativeArcLengths'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'as yet unclassified' }
RSParameterization >> arcLength [

	^ cumulativeArcLengths last
]

{ #category : #enumerating }
RSParameterization >> collect: aBlock [

	^ domain collect: aBlock
]

{ #category : #accessing }
RSParameterization >> cumulativeArcLengths [

	^ cumulativeArcLengths
]

{ #category : #accessing }
RSParameterization >> domain [

	^ domain
]

{ #category : #'as yet unclassified' }
RSParameterization >> parameterize_RSParametricLine: aLine [

	self subclassResponsibility
]

{ #category : #accessing }
RSParameterization >> size [

	^ domain size
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

		lastPoint := aPoint ]
]
