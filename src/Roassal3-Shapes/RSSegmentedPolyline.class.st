Class {
	#name : #RSSegmentedPolyline,
	#superclass : #RSPolyline,
	#instVars : [
		'samples',
		'continuityLineSelectionBlock',
		'lineBlock'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSSegmentedPolyline >> continuityLineSelectionBlock: anObject [

	continuityLineSelectionBlock := anObject
]

{ #category : #accessing }
RSSegmentedPolyline >> controlPoints: aCollectionOfArrays [

	| lines aLine points |
	lines := aCollectionOfArrays collect: lineBlock.

	aLine := lines first.

	points := aLine controlPoints.

	lines allButFirstDo: [ :each | 
		aLine := aLine junction: each right: continuityLineSelectionBlock.

		points := points , aLine controlPoints ].

	^ super controlPoints: points
]

{ #category : #initialization }
RSSegmentedPolyline >> initialize [

	super initialize.

	self continuityLineSelectionBlock: [ :c0 :c1 :c2 | c1 ]
]

{ #category : #accessing }
RSSegmentedPolyline >> lineBlock: anObject [

	lineBlock := anObject
]
