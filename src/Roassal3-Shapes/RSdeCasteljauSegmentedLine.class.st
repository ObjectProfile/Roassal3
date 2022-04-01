Class {
	#name : #RSdeCasteljauSegmentedLine,
	#superclass : #RSPolyline,
	#instVars : [
		'samples',
		'continuityLineSelectionBlock'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #accessing }
RSdeCasteljauSegmentedLine >> continuityLineSelectionBlock: anObject [

	continuityLineSelectionBlock := anObject
]

{ #category : #accessing }
RSdeCasteljauSegmentedLine >> controlPoints: aCollectionOfArrays [

	| beziers aBezier points |
	beziers := aCollectionOfArrays collect: [ :anArrayOfPoints | 
		           RSdeCasteljauLine new
			           samples: samples;
			           controlPoints: anArrayOfPoints;
			           yourself ].

	aBezier := beziers first.

	points := aBezier controlPoints.

	beziers allButFirstDo: [ :each | 
		aBezier := aBezier junction: each right: continuityLineSelectionBlock.
		points := points , aBezier controlPoints ].

	^ super controlPoints: points
]

{ #category : #initialization }
RSdeCasteljauSegmentedLine >> initialize [

	super initialize.

	self
		samples: 50;
		continuityLineSelectionBlock: [ :c0 :c1 :c2 | c1 ]
]

{ #category : #accessing }
RSdeCasteljauSegmentedLine >> samples: anObject [

	samples := anObject
]
