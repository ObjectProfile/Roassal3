Class {
	#name : #RSSegmentedPolyline,
	#superclass : #RSPolyline,
	#instVars : [
		'lineBlock',
		'junctionBlock'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSSegmentedPolyline >> controlPoints: aCollectionOfArrays [

	| lines aLine points |
	lines := aCollectionOfArrays collect: lineBlock.

	aLine := lines first.

	points := OrderedCollection withAll: aLine controlPoints.

	lines allButFirstDo: [ :each | 
		aLine := junctionBlock value: aLine value: each.

		points addAll: aLine controlPoints ].

	super controlPoints: points
]

{ #category : #accessing }
RSSegmentedPolyline >> junctionBlock: anObject [

	junctionBlock := anObject
]

{ #category : #accessing }
RSSegmentedPolyline >> lineBlock: anObject [

	lineBlock := anObject
]
